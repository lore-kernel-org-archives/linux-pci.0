Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35852 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcDZUp4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 16:45:56 -0400
MIME-Version: 1.0
In-Reply-To: <1461578004-129094-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
	<1461578004-129094-2-git-send-email-mika.westerberg@linux.intel.com>
Date: Tue, 26 Apr 2016 22:45:54 +0200
Message-ID: <CAJZ5v0htAg28F8a5KXTLhH-U65+nGEgxY1u5tWaUtRt6JGgeOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] PCI: No need to set d3cold_allowed to PCIe ports
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 25, 2016 at 11:53 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> The Linux PCI core skips PCI bridges and PCIe ports when system is
> suspended. The PCI core checks return value of pci_has_subordinate() in
> pci_pm_suspend_noirq() to skip all devices where it is non-zero (which
> means PCI bridges and PCIe ports).
>
> Since PCIe ports are never suspended in the first place, there is no need
> to set d3cold_allowed for them.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pcie/portdrv_pci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index be35da2e105e..6c6bb03392ea 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -134,11 +134,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>                 return status;
>
>         pci_save_state(dev);
> -       /*
> -        * D3cold may not work properly on some PCIe port, so disable
> -        * it by default.
> -        */
> -       dev->d3cold_allowed = false;
>         return 0;
>  }
>
> --
> 2.8.0.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
