Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36154 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbcFTTFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 15:05:35 -0400
Date: Mon, 20 Jun 2016 14:05:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Document connection between pci_power_t and
 hardware PM capability
Message-ID: <20160620190445.GA15674@localhost>
References: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1466336986.30123.164.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466336986.30123.164.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 19, 2016 at 02:49:46PM +0300, Andy Shevchenko wrote:
> On Sat, 2016-06-18 at 13:00 -0500, Bjorn Helgaas wrote:
> > The dev.pme_support field, pci_pm_init(), and pci_pme_capable() depend
> > on
> > the fact that the pci_power_t values (PCI_D0, PCI_D1, etc.) match the
> > definition of the PME_Support field of the Power Management
> > Capabilities
> > register in the Power Management capability (see PCI Bus Power
> > Management
> > spec r1.2, sec 3.2.3).
> 
> Nice to know! Thanks.
> 
> If it matters:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Definitely!  I updated based on Lukas' comment and added your and Mika's
Reviewed-by:

commit 224abb67e6eb5ac062de9239163136d5ec3155c8
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jun 17 15:23:52 2016 -0500

    PCI: Document connection between pci_power_t and hardware PM capability
    
    The dev.pme_support field, pci_pm_init(), pci_pme_capable(), and
    pci_raw_set_power_state() depend on the fact that the pci_power_t values
    (PCI_D0, PCI_D1, etc.) match the definition of the Capabilities PME_Support
    and the Control/Status PowerState fields in the Power Management capability
    (see PCI Bus Power Management spec r1.2, sec 3.2.3).
    
    Add a note to this effect at the pci_power_t typedef.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8597b42..0a1a9e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -101,6 +101,10 @@ enum {
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
+/*
+ * pci_power_t values must match the bits in the Capabilities PME_Support
+ * and Control/Status PowerState fields in the Power Management capability.
+ */
 typedef int __bitwise pci_power_t;
 
 #define PCI_D0		((pci_power_t __force) 0)
