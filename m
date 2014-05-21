Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:41380 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaEUH20 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 03:28:26 -0400
Received: from [99.240.204.5] (port=54330 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1Wn0wv-0005dE-Hz
	for linux-pci@vger.kernel.org; Wed, 21 May 2014 03:28:29 -0400
Date: Wed, 21 May 2014 03:25:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: what exactly does the kernel config var "PCIEPORTBUS" represent?
Message-ID: <alpine.LFD.2.11.1405210314120.16527@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


  am currently writing a short tutorial on PCIe for an upcoming
drivers class, and i'm getting a bit confused by how the PCIe code is
laid out.

  over in drivers/pci/, the Makefile contains the predictable lines:

# Build PCI Express stuff if needed
obj-$(CONFIG_PCIEPORTBUS) += pcie/

which initially suggested that that Kconfig variable is entirely
responsible for selecting PCIe support throughout the kernel. or so i
thought.

  for the board i'm playing with, i have a PCIe slot and an intel
wireless Advanced-N 6235 wifi card, so decided to use that as an
example, so i popped over to drivers/net/wireless/iwlwifi/, and in the
Makefile, one finds:

obj-$(CONFIG_IWLWIFI)   += iwlwifi.o
iwlwifi-objs            += iwl-io.o
iwlwifi-objs            += iwl-drv.o
iwlwifi-objs            += iwl-debug.o
iwlwifi-objs            += iwl-notif-wait.o
iwlwifi-objs            += iwl-eeprom-read.o iwl-eeprom-parse.o
iwlwifi-objs            += iwl-phy-db.o iwl-nvm-parse.o
iwlwifi-objs            += pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o

in other words, the pcie/ directory is compiled with no dependency on
PCIEPORTBUS, which i found confusing. i verified that by configuring a
kernel build without PCIEPORTBUS and, sure enough, everything in that
pcie/ directory was compiled.

  i asked about this on the linux-wireless list and there was a bit of
confusion there as well. one person wrote:

"The whole driver depends on CONFIG_PCI, maybe it should depend on
something more PCIe specific, but that wasn't easy to sort out, and
the APIs it needs aren't PCIe specific afaict."

while someone else verified that, yes, this is indeed the case,
writing:

"A number of PCIe specific calls are under CONFIG_PCI, ie.
pcie_capability_*() et al."

  is this clarified somewhere? it's kind of confusing to learn that,
even without PCIEPORTBUS, the kernel still needs some level of PCIe
support for certain drivers. or however one is supposed to read this.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
