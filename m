Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753343AbcLHO4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 09:56:24 -0500
Date: Thu, 8 Dec 2016 08:56:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Janusz.Dziedzic@tieto.com" <Janusz.Dziedzic@tieto.com>,
        "rmanohar@qti.qualcomm.com" <rmanohar@qti.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>, ath9k-devel@qca.qualcomm.com
Subject: Re: ATH9 driver issues on ARM64
Message-ID: <20161208145608.GA19822@bhelgaas-glaptop.roam.corp.google.com>
References: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kalle, ath9k list]

On Thu, Dec 08, 2016 at 01:49:42PM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> Did anyone test Atheros ATH9 driver(drivers/net/wireless/ath/ath9k/)
> on ARM64.  The end point is TP link wifi card with which supports
> only legacy interrupts.

If it works on other arches and the arm64 PCI enumeration works, my
first guess would be an INTx issue, e.g., maybe the driver is waiting
for an interrupt that never arrives.

> We are trying to test it on ARM64 with
> (drivers/pci/host/pcie-xilinx-nwl.c) as root port.
> 
> EP is getting enumerated and able to link up. 
> 
> But when we start scan system gets hanged.

When you say the system hangs when you start a scan, I assume you mean
a wifi scan, not the PCI enumeration.  A problem with a wifi scan
might cause a *process* to hang, but it shouldn't hang the entire
system.

> When we took trace we see that after we start scan assert message is
> sent but there is no de assert from end point.

Are you talking about a trace from a PCIe analyzer?  Do you see an
Assert_INTx PCIe message on the link?

> What might cause end point not sending de assert ?

If the endpoint doesn't send a Deassert_INTx message, I expect that
would mean the driver didn't service the interrupt and remove the
condition that caused the device to assert the interrupt in the first
place.

If the driver didn't receive the interrupt, it couldn't service it, of
course.  You could add a printk in the ath9k interrupt service
routine to see if you ever get there.

> We are not seeing any issues on 32-bit ARM platform and X86
> platform. 

Can you collect a dmesg log (or, if the system hang means you can't
collect that, a console log with "ignore_loglevel"), and "lspci -vv"
output as root?  That should have clues about whether the INTx got
routed correctly.  /proc/interrupts should also show whether we're
receiving interrupts from the device.

Bjorn
