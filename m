Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:58599 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbbCCDkw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 22:40:52 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so35844673obc.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2015 19:40:51 -0800 (PST)
Date: Mon, 2 Mar 2015 21:40:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Liviu Dudau <liviu@dudau.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 28/30] PCI: Export find_pci_host_bridge()
Message-ID: <20150303034048.GM11978@google.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-29-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424938344-4017-29-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 04:12:22PM +0800, Yijing Wang wrote:
> Export find_pci_host_bridge().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host-bridge.c |    2 +-
>  include/linux/pci.h       |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 4a2baa2..51e24f8 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -104,7 +104,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  	return bus;
>  }
>  
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)

Please name this "pci_find_host_bridge()" or similar so it looks like other
PCI functions.

>  {
>  	struct pci_bus *root_bus = find_pci_root_bus(bus);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2f29e95..6ac7926 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -426,6 +426,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>  struct pci_host_bridge *pci_create_host_bridge(
>  		struct device *parent, u32 dombus, struct list_head *resources, 
>  		void *sysdata, struct pci_host_bridge_ops *ops);
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus* bus);

I'm not sure this needs to be in include/linux/pci.h.  Wouldn't
drivers/pci/pci.h be enough?

>  /*
>   * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
>   * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
> -- 
> 1.7.1
> 
