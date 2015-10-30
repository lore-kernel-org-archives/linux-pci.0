Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Oct 2015 13:18:37 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] PCI: Fix sriov_enable() error path for
 pcibios_enable_sriov() failures
Message-ID: <20151030051837.GE5119@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222329.11908.72848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029222329.11908.72848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 05:23:29PM -0500, Bjorn Helgaas wrote:
>From: Alexander Duyck <aduyck@mirantis.com>
>
>Disable VFs if pcibios_enable_sriov() fails, just like we do for other
>errors in sriov_enable().  Call pcibios_sriov_disable() if virtfn_add()
>fails.
>
>[bhelgaas: changelog, split to separate patch for reviewability]
>Fixes: 995df527f399 ("PCI: Add pcibios_sriov_enable() and pcibios_sriov_disable()")
>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |   11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 24428d5..bd1c4fa 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -246,7 +246,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	struct pci_sriov *iov = dev->sriov;
> 	int bars = 0;
> 	int bus;
>-	int retval;
>
> 	if (!nr_virtfn)
> 		return 0;
>@@ -315,10 +314,10 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	if (nr_virtfn < initial)
> 		initial = nr_virtfn;
>
>-	if ((retval = pcibios_sriov_enable(dev, initial))) {
>-		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
>-			retval);
>-		return retval;
>+	rc = pcibios_sriov_enable(dev, initial);
>+	if (rc) {
>+		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n", rc);
>+		goto err_pcibios;
> 	}
>
> 	for (i = 0; i < initial; i++) {
>@@ -336,6 +335,8 @@ failed:
> 	while (i--)
> 		virtfn_remove(dev, i, 0);
>
>+	pcibios_sriov_disable(dev);
>+err_pcibios:
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);

-- 
Richard Yang
Help you, Help me

