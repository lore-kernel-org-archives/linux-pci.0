Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:29631 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeACAPD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 19:15:03 -0500
Date: Wed, 3 Jan 2018 08:14:26 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Romain Perier <romain.perier@collabora.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Peter Senna Tschudin <peter.senna@collabora.com>
Subject: [pci:pci/misc 8/8] drivers/scsi/mpt3sas/mpt3sas_base.c:3793:46:
 sparse: call with no type!
Message-ID: <201801030822.lR7aP4O0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/misc
head:   68c3658280583a703b54a619d364d21575da4d81
commit: 68c3658280583a703b54a619d364d21575da4d81 [8/8] PCI: Remove unused PCI pool macro functions
reproduce:
        # apt-get install sparse
        git checkout 68c3658280583a703b54a619d364d21575da4d81
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +3793 drivers/scsi/mpt3sas/mpt3sas_base.c

f92363d1 Sreekanth Reddy          2012-11-30  3715  
f92363d1 Sreekanth Reddy          2012-11-30  3716  /**
f92363d1 Sreekanth Reddy          2012-11-30  3717   * _base_release_memory_pools - release memory
f92363d1 Sreekanth Reddy          2012-11-30  3718   * @ioc: per adapter object
f92363d1 Sreekanth Reddy          2012-11-30  3719   *
f92363d1 Sreekanth Reddy          2012-11-30  3720   * Free memory allocated from _base_allocate_memory_pools.
f92363d1 Sreekanth Reddy          2012-11-30  3721   *
f92363d1 Sreekanth Reddy          2012-11-30  3722   * Return nothing.
f92363d1 Sreekanth Reddy          2012-11-30  3723   */
f92363d1 Sreekanth Reddy          2012-11-30  3724  static void
f92363d1 Sreekanth Reddy          2012-11-30  3725  _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
f92363d1 Sreekanth Reddy          2012-11-30  3726  {
9b05c91a Sreekanth Reddy          2014-09-12  3727  	int i = 0;
9b05c91a Sreekanth Reddy          2014-09-12  3728  	struct reply_post_struct *rps;
f92363d1 Sreekanth Reddy          2012-11-30  3729  
f92363d1 Sreekanth Reddy          2012-11-30  3730  	dexitprintk(ioc, pr_info(MPT3SAS_FMT "%s\n", ioc->name,
f92363d1 Sreekanth Reddy          2012-11-30  3731  	    __func__));
f92363d1 Sreekanth Reddy          2012-11-30  3732  
f92363d1 Sreekanth Reddy          2012-11-30  3733  	if (ioc->request) {
f92363d1 Sreekanth Reddy          2012-11-30  3734  		pci_free_consistent(ioc->pdev, ioc->request_dma_sz,
f92363d1 Sreekanth Reddy          2012-11-30  3735  		    ioc->request,  ioc->request_dma);
f92363d1 Sreekanth Reddy          2012-11-30  3736  		dexitprintk(ioc, pr_info(MPT3SAS_FMT
f92363d1 Sreekanth Reddy          2012-11-30  3737  			"request_pool(0x%p): free\n",
f92363d1 Sreekanth Reddy          2012-11-30  3738  			ioc->name, ioc->request));
f92363d1 Sreekanth Reddy          2012-11-30  3739  		ioc->request = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3740  	}
f92363d1 Sreekanth Reddy          2012-11-30  3741  
f92363d1 Sreekanth Reddy          2012-11-30  3742  	if (ioc->sense) {
e9d98418 Romain Perier            2017-07-06  3743  		dma_pool_free(ioc->sense_dma_pool, ioc->sense, ioc->sense_dma);
e9d98418 Romain Perier            2017-07-06  3744  		dma_pool_destroy(ioc->sense_dma_pool);
f92363d1 Sreekanth Reddy          2012-11-30  3745  		dexitprintk(ioc, pr_info(MPT3SAS_FMT
f92363d1 Sreekanth Reddy          2012-11-30  3746  			"sense_pool(0x%p): free\n",
f92363d1 Sreekanth Reddy          2012-11-30  3747  			ioc->name, ioc->sense));
f92363d1 Sreekanth Reddy          2012-11-30  3748  		ioc->sense = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3749  	}
f92363d1 Sreekanth Reddy          2012-11-30  3750  
f92363d1 Sreekanth Reddy          2012-11-30  3751  	if (ioc->reply) {
e9d98418 Romain Perier            2017-07-06  3752  		dma_pool_free(ioc->reply_dma_pool, ioc->reply, ioc->reply_dma);
e9d98418 Romain Perier            2017-07-06  3753  		dma_pool_destroy(ioc->reply_dma_pool);
f92363d1 Sreekanth Reddy          2012-11-30  3754  		dexitprintk(ioc, pr_info(MPT3SAS_FMT
f92363d1 Sreekanth Reddy          2012-11-30  3755  			"reply_pool(0x%p): free\n",
f92363d1 Sreekanth Reddy          2012-11-30  3756  			ioc->name, ioc->reply));
f92363d1 Sreekanth Reddy          2012-11-30  3757  		ioc->reply = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3758  	}
f92363d1 Sreekanth Reddy          2012-11-30  3759  
f92363d1 Sreekanth Reddy          2012-11-30  3760  	if (ioc->reply_free) {
e9d98418 Romain Perier            2017-07-06  3761  		dma_pool_free(ioc->reply_free_dma_pool, ioc->reply_free,
f92363d1 Sreekanth Reddy          2012-11-30  3762  		    ioc->reply_free_dma);
e9d98418 Romain Perier            2017-07-06  3763  		dma_pool_destroy(ioc->reply_free_dma_pool);
f92363d1 Sreekanth Reddy          2012-11-30  3764  		dexitprintk(ioc, pr_info(MPT3SAS_FMT
f92363d1 Sreekanth Reddy          2012-11-30  3765  			"reply_free_pool(0x%p): free\n",
f92363d1 Sreekanth Reddy          2012-11-30  3766  			ioc->name, ioc->reply_free));
f92363d1 Sreekanth Reddy          2012-11-30  3767  		ioc->reply_free = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3768  	}
f92363d1 Sreekanth Reddy          2012-11-30  3769  
9b05c91a Sreekanth Reddy          2014-09-12  3770  	if (ioc->reply_post) {
9b05c91a Sreekanth Reddy          2014-09-12  3771  		do {
9b05c91a Sreekanth Reddy          2014-09-12  3772  			rps = &ioc->reply_post[i];
9b05c91a Sreekanth Reddy          2014-09-12  3773  			if (rps->reply_post_free) {
e9d98418 Romain Perier            2017-07-06  3774  				dma_pool_free(
9b05c91a Sreekanth Reddy          2014-09-12  3775  				    ioc->reply_post_free_dma_pool,
9b05c91a Sreekanth Reddy          2014-09-12  3776  				    rps->reply_post_free,
9b05c91a Sreekanth Reddy          2014-09-12  3777  				    rps->reply_post_free_dma);
9b05c91a Sreekanth Reddy          2014-09-12  3778  				dexitprintk(ioc, pr_info(MPT3SAS_FMT
9b05c91a Sreekanth Reddy          2014-09-12  3779  				    "reply_post_free_pool(0x%p): free\n",
9b05c91a Sreekanth Reddy          2014-09-12  3780  				    ioc->name, rps->reply_post_free));
9b05c91a Sreekanth Reddy          2014-09-12  3781  				rps->reply_post_free = NULL;
9b05c91a Sreekanth Reddy          2014-09-12  3782  			}
9b05c91a Sreekanth Reddy          2014-09-12  3783  		} while (ioc->rdpq_array_enable &&
9b05c91a Sreekanth Reddy          2014-09-12  3784  			   (++i < ioc->reply_queue_count));
9b05c91a Sreekanth Reddy          2014-09-12  3785  
e9d98418 Romain Perier            2017-07-06  3786  		dma_pool_destroy(ioc->reply_post_free_dma_pool);
9b05c91a Sreekanth Reddy          2014-09-12  3787  		kfree(ioc->reply_post);
f92363d1 Sreekanth Reddy          2012-11-30  3788  	}
f92363d1 Sreekanth Reddy          2012-11-30  3789  
016d5c35 Suganath Prabu Subramani 2017-10-31  3790  	if (ioc->pcie_sgl_dma_pool) {
016d5c35 Suganath Prabu Subramani 2017-10-31  3791  		for (i = 0; i < ioc->scsiio_depth; i++) {
016d5c35 Suganath Prabu Subramani 2017-10-31  3792  			if (ioc->scsi_lookup[i].pcie_sg_list.pcie_sgl)
016d5c35 Suganath Prabu Subramani 2017-10-31 @3793  				pci_pool_free(ioc->pcie_sgl_dma_pool,
016d5c35 Suganath Prabu Subramani 2017-10-31  3794  				ioc->scsi_lookup[i].pcie_sg_list.pcie_sgl,
016d5c35 Suganath Prabu Subramani 2017-10-31  3795  				ioc->scsi_lookup[i].pcie_sg_list.pcie_sgl_dma);
016d5c35 Suganath Prabu Subramani 2017-10-31  3796  		}
016d5c35 Suganath Prabu Subramani 2017-10-31  3797  		if (ioc->pcie_sgl_dma_pool)
016d5c35 Suganath Prabu Subramani 2017-10-31  3798  			pci_pool_destroy(ioc->pcie_sgl_dma_pool);
016d5c35 Suganath Prabu Subramani 2017-10-31  3799  	}
016d5c35 Suganath Prabu Subramani 2017-10-31  3800  
f92363d1 Sreekanth Reddy          2012-11-30  3801  	if (ioc->config_page) {
f92363d1 Sreekanth Reddy          2012-11-30  3802  		dexitprintk(ioc, pr_info(MPT3SAS_FMT
f92363d1 Sreekanth Reddy          2012-11-30  3803  		    "config_page(0x%p): free\n", ioc->name,
f92363d1 Sreekanth Reddy          2012-11-30  3804  		    ioc->config_page));
f92363d1 Sreekanth Reddy          2012-11-30  3805  		pci_free_consistent(ioc->pdev, ioc->config_page_sz,
f92363d1 Sreekanth Reddy          2012-11-30  3806  		    ioc->config_page, ioc->config_page_dma);
f92363d1 Sreekanth Reddy          2012-11-30  3807  	}
f92363d1 Sreekanth Reddy          2012-11-30  3808  
f92363d1 Sreekanth Reddy          2012-11-30  3809  	if (ioc->scsi_lookup) {
f92363d1 Sreekanth Reddy          2012-11-30  3810  		free_pages((ulong)ioc->scsi_lookup, ioc->scsi_lookup_pages);
f92363d1 Sreekanth Reddy          2012-11-30  3811  		ioc->scsi_lookup = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3812  	}
f92363d1 Sreekanth Reddy          2012-11-30  3813  	kfree(ioc->hpr_lookup);
f92363d1 Sreekanth Reddy          2012-11-30  3814  	kfree(ioc->internal_lookup);
f92363d1 Sreekanth Reddy          2012-11-30  3815  	if (ioc->chain_lookup) {
f92363d1 Sreekanth Reddy          2012-11-30  3816  		for (i = 0; i < ioc->chain_depth; i++) {
f92363d1 Sreekanth Reddy          2012-11-30  3817  			if (ioc->chain_lookup[i].chain_buffer)
e9d98418 Romain Perier            2017-07-06  3818  				dma_pool_free(ioc->chain_dma_pool,
f92363d1 Sreekanth Reddy          2012-11-30  3819  				    ioc->chain_lookup[i].chain_buffer,
f92363d1 Sreekanth Reddy          2012-11-30  3820  				    ioc->chain_lookup[i].chain_buffer_dma);
f92363d1 Sreekanth Reddy          2012-11-30  3821  		}
e9d98418 Romain Perier            2017-07-06  3822  		dma_pool_destroy(ioc->chain_dma_pool);
f92363d1 Sreekanth Reddy          2012-11-30  3823  		free_pages((ulong)ioc->chain_lookup, ioc->chain_pages);
f92363d1 Sreekanth Reddy          2012-11-30  3824  		ioc->chain_lookup = NULL;
f92363d1 Sreekanth Reddy          2012-11-30  3825  	}
f92363d1 Sreekanth Reddy          2012-11-30  3826  }
f92363d1 Sreekanth Reddy          2012-11-30  3827  

:::::: The code at line 3793 was first introduced by commit
:::::: 016d5c35e27824f31c394009dd0f72f2c6b0dc85 scsi: mpt3sas: SGL to PRP Translation for I/Os to NVMe devices

:::::: TO: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
