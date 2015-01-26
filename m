Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48252 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbbAZSMk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 13:12:40 -0500
Received: by mail-ob0-f169.google.com with SMTP id va8so9175946obc.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2015 10:12:39 -0800 (PST)
Date: Mon, 26 Jan 2015 12:12:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: reject MSI-X irqs
Message-ID: <20150126181236.GA4063@google.com>
References: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 26, 2015 at 11:54:44AM +0100, Lucas Stach wrote:
> The DW PCIe MSI hardware does not support MSI-X irqs. Setting those up
> failed as a side effect of a bug which was fixed by 91f8ae823f2b
> (PCI: designware: Setup and clear exactly one MSI at a time).
> 
> Now that this bug is fixed MSI-X irqs need to be rejected explicitly,
> otherwise devices trying to use them may end up with incorrectly working
> interrupts.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied with Jingoo's ack to pci/host-designware for v3.20, thanks!

> Cc: <stable@vger.kernel.org> # 3.18
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
> 
