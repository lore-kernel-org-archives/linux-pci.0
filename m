Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:62003 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbaJBPsc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Oct 2014 11:48:32 -0400
Received: by mail-qa0-f49.google.com with SMTP id f12so1983266qad.8
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2014 08:48:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-85311-41252-8dDry2SwcF@https.bugzilla.kernel.org/>
References: <bug-85311-41252@https.bugzilla.kernel.org/> <bug-85311-41252-8dDry2SwcF@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Oct 2014 09:48:11 -0600
Message-ID: <CAErSpo5KnNsMej07ak-3fJt8K5bSwDoogxUY=2Jvuccc7Hf4Wg@mail.gmail.com>
Subject: Re: [Bug 85311] radeon 0000:01:00.0: Max Payload Size 16384, but
 upstream 0000:00:01.0 set to 128; if necessary, use "pci=pcie_bus_safe" and
 report a bug
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-pm, Rafael, Alex]

> https://bugzilla.kernel.org/show_bug.cgi?id=85311

Pali reported:

> Every time when I open LID on my notebook I see tons of new error lines in dmesg
> with kernel 3.17-rc6. And more lines come from radeon card (dmesg log is attached).
> I do not see these log lines with 3.13 kernel, so this is regression.

The new error lines are (from the bugzilla attachment):

  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  radeon 0000:01:00.0: Max Payload Size 16384, but upstream
0000:00:01.0 set to 128; if necessary, use "pci=pcie_bus_safe" and
report a bug
  pci_bus 0000:02: Allocating resources
  pci_bus 0000:03: Allocating resources
  pci_bus 0000:04: Allocating resources
  pci_bus 0000:05: Allocating resources
  pci_bus 0000:06: Allocating resources
  pci_bus 0000:0e: Allocating resources
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  radeon 0000:01:00.0: Max Payload Size 16384, but upstream
0000:00:01.0 set to 128; if necessary, use "pci=pcie_bus_safe" and
report a bug
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  radeon 0000:01:00.0: Max Payload Size 16384, but upstream
0000:00:01.0 set to 128; if necessary, use "pci=pcie_bus_safe" and
report a bug
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  radeon 0000:01:00.0: Max Payload Size 16384, but upstream
0000:00:01.0 set to 128; if necessary, use "pci=pcie_bus_safe" and
report a bug
  i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment
  ...

Using "radeon.runpm=0" gets rid of the radeon MPS complaints, but not
the others.

Alex said (in the bugzilla):

> When the radeon device is powered down, all the PCI registers and BARs read
> back as ones. which is why you are seeing the radeon errors.  Apparently the
> pci runtime pm code does not properly ask the driver to power the card up
> before accessing those registers.  Unfortunately, I'm not that familiar with
> the Linux runtime pm code.  I have no idea about the i915 and apci messages.

I haven't looked into this at all, so I don't know where this bug
report belongs.

Bjorn
