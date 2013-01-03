Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:54889 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3ACOyk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 09:54:40 -0500
Received: by mail-la0-f43.google.com with SMTP id eg20so8060794lab.30
        for <linux-pci@vger.kernel.org>; Thu, 03 Jan 2013 06:54:38 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Jan 2013 07:54:18 -0700
Message-ID: <CAErSpo4MMSQdMZgKVQm8XF=0iw=d3Haj5VVbojiPVptK_uzb1w@mail.gmail.com>
Subject: IBM M4 x3650 SR-IOV pci=nocrs issue
To: Frank Haverkamp <haver@vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Gary Hade <garyhade@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Frank,

This is in reference to
https://bugzilla.kernel.org/show_bug.cgi?id=52211, which you mentioned
on #linux-pci while I was on vacation.

An SR-IOV card doesn't work correctly in the x3650 unless we ignore
the PCI host bridge _CRS information, either by using an old kernel,
booting with "pci=nocrs", or adding a quirk to set pci_use_crs to
false automatically.

Here's the relevant info from the 3.8.0-rc1 dmesg you attached to the bugzilla:

  ACPI: PCI Root Bridge [IOH0] (domain 0000 [bus 00-ff])
  pci_bus 0000:00: root bus resource [mem 0x3c0700000000-0x3c077fff0000]
  pci_bus 0000:00: root bus resource [mem 0x3c0780000000-0x3c07ffff0000]

  pci 0000:00:02.0: PCI bridge to [bus 11-15]
  pci 0000:00:02.0:   bridge window [mem 0x3c0778000000-0x3c07f7ffffff
64bit pref]
  pci 0000:00:02.0: no compatible bridge window for [mem
0x3c0778000000-0x3c07f7ffffff 64bit pref]

  pci 0000:11:00.0: [1014:044b] type 00 class 0x120000
  pci 0000:11:00.0: reg 10: [mem 0x3c07f0000000-0x3c07f7ffffff 64bit pref]
  pci 0000:11:00.0: reg 224: [mem 0x3c0778000000-0x3c077fffffff 64bit pref]
  pci 0000:11:00.0: no compatible bridge window for [mem
0x3c07f0000000-0x3c07f7ffffff 64bit pref]
  pci 0000:11:00.0: no compatible bridge window for [mem
0x3c0778000000-0x3c07efffffff 64bit pref]

The BIOS told us that [mem 0x3c0700000000-0x3c077fff0000] and [mem
0x3c0780000000-0x3c07ffff0000] are routed to PCI bus 0000:00.  It
doesn't mention the 64KB [mem 0x3c077fff0001-0x3c077fffffff] region
between those two apertures, so we have to assume that region is not
routed to bus 0000:00.  But the BIOS programmed the 00:02.0 bridge
window and the 11:00.0 SR-IOV BAR at 0x224 to use that 64KB region.

Since the card works with "pci=nocrs", it seems pretty clear that the
64KB hole between the reported apertures actually *is* routed to bus
0000:00.

This looks like a BIOS bug.  It looks like all the PNP0A08:00 _CRS
apertures above 4GB are missing the last 64KB.

Using "pci=nocrs" or a quirk like the one in the bugzilla avoids this
immediate issue, but it also will keep hot-plug from working because
without the _CRS info, we don't know what resources are available to
assign to hot-added devices.  So it's better to fix the BIOS if you
can.

Bjorn
