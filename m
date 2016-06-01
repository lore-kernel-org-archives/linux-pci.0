Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59995 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758472AbcFAPJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jun 2016 11:09:34 -0400
Date: Wed, 1 Jun 2016 10:09:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
Message-ID: <20160601150929.GA13882@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Wed, Jun 01, 2016 at 02:31:22PM +0200, Arnd Bergmann wrote:
> A lot of PCI host bridges require different methods for initiating
> type 0 and type 1 config space accesses, leading to duplication of
> code.
> 
> This adds support for the two different kinds at the pci_ops
> level, with the newly added map_bridge/read_bridge/write_bridge
> operations for type 1 accesses.
> 
> When these are not set, we fall back to the regular map_bus/read/write
> operations, so all existing drivers keep working, and bridges that
> have identical operations continue to only require one set.

This adds new config accessor functions to struct pci_ops and makes
the callers responsible for figuring out which one to use.  The
benefit is to reduce code duplication in some host bridge drivers
(DesignWare and MVEBU so far).

>From a design perspective, I'm not comfortable with moving this burden
from the host bridge drivers to the callers of the config accessors.

The pci_ops struct is a pretty low-level thing, but it is declared in
include/linux/pci.h and while I think it's ugly to use it outside the
PCI core, there's nothing that actually prevents that, and there are
several places that do use it, including at least the ones below.  We
could argue that many of these don't need updating because they don't
need .read_bridge() accessors, but I don't think pci_ops users should
be making assumptions like that.

  arch/sparc/kernel/pci_schizo.c: pbm->pci_ops->read(pbm->pci_bus, 0, PCI_STATUS, 2, &stat);
  arch/x86/pci/common.c:          return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
  arch/x86/pci/common.c:          return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
  arch/x86/pci/intel_mid_pci.c:           if (raw_pci_ext_ops->read(pci_domain_nr(bus), bus->number,
  arch/x86/pci/intel_mid_pci.c:                   raw_pci_ext_ops->read(pci_domain_nr(bus), bus->number,
  arch/x86/pci/intel_mid_pci.c:           raw_pci_ext_ops->read(domain, busnum, devfn,
  arch/x86/pci/intel_mid_pci.c:   return raw_pci_ext_ops->read(pci_domain_nr(bus), bus->number,
  arch/x86/pci/mmconfig-shared.c: raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0xce, 2, &win);
  arch/x86/pci/mmconfig-shared.c: raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0x48, 4, &pciexbar);
  arch/x86/pci/mmconfig-shared.c:         raw_pci_ops->read(0, bus, PCI_DEVFN(0, 0), 0, 4, &l);
  arch/x86/pci/mmconfig-shared.c:         raw_pci_ops->read(0, bus, PCI_DEVFN(0, 0), extcfg_regnum,
  arch/x86/pci/mmconfig-shared.c:         raw_pci_ops->read(0, bus, devfn, 0, 4, &l);
  drivers/pci/access.c:   res = bus->ops->read(bus, devfn, pos, len, &data);              \
  drivers/pci/access.c:   ret = dev->bus->ops->read(dev->bus, dev->devfn,                 \
  drivers/pci/access.c:   return dev->vpd->ops->read(dev, pos, count, buf);
  drivers/pci/pci.c:      bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
  drivers/pci/pcie/aer/aer_inject.c:      rv = ops->read(bus, devfn, where, size, val);

> In most cases, a driver will only have to override either map_bridge
> or read_bridge/write_bridge but not both.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is slightly refined over what I had in the "Add PCIe driver for
> Rockchip Soc" thread earlier, but probably not the final version yet,
> so I'd like to get more feedback on it.
> 
> In particular, I think it may be useful to add a third set of
> functions for the config space of devices that are directly attached
> to the host bridge, as those are sometimes (designware, rcar, mvebu)
> yet again different from the host bridge itself and from all other
> devices. On the other hand, that adds further complexity that we
> may want to leave out of the common code, and I honestly can't
> seem to come up for a catchy name form the callbacks.
> 
>  drivers/pci/access.c | 35 +++++++++++++++++++++++++++--------
>  include/linux/pci.h  |  3 +++
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb8fba3..263606ece211 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -34,9 +34,12 @@ int pci_bus_read_config_##size \
>  	u32 data = 0;							\
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
>  	raw_spin_lock_irqsave(&pci_lock, flags);			\
> -	res = bus->ops->read(bus, devfn, pos, len, &data);		\
> +	if (!bus->parent == 0 && bus->ops->read_bridge)			\

  if (!bus->parent && ...) ?

> +		res = bus->ops->read_bridge(bus, devfn, pos, len, &data);	\
> +	else								\
> +		res = bus->ops->read(bus, devfn, pos, len, &data);	\
>  	*value = (type)data;						\
> -	raw_spin_unlock_irqrestore(&pci_lock, flags);		\
> +	raw_spin_unlock_irqrestore(&pci_lock, flags);			\
>  	return res;							\
>  }
