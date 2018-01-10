Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:31104
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751654AbeAJRzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jan 2018 12:55:52 -0500
From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>
To: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC: "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "Jay.Cornwall@amd.com" <Jay.Cornwall@amd.com>,
        "Amrani, Ram" <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>
Subject: RE: [PATCH 2/2] RDMA/qedr: Use pci_enable_atomic_ops_to_root
Date: Wed, 10 Jan 2018 17:55:48 +0000
Message-ID: <CY1PR0701MB2012CD5C4AF64EBB676AB58F88110@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
 <1515113100-4718-2-git-send-email-Felix.Kuehling@amd.com>
 <BN3PR07MB257831D393762213E1E440DAF8100@BN3PR07MB2578.namprd07.prod.outlook.com>
In-Reply-To: <BN3PR07MB257831D393762213E1E440DAF8100@BN3PR07MB2578.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Felix Kuehling [mailto:Felix.Kuehling@amd.com]
> Sent: Friday, January 05, 2018 2:45 AM
>
> Use common helper function pci_enable_atomic_ops_to_root to enable
> atomic capability.
>
> CC: Bjorn Helgaas <helgaas@kernel.org>
> CC: Ram Amrani <Ram.Amrani@cavium.com>
> CC: Doug Ledford <dledford@redhat.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 59
> ++++++---------------------------------
>  1 file changed, 8 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 50812b3..b378647 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -430,59 +430,16 @@ static void qedr_remove_sysfiles(struct qedr_dev
> *dev)
>
>  static void qedr_pci_set_atomic(struct qedr_dev *dev, struct pci_dev
> *pdev)  {
> -	struct pci_dev *bridge;
> -	u32 ctl2, cap2;
> -	u16 flags;
> -	int rc;
> -
> -	bridge =3D pdev->bus->self;
> -	if (!bridge)
> -		goto disable;
> -
> -	/* Check atomic routing support all the way to root complex */
> -	while (bridge->bus->parent) {
> -		rc =3D pcie_capability_read_word(bridge, PCI_EXP_FLAGS,
&flags);
> -		if (rc || ((flags & PCI_EXP_FLAGS_VERS) < 2))
> -			goto disable;
> -
> -		rc =3D pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2,
&cap2);
> -		if (rc)
> -			goto disable;
> +	int rc =3D pci_enable_atomic_ops_to_root(pdev,
> +
PCI_EXP_DEVCAP2_ATOMIC_COMP64);
>
> -		rc =3D pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
> &ctl2);
> -		if (rc)
> -			goto disable;
> -
> -		if (!(cap2 & PCI_EXP_DEVCAP2_ATOMIC_ROUTE) ||
> -		    (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK))
> -			goto disable;
> -		bridge =3D bridge->bus->parent->self;
> +	if (rc) {
> +		dev->atomic_cap =3D IB_ATOMIC_NONE;
> +		DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability
disabled\n");
> +	} else {
> +		dev->atomic_cap =3D IB_ATOMIC_GLOB;
> +		DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability
enabled\n");
>  	}
> -
> -	rc =3D pcie_capability_read_word(bridge, PCI_EXP_FLAGS, &flags);
> -	if (rc || ((flags & PCI_EXP_FLAGS_VERS) < 2))
> -		goto disable;
> -
> -	rc =3D pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap2);
> -	if (rc || !(cap2 & PCI_EXP_DEVCAP2_ATOMIC_COMP64))
> -		goto disable;
> -
> -	/* Set atomic operations */
> -	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> -				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> -	dev->atomic_cap =3D IB_ATOMIC_GLOB;
> -
> -	DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability enabled\n");
> -
> -	return;
> -
> -disable:
> -	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> -				   PCI_EXP_DEVCTL2_ATOMIC_REQ);
> -	dev->atomic_cap =3D IB_ATOMIC_NONE;
> -
> -	DP_DEBUG(dev, QEDR_MSG_INIT, "Atomic capability disabled\n");
> -
>  }
>
>  static const struct qed_rdma_ops *qed_ops;
> --
> 2.7.4

Thanks,

Acked-by: Michal Kalderon <michal.kalderon@cavium.com>
