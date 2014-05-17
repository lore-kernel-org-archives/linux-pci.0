Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:40920 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbaEQMNa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 17 May 2014 08:13:30 -0400
Received: from [99.240.204.5] (port=42258 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1Wlcqb-0007aH-Bh
	for linux-pci@vger.kernel.org; Sat, 17 May 2014 07:32:13 -0400
Date: Sat, 17 May 2014 07:29:53 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: could the [x86] Kconfig content for PCI be cleaned up at all?
Message-ID: <alpine.LFD.2.11.1405170706260.536@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


  digging through the current PCI code and Kconfig files and it seems
like some of that could be made simpler, but i'm willing to be
convinced otherwise.

  first, from arch/x86/Kconfig, rather than simply sourcing the file
"drivers/pci/Kconfig" (as is done with many other drivers
directories), that Kconfig file defines:

  menu "Bus options (PCI etc.)"

  config PCI
        bool "PCI support"
        default y
  ... snip ...

and later on, sources the Kconfig files for PCI and PCIe individually:

  source "drivers/pci/pcie/Kconfig"

  source "drivers/pci/Kconfig"

and even further down, finally sources the file for PCI hotplug after
PCMCIA:

  source "drivers/pcmcia/Kconfig"

  source "drivers/pci/hotplug/Kconfig"

given the dependencies, could all of this not be encapsulated in the
top-level Kconfig files under drivers/pci?

  next, in drivers/Makefile, pci code is pulled in with the single
statement:

  obj-$(CONFIG_PCI)               += pci/

given that, can't one drop all the "depends on PCI" directives from
the file drivers/pci/Kconfig? or just wrap the whole file in a "if
PCI" test? (unless there's something i'm missing here.)

  and could the same thing not be said for the pcie/ subdirectory?
drivers/pci/Makefile contains the line:

  obj-$(CONFIG_PCIEPORTBUS) += pcie/

with the dependency in drivers/pci/pcie/Kconfig:

  config PCIEPORTBUS
        bool "PCI Express Port Bus support"
        depends on PCI

suggesting that drivers/pci/pcie/Kconfig could also be simplified
quite a bit by dropping redundant dependency directives.

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================




