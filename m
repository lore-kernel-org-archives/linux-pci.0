Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25710 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756132AbcIGQSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Sep 2016 12:18:08 -0400
Date: Wed, 7 Sep 2016 12:28:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv2 2/4] pci: No config access for removed devices
Message-ID: <20160907162859.GA28381@localhost.localdomain>
References: <1473199219-3369-3-git-send-email-keith.busch@intel.com>
 <201609072050.VbWFO505%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201609072050.VbWFO505%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 07, 2016 at 08:03:32PM +0800, kbuild test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    arch/mips/txx9/generic/pci.c: In function 'early_read_config_word':
> >> arch/mips/txx9/generic/pci.c:49:1: error: the frame size of 1528 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>     }
>     ^
>
>    cc1: all warnings being treated as errors
> 
> vim +49 arch/mips/txx9/generic/pci.c
> 
> 89d63fe1 Atsushi Nemoto 2008-07-11  33  	struct pci_bus fake_bus;
> 89d63fe1 Atsushi Nemoto 2008-07-11  34  
> 89d63fe1 Atsushi Nemoto 2008-07-11  35  	fake_dev.bus = &fake_bus;
> 89d63fe1 Atsushi Nemoto 2008-07-11  36  	fake_dev.sysdata = hose;
> 89d63fe1 Atsushi Nemoto 2008-07-11  37  	fake_dev.devfn = devfn;
> 89d63fe1 Atsushi Nemoto 2008-07-11  38  	fake_bus.number = bus;
> 89d63fe1 Atsushi Nemoto 2008-07-11  39  	fake_bus.sysdata = hose;
> 89d63fe1 Atsushi Nemoto 2008-07-11  40  	fake_bus.ops = hose->pci_ops;
> 89d63fe1 Atsushi Nemoto 2008-07-11  41  
> 89d63fe1 Atsushi Nemoto 2008-07-11  42  	if (bus != top_bus)
> 89d63fe1 Atsushi Nemoto 2008-07-11  43  		/* Fake a parent bus structure. */
> 89d63fe1 Atsushi Nemoto 2008-07-11  44  		fake_bus.parent = &fake_bus;
> 89d63fe1 Atsushi Nemoto 2008-07-11  45  	else
> 89d63fe1 Atsushi Nemoto 2008-07-11  46  		fake_bus.parent = NULL;
> 89d63fe1 Atsushi Nemoto 2008-07-11  47  
> 89d63fe1 Atsushi Nemoto 2008-07-11  48  	return pci_read_config_word(&fake_dev, offset, value);
> 89d63fe1 Atsushi Nemoto 2008-07-11 @49  }


Hmm, why is this function allocating such large structures on the
stack? It looks like the size of struct pci_dev and struct pci_bus
already exceeded 1024 bytes.

I have no hardware to test this, but it looks to me there is no reason to
have struct pci_dev and the following should save quite a bite of space:

---
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 1f6bc9a..285d84e 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -29,12 +29,8 @@ static int __init
 early_read_config_word(struct pci_controller *hose,
 		       int top_bus, int bus, int devfn, int offset, u16 *value)
 {
-	struct pci_dev fake_dev;
 	struct pci_bus fake_bus;
 
-	fake_dev.bus = &fake_bus;
-	fake_dev.sysdata = hose;
-	fake_dev.devfn = devfn;
 	fake_bus.number = bus;
 	fake_bus.sysdata = hose;
 	fake_bus.ops = hose->pci_ops;
@@ -45,7 +41,7 @@ early_read_config_word(struct pci_controller *hose,
 	else
 		fake_bus.parent = NULL;
 
-	return pci_read_config_word(&fake_dev, offset, value);
+	return pci_bus_read_config_word(&fake_bus, devfn, offset, value);
 }
 
 int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
--
