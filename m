Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757075AbdJJVKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Oct 2017 17:10:46 -0400
Date: Tue, 10 Oct 2017 16:10:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: Re: PCIe error reporting
Message-ID: <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 03:12:45PM +0000, David Laight wrote:
> I'm trying to determine how a PCIe card we are building handles (and
> hopefully recovers from) PCIe link errors.
> However I'm not at all sure what I should expect the x86 Linux host to do.
> 
> The card has an Altera FPGA and I can monitor things like changes to
> it's LTSSM state engine, but not quite the full operation of the PCIe logic.
> 
> I've enabled AER and lspci seems to decode most of the bits but
> it looks as though something needs to detect error bits being set
> log the error and then clear them.
> 
> I did a rather brutal test - shorted the TX lines after the caps.
> The card's PCIe logic issued a reset to the internal logic before
> bringing the PCIe link back up.
> I could then read config space - but the BARs were all zero
> (I think lspci reported the old values, but the -x data showed zeros).
> Nothing seemed to indicate the Linux thought anything was wrong.
> Not surprisingly reads returned ~0u.
> 
> I should really try a much shorter error.
> 
> On that system (XEON E5-2600) dmesg contains (retyped):
>   acpi: PNP0A08:00: _OSC: platform does not support [AER]

Per the PCI Firmware spec r3.0, sec 4.5.1, on ACPI platforms, the OS
is supposed to use _OSC to ask the firmware for permission before
using AER.  In this case, the firmware declined to grant us
permission, so we're not supposed to do anything at all with AER.

I think the idea is that the firmware itself is supposed to be
handling AER in this case, and it doesn't want the OS to get in the
way.

> Another system is even more 'useless', it reports "AER handled
> by the firmware".

This means the ACPI HEST table has the "firmware first" bit set, which
means the BIOS is supposed to field the AER interrupt, read the AER
logging CSRs, package them up, and deliver them to the OS.  The OS is
supposed to feed the error info into the OS AER recovery path.

Linux AER recovery *should* work on this system.  But I don't think
AER is well-tested in general, and any time we have firmware-OS
interfaces, there's always potential for misunderstandings.

> If we take the PCIe link down (even after echo 1 >sys/devices/.../remove)
> something generates an NMI!
> 
> Is this all 'expected' behaviour?
> Anything else I should/could be looking at?
> Is there anything that will poll the AER bits for me?
> 
> 	David
> 
> 
