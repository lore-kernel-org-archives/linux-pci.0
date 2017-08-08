Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42483 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdHHMpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 08:45:40 -0400
Subject: Re: [PATCHv2 2/6] PCI: designware: enable write permission before
 updating class code
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-3-git-send-email-Zhiqiang.Hou@nxp.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <20d204aa-027f-6d90-7eeb-b9c86d62df62@synopsys.com>
Date: Tue, 8 Aug 2017 13:45:34 +0100
MIME-Version: 1.0
In-Reply-To: <1501748620-42866-3-git-send-email-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 9:23 AM de 8/3/2017, Zhiqiang Hou escreveu:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The existing fix doesn't actually work because the Class register is
> read-only, so it must enable the write permission before write the
> correct value to this register.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - None
> 
>  drivers/pci/dwc/pcie-designware-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index d29c020..6e10cda 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -634,8 +634,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>  
> +	/* Enable write permission for the DBI read-only register */
> +	dw_pcie_dbi_ro_wr_en(pci);
>  	/* program correct class for RC */
>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> +	/* Better disable write permission right after the update */
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |= PORT_LOGIC_SPEED_CHANGE;
> 

Acked-By: Joao Pinto <jpinto@synopsys.com>
