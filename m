Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52186 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbeFLTf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 15:35:57 -0400
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] r8169: Don't disable ASPM in the driver
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        romieu@fr.zoreil.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Message-ID: <caa66d98-e5cc-8bcd-1052-cef4ff00c32d@gmail.com>
Date: Tue, 12 Jun 2018 21:30:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12.06.2018 11:57, Kai-Heng Feng wrote:
> Enable or disable ASPM should be done in PCI core instead of in the
> device driver.
> 
> Commit ba04c7c93bbc ("r8169: disable ASPM") uses
> pci_disable_link_state() to disable ASPM. This is incorrect, if the
> device really needs to disable ASPM, we should use a quirk in PCI core
> to prevent the PCI core from setting ASPM altogether.
> 
I wouldn't call using pci_disable_link_state() in a driver incorrect
(as it works), there is just a better way which is more in line with
the PCI subsystem architecture.

> Let's remove pci_disable_link_state() for now. Use PCI core quirks if
> any regression happens.
> 
The vendor driver disables ASPM unconditionally for chip version 25
(there it's METHOD_9), so I think ASPM support is broken in this chip
version. I'll cook a PCI quirk.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please note that netdev is closed currently. Once 4.18-RC1 is out it
will be re-opened. Then please re-submit properly annotating PATCH
with "net-next" (I've forgotten this often enough myself).

> ---
> v2:
> - Remove module parameter.
> - Remove pci_disable_link_state().
> 
>  drivers/net/ethernet/realtek/r8169.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 75dfac0248f4..9b55ce513a36 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -25,7 +25,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/firmware.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/prefetch.h>
>  #include <linux/ipv6.h>
>  #include <net/ip6_checksum.h>
> @@ -7647,10 +7646,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mii->reg_num_mask = 0x1f;
>  	mii->supports_gmii = cfg->has_gmii;
>  
> -	/* disable ASPM completely as that cause random device stop working
> -	 * problems as well as full system hangs for some PCIe devices users */
> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
> -				     PCIE_LINK_STATE_CLKPM);
>  
>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
> 
