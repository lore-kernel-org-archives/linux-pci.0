Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62014 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbAZLTC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 06:19:02 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NIS00IVG7FCNE60@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 26 Jan 2015 20:18:49 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH] PCI: designware: reject MSI-X irqs
Date: Mon, 26 Jan 2015 20:19:19 +0900
Message-id: <01b201d03959$edc30d00$c9492700$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, January 26, 2015 7:55 PM, Lucas Stach wrote:
> 
> The DW PCIe MSI hardware does not support MSI-X irqs. Setting those up
> failed as a side effect of a bug which was fixed by 91f8ae823f2b
> (PCI: designware: Setup and clear exactly one MSI at a time).
> 
> Now that this bug is fixed MSI-X irqs need to be rejected explicitly,
> otherwise devices trying to use them may end up with incorrectly working
> interrupts.

Right.

> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: <stable@vger.kernel.org> # 3.18

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index df781cdf13c1..17ca98657a28 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -283,6 +283,9 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>  	struct msi_msg msg;
>  	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> 
> +	if (desc->msi_attrib.is_msix)
> +		return -EINVAL;
> +
>  	irq = assign_irq(1, desc, &pos);
>  	if (irq < 0)
>  		return irq;
> --
> 2.1.4

