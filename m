Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34228 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758270AbdEWSoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 14:44:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so122718729pfj.1
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2017 11:44:04 -0700 (PDT)
Date: Tue, 23 May 2017 11:44:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170523184359.GB115572@google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I forgot, I had one more comment:

On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
> This patch checks the link status before reading and
> writing configure space of devices attached to the RC.
> If the link status is down, we shouldn't try to access
> the devices.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0e020b6..1e64227 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -275,9 +275,21 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
>  }
>  
> +static inline bool rockchip_pcie_link_up(struct rockchip_pcie *rockchip)
> +{
> +	return PCIE_LINK_UP(rockchip_pcie_read(rockchip,
> +					PCIE_CLIENT_BASIC_STATUS1));
> +}
> +
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> +	/* do not access the devices if the link isn't completed */
> +	if (bus->number != rockchip->root_bus_nr) {
> +		if (!rockchip_pcie_link_up(rockchip))
> +			return 0;

Not exactly a criticism of this patch directly, but the error handling
sequence that this triggers is strange, and I think it's inconsistent.

A 0 result here becomes PCIBIOS_DEVICE_NOT_FOUND for either the read or
write conf helpers. But the high level code doesn't handle this
consistently. See, e.g., pci_read_config_byte() which can return regular
Linux error codes (like -ENODEV), except it also passes up the return
code of pci_read_config_byte() (a PCIBIOS_* code) directly.

So callers don't really know whether to treat the value from
pci_read_config_<foo>() as a PCIBIOS_* code (which should be translated
with pcibios_err_to_errno()) or as a standard Linux errno.

But then, there are relatively few callers (less than 10% of
pci_read_config_<foo>(); even fewer for writes) that actually check the
error codes...

Maybe the "fix" is to replace -ENODEV with PCIBIOS_DEVICE_NOT_FOUND for
the inconsistent cases (pci_{read,write}_config_{byte,word,dword}()).

Brian

> +	}
> +
>  	/* access only one slot on each root port */
>  	if (bus->number == rockchip->root_bus_nr && dev > 0)
>  		return 0;
> -- 
> 1.9.1
> 
> 
