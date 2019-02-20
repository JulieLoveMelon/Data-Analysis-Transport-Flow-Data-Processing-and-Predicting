function recon_data = pca_reconstruct(pcs, cprs_data, cprs_c)
[~,N]=size(cprs_data);
X=(pcs*cprs_data)';
recon_data=X*diag(cprs_c(2,:))+ones(N,1)*cprs_c(1,:);
end