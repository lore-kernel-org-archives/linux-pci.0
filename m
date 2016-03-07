Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59889 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbcCGWdQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 17:33:16 -0500
Date: Mon, 7 Mar 2016 16:33:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr()
 on ARM
Message-ID: <20160307223311.GB26149@localhost>
References: <m337sapw89.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <m337sapw89.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Tue, Mar 01, 2016 at 07:07:18AM +0100, Krzysztof Hałasa wrote:
> Many ARM platforms use a wrapper:
> /*
>  * Compatibility wrapper for older platforms that do not care about
>  * passing the parent device.
>  */
> static inline void pci_common_init(struct hw_pci *hw)
> {
>         pci_common_init_dev(NULL, hw);
> }
> 
> which means that pci_bus_assign_domain_nr() can be called without
> a parent. This patch fixes the NULL pointer dereference.
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> Cc: stable@vger.kernel.org

I applied this to for-linus with changelog as below for v4.5, thanks!

Wow, this is terrible.  All ARM32 systems that use pci_common_init()
crash at boot.  That includes cns3xxx, dove, footbridge, iopl13xx,
ip32x, iop33x, ixp4xx, ks8695, mv78xx0, orion5x, pxa, sa1100, etc.
Apparently they've been crashing since v4.0, when 7c674700098c and
8c7d14746abc appeared.  I can hardly believe nobody noticed until now.

Actually, I did find one problem report:
http://forum.doozan.com/read.php?2,17868,22070,quote=1 from last May,
but apparently it got lost in a forum and never found its way
upstream.

I reworked the changelog because this problem will affect *any* arch
that enables CONFIG_PCI_DOMAINS_GENERIC and supplies NULL "parent"
pointers -- ia64, mips, mn10300, s390, x86, etc., would be affected if
they enabled CONFIG_PCI_DOMAINS_GENERIC.

I also added a "Fixes:" tag for 7c674700098c, since that's the commit
that added the generic code we're fixing.  Backports of 7c674700098c
should also backport this change.

Bjorn



commit 71babd2a89fe
Author: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Date:   Tue Mar 1 07:07:18 2016 +0100

    PCI: Allow a NULL "parent" pointer in pci_bus_assign_domain_nr()
    
    pci_create_root_bus() passes a "parent" pointer to
    pci_bus_assign_domain_nr().  When CONFIG_PCI_DOMAINS_GENERIC is defined,
    pci_bus_assign_domain_nr() dereferences that pointer.  Many callers of
    pci_create_root_bus() supply a NULL "parent" pointer, which leads to a NULL
    pointer dereference error.
    
    7c674700098c ("PCI: Move domain assignment from arm64 to generic code")
    moved the "parent" dereference from arm64 to generic code.  Only arm64 used
    that code (because only arm64 defined CONFIG_PCI_DOMAINS_GENERIC), and it
    always supplied a valid "parent" pointer.  Other arches supplied NULL
    "parent" pointers but didn't defined CONFIG_PCI_DOMAINS_GENERIC, so they
    used a no-op version of pci_bus_assign_domain_nr().
    
    8c7d14746abc ("ARM/PCI: Move to generic PCI domains") defined
    CONFIG_PCI_DOMAINS_GENERIC on ARM, and many ARM platforms use
    pci_common_init(), which supplies a NULL "parent" pointer.
    These platforms (cns3xxx, dove, footbridge, iop13xx, etc.) crash
    with a NULL pointer dereference like this while probing PCI:
    
      Unable to handle kernel NULL pointer dereference at virtual address 000000a4
      PC is at pci_bus_assign_domain_nr+0x10/0x84
      LR is at pci_create_root_bus+0x48/0x2e4
      Kernel panic - not syncing: Attempted to kill init!
    
    [bhelgaas: changelog, add "Reported:" and "Fixes:" tags]
    Reported: http://forum.doozan.com/read.php?2,17868,22070,quote=1
    Fixes: 8c7d14746abc ("ARM/PCI: Move to generic PCI domains")
    Fixes: 7c674700098c ("PCI: Move domain assignment from arm64 to generic code")
    Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# v4.0+

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..f89db3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4772,8 +4772,10 @@ int pci_get_new_domain_nr(void)
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = -1;
 
+	if (parent)
+		domain = of_get_pci_domain_nr(parent->of_node);
 	/*
 	 * Check DT domain and use_dt_domains values.
 	 *
