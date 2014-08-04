Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60534 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750820AbaHDEWQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Aug 2014 00:22:16 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Date: Mon, 4 Aug 2014 12:21:55 +0800
Subject: RE: [PATCH] PCI: designware: check private_data validity in single
 place
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661A611CE5C38@EAPEX1MAIL1.st.com>
References: <1406884222-23974-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406884222-23974-1-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Friday, August 01, 2014 2:40 PM
> To: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas; Jingoo Han; Mohit KUMAR DCG; kernel@pengutronix.de
> Subject: [PATCH] PCI: designware: check private_data validity in single place
> 
> The driver had checks for this sprinkled all over. As we call
> sys_to_pcie() before every instance of this check, we can as well move the
> check to this single location to make things clear.
> 
> Removing the statements after BUG[_ON]() is safe as the kernel is halted at
> this point anyway.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Mohit Kumar <mohit.kumar@st.com>

Thanks,
Mohit

> ---
> This is a follow on patch to the series
> "PCI: designware: init order/resource alloc fixes", which addresses Jingoos
> review feedback, so this series should be hopefully good to go now.
> ---
>  drivers/pci/host/pcie-designware.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index dde5e6d4afa2..3dbfc089601d 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -73,6 +73,8 @@ static unsigned long global_io_offset;
> 
>  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)  {
> +	BUG_ON(!sys->private_data);
> +
>  	return sys->private_data;
>  }
> 
> @@ -261,11 +263,6 @@ static int assign_irq(int no_irqs, struct msi_desc
> *desc, int *pos)
>  	int irq, pos0, pos1, i;
>  	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
> 
> -	if (!pp) {
> -		BUG();
> -		return -EINVAL;
> -	}
> -
>  	pos0 = find_first_zero_bit(pp->msi_irq_in_use,
>  			MAX_MSI_IRQS);
>  	if (pos0 % no_irqs) {
> @@ -326,10 +323,6 @@ static void clear_irq(unsigned int irq)
>  	/* get the port structure */
>  	msi = irq_data_get_msi(data);
>  	pp = sys_to_pcie(msi->dev->bus->sysdata);
> -	if (!pp) {
> -		BUG();
> -		return;
> -	}
> 
>  	/* undo what was done in assign_irq */
>  	pos = data->hwirq;
> @@ -350,11 +343,6 @@ static int dw_msi_setup_irq(struct msi_chip *chip,
> struct pci_dev *pdev,
>  	struct msi_msg msg;
>  	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> 
> -	if (!pp) {
> -		BUG();
> -		return -EINVAL;
> -	}
> -
>  	pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
>  				&msg_ctr);
>  	msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4; @@ -716,11
> +704,6 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int
> where,
>  	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>  	int ret;
> 
> -	if (!pp) {
> -		BUG();
> -		return -EINVAL;
> -	}
> -
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
>  		*val = 0xffffffff;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -745,11 +728,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32
> devfn,
>  	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>  	int ret;
> 
> -	if (!pp) {
> -		BUG();
> -		return -EINVAL;
> -	}
> -
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> @@ -777,9 +755,6 @@ static int dw_pcie_setup(int nr, struct pci_sys_data
> *sys)
> 
>  	pp = sys_to_pcie(sys);
> 
> -	if (!pp)
> -		return 0;
> -
>  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
>  		pci_ioremap_io(global_io_offset, pp->io_base);
> --
> 2.0.1

