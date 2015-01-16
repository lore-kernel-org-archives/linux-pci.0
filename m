Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57557 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbbAPKNN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 05:13:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Liviu Dudau <liviu@dudau.co.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/28] Refine PCI scan interfaces and make generic pci host bridge
Date: Fri, 16 Jan 2015 11:12:43 +0100
Message-ID: <3853153.SqP6BVNhms@wuerfel>
In-Reply-To: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 16 January 2015 09:43:58 Yijing Wang wrote:
> This series is based on Bjorn's pci-next branch.

I think this is a very nice series, hope we can get this into 3.20.

I've replied with a few specific comments, but I see no show-stoppers
and I've already retracted a few comments after seeing the bigger
picture.

> After applied this series, we have following scan interfaces:
> 
> 1. pci_scan_bus_legacy() 
>    parent = NULL, default io/mem/bus resources.
>    for legacy pci scan
> 
> 2. pci_scan_root_bus()
>    for callers provide its own parent and io/mem/bus resources
>    but no platform specific pci_host_bridge operations
> 
> 3. pci_scan_root_bridge()
>    for callers provide its own parent and io/mem/bus resources
>    and pci_host_bridge_ops.

I still think we will need a split interface for drivers to use
that want to call pci_create_host_bridge() manually, but that can
come later as we try to migrate the arm32 host bridge drivers to
a generic interface away from pci_common_init_dev().

Another follow-up would be to move more of the pcibios_*() functions
into pci_host_bridge_ops.

	Arnd
