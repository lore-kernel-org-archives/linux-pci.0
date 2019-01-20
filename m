Return-Path: <SRS0=1Q+I=P4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E2BC676F4
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF7C20880
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfATOt2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:49:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbfATOt2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Jan 2019 09:49:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E1783DE03;
        Sun, 20 Jan 2019 14:49:27 +0000 (UTC)
Received: from redhat.com (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 97B12171A2;
        Sun, 20 Jan 2019 14:49:25 +0000 (UTC)
Date:   Sun, 20 Jan 2019 09:49:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xuyandong <xuyandong2@huawei.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Ofer Hayut <ofer@lightbitslabs.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Keith Busch <keith.busch@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v3] PCI: avoid bridge feature re-probing on hotplug
Message-ID: <20190120094901-mutt-send-email-mst@kernel.org>
References: <20181218004455.20186-1-mst@redhat.com>
 <20190119201259.GA87988@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119201259.GA87988@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 20 Jan 2019 14:49:27 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Will do within a week, thanks a lot!

On Sat, Jan 19, 2019 at 02:12:59PM -0600, Bjorn Helgaas wrote:
> I gave up trying to reproduce the problem and test this patch with qemu;
> can you guys (Michael and Xu (sorry if I mangled your name)) give this a
> try?
> 
> I cc'd a few other people who have noticed this issue in the past, so just
> FYI for them.
> 
> Bjorn
> 
> 
> commit dd21b922db366ba069291b6fef2a8ce6768756a2
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Sat Jan 19 11:35:04 2019 -0600
> 
>     PCI: Probe bridge window attributes once at enumeration-time
>     
>     pci_bridge_check_ranges() determines whether a bridge supports the optional
>     I/O and prefetchable memory windows and sets the flag bits in the bridge
>     resources.  This could be done once during enumeration except that the
>     resource allocation code completely clears the flag bits, e.g., in the
>     pci_assign_unassigned_bridge_resources() path.
>     
>     The problem was that in some cases pci_bridge_check_ranges() *changes* the
>     window registers to determine whether they're writable, and this may break
>     concurrent accesses to devices behind the bridge.
>     
>     Add a new pci_read_bridge_windows() to determine whether a bridge supports
>     the optional windows, call it once during enumeration, remember the
>     results, and change pci_bridge_check_ranges() to set the flag bits based on
>     those remembered results.
>     
>     Link: https://lore.kernel.org/linux-pci/1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com
>     Link: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02082.html
>     Reported-by: xuyandong <xuyandong2@huawei.com>
>     Cc: Sagi Grimberg <sagi@grimberg.me>
>     Cc: Ofer Hayut <ofer@lightbitslabs.com>
>     Cc: Roy Shterman <roys@lightbitslabs.com>
>     Cc: Keith Busch <keith.busch@intel.com>
>     Cc: Zhou Wang <wangzhou1@hisilicon.com>
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6f2ebb..2ef8b954c65a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -348,6 +348,57 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	}
>  }
>  
> +static void pci_read_bridge_windows(struct pci_dev *bridge)
> +{
> +	u16 io;
> +	u32 pmem, tmp;
> +
> +	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> +	if (!io) {
> +		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> +		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> +		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> +	}
> +	if (io)
> +		bridge->io_window = 1;
> +
> +	/*
> +	 * DECchip 21050 pass 2 errata: the bridge may miss an address
> +	 * disconnect boundary by one PCI data phase.  Workaround: do not
> +	 * use prefetching on this device.
> +	 */
> +	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
> +		return;
> +
> +	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> +	if (!pmem) {
> +		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> +					       0xffe0fff0);
> +		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> +		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
> +	}
> +	if (!pmem)
> +		return;
> +
> +	bridge->pref_window = 1;
> +
> +	if ((pmem & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
> +
> +		/*
> +		 * Bridge claims to have a 64-bit prefetchable memory
> +		 * window; verify that the upper bits are actually
> +		 * writable.
> +		 */
> +		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &pmem);
> +		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> +				       0xffffffff);
> +		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
> +		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, pmem);
> +		if (tmp)
> +			bridge->pref_64_window = 1;
> +	}
> +}
> +
>  static void pci_read_bridge_io(struct pci_bus *child)
>  {
>  	struct pci_dev *dev = child->self;
> @@ -1739,6 +1790,7 @@ int pci_setup_device(struct pci_dev *dev)
>  		pci_read_irq(dev);
>  		dev->transparent = ((dev->class & 0xff) == 1);
>  		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
> +		pci_read_bridge_windows(dev);
>  		set_pcie_hotplug_bridge(dev);
>  		pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
>  		if (pos) {
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436df5e..1941bb0a6c13 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -735,58 +735,21 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
>     base/limit registers must be read-only and read as 0. */
>  static void pci_bridge_check_ranges(struct pci_bus *bus)
>  {
> -	u16 io;
> -	u32 pmem;
>  	struct pci_dev *bridge = bus->self;
> -	struct resource *b_res;
> +	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>  
> -	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>  	b_res[1].flags |= IORESOURCE_MEM;
>  
> -	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> -	if (!io) {
> -		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
> -		pci_read_config_word(bridge, PCI_IO_BASE, &io);
> -		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
> -	}
> -	if (io)
> +	if (bridge->io_window)
>  		b_res[0].flags |= IORESOURCE_IO;
>  
> -	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
> -	    disconnect boundary by one PCI data phase.
> -	    Workaround: do not use prefetching on this device. */
> -	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
> -		return;
> -
> -	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> -	if (!pmem) {
> -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
> -					       0xffe0fff0);
> -		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
> -		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
> -	}
> -	if (pmem) {
> +	if (bridge->pref_window) {
>  		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
> -		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
> -		    PCI_PREF_RANGE_TYPE_64) {
> +		if (bridge->pref_64_window) {
>  			b_res[2].flags |= IORESOURCE_MEM_64;
>  			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
>  		}
>  	}
> -
> -	/* double check if bridge does support 64 bit pref */
> -	if (b_res[2].flags & IORESOURCE_MEM_64) {
> -		u32 mem_base_hi, tmp;
> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -					 &mem_base_hi);
> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -					       0xffffffff);
> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
> -		if (!tmp)
> -			b_res[2].flags &= ~IORESOURCE_MEM_64;
> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
> -				       mem_base_hi);
> -	}
>  }
>  
>  /* Helper function for sizing routines: find first available
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f082..40b327b814aa 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -373,6 +373,9 @@ struct pci_dev {
>  	bool		match_driver;		/* Skip attaching driver */
>  
>  	unsigned int	transparent:1;		/* Subtractive decode bridge */
> +	unsigned int	io_window:1;		/* Bridge has I/O window */
> +	unsigned int	pref_window:1;		/* Bridge has pref mem window */
> +	unsigned int	pref_64_window:1;	/* Pref mem window is 64-bit */
>  	unsigned int	multifunction:1;	/* Multi-function device */
>  
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
