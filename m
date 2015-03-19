Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34336 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCSPUQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 11:20:16 -0400
Received: by obbgg8 with SMTP id gg8so56880311obb.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 08:20:15 -0700 (PDT)
Date: Thu, 19 Mar 2015 10:20:13 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: liviu@dudau.co.uk, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [Update PATCH] PCI: Assign resources before drivers claim
 devices (pci_scan_root_bus())
Message-ID: <20150319152013.GF26935@google.com>
References: <1426475936-13017-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426475936-13017-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:18:56AM +0800, Yijing Wang wrote:
> Previously, pci_scan_root_bus() created a root PCI bus, enumerated the
> devices on it, and called pci_bus_add_devices(), which made the devices
> available for drivers to claim them.
> 
> Most callers assigned resources to devices after pci_scan_root_bus()
> returns, which may be after drivers have claimed the devices.  This is
> incorrect; the PCI core should not change device resources while a driver
> is managing the device.
> 
> Remove pci_bus_add_devices() from pci_scan_root_bus() and do it after any
> resource assignment in the callers.
> 
> Note that ARM's pci_common_init_dev() already called pci_bus_add_devices()
> after pci_scan_root_bus(), so we only need to remove the first call:
> 
>   pci_common_init_dev
>     pcibios_init_hw
>       pci_scan_root_bus
>         pci_bus_add_devices        # first call
>     pci_bus_assign_resources
>     pci_bus_add_devices            # second call
> 
> [bhelgaas: changelog, drop "root_bus" var in alpha common_init_pci(),
> return failure earlier in mn10300, add "return" in x86 pcibios_scan_root(),
> return early if xtensa platform_pcibios_fixup() fails]
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> CC: Matt Turner <mattst88@gmail.com>
> CC: David Howells <dhowells@redhat.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
> CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Chris Metcalf <cmetcalf@ezchip.com>
> CC: Chris Zankel <chris@zankel.net>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/alpha/kernel/pci.c          |    7 +++++++
>  arch/frv/mb93090-mb00/pci-vdk.c  |    6 +++++-
>  arch/ia64/sn/kernel/io_init.c    |    2 ++
>  arch/microblaze/pci/pci-common.c |    4 ++++
>  arch/mips/pci/pci.c              |    1 +
>  arch/mn10300/unit-asb2305/pci.c  |    6 +++++-
>  arch/s390/pci/pci.c              |    2 +-
>  arch/sh/drivers/pci/pci.c        |    1 +
>  arch/sparc/kernel/leon_pci.c     |    1 +
>  arch/tile/kernel/pci.c           |    2 ++
>  arch/tile/kernel/pci_gx.c        |    2 ++
>  arch/x86/pci/common.c            |    2 ++
>  arch/xtensa/kernel/pci.c         |   15 +++++++++++++--
>  drivers/pci/host/pci-versatile.c |    1 +
>  drivers/pci/probe.c              |    1 -
>  15 files changed, 47 insertions(+), 6 deletions(-)

Applied to pci/enumeration for v4.1.  This adds a fix for versatile.

Bjorn
