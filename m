Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Aug 2015 17:30:39 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 2/3] QIB: Removing usage of pcie_set_mps()
Message-ID: <20150817223039.GK26431@google.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
 <1438208335-19457-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438208335-19457-3-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Mike, linux-rdma]

On Wed, Jul 29, 2015 at 04:18:54PM -0600, Keith Busch wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> This is in perperation of un-exporting the pcie_set_mps() function
> symbol. A driver should not be changing the MPS as that is the
> responsibility of the PCI subsystem.

Please explain the implications of removing this code.  Does this affect
performance of the device?  If so, how do we get that performance back?

I also cc'd the QIB maintainers for you:

  QIB DRIVER
  M:      Mike Marciniszyn <infinipath@intel.com>
  L:      linux-rdma@vger.kernel.org
  F:      drivers/infiniband/hw/qib/

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/infiniband/hw/qib/qib_pcie.c |   27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
> index 4758a38..b8a2dcd 100644
> --- a/drivers/infiniband/hw/qib/qib_pcie.c
> +++ b/drivers/infiniband/hw/qib/qib_pcie.c
> @@ -557,12 +557,11 @@ static void qib_tune_pcie_coalesce(struct qib_devdata *dd)
>   */
>  static int qib_pcie_caps;
>  module_param_named(pcie_caps, qib_pcie_caps, int, S_IRUGO);
> -MODULE_PARM_DESC(pcie_caps, "Max PCIe tuning: Payload (0..3), ReadReq (4..7)");
> +MODULE_PARM_DESC(pcie_caps, "Max PCIe tuning: ReadReq (4..7)");
>  
>  static void qib_tune_pcie_caps(struct qib_devdata *dd)
>  {
>  	struct pci_dev *parent;
> -	u16 rc_mpss, rc_mps, ep_mpss, ep_mps;
>  	u16 rc_mrrs, ep_mrrs, max_mrrs;
>  
>  	/* Find out supported and configured values for parent (root) */
> @@ -575,30 +574,6 @@ static void qib_tune_pcie_caps(struct qib_devdata *dd)
>  	if (!pci_is_pcie(parent) || !pci_is_pcie(dd->pcidev))
>  		return;
>  
> -	rc_mpss = parent->pcie_mpss;
> -	rc_mps = ffs(pcie_get_mps(parent)) - 8;
> -	/* Find out supported and configured values for endpoint (us) */
> -	ep_mpss = dd->pcidev->pcie_mpss;
> -	ep_mps = ffs(pcie_get_mps(dd->pcidev)) - 8;
> -
> -	/* Find max payload supported by root, endpoint */
> -	if (rc_mpss > ep_mpss)
> -		rc_mpss = ep_mpss;
> -
> -	/* If Supported greater than limit in module param, limit it */
> -	if (rc_mpss > (qib_pcie_caps & 7))
> -		rc_mpss = qib_pcie_caps & 7;
> -	/* If less than (allowed, supported), bump root payload */
> -	if (rc_mpss > rc_mps) {
> -		rc_mps = rc_mpss;
> -		pcie_set_mps(parent, 128 << rc_mps);
> -	}
> -	/* If less than (allowed, supported), bump endpoint payload */
> -	if (rc_mpss > ep_mps) {
> -		ep_mps = rc_mpss;
> -		pcie_set_mps(dd->pcidev, 128 << ep_mps);
> -	}
> -
>  	/*
>  	 * Now the Read Request size.
>  	 * No field for max supported, but PCIe spec limits it to 4096,
> -- 
> 1.7.10.4
> 
