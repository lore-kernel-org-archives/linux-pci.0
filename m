Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57617 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcAOXVz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 18:21:55 -0500
Date: Fri, 15 Jan 2016 17:21:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Henningsson <david.henningsson@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: Dmesg filled with "AER: Corrected error received"
Message-ID: <20160115232151.GB14080@localhost>
References: <5673E049.2010704@canonical.com>
 <20151229155822.GA17321@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151229155822.GA17321@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 29, 2015 at 09:58:22AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 18, 2015 at 11:30:33AM +0100, David Henningsson wrote:
> > Hi Linux PCI maintainers,
> > 
> > My dmesg gets filled with a few lines repeated over and over again:
> > 
> > pcieport 0000:00:1c.0: AER: Corrected error received: id=00e0
> > pcieport 0000:00:1c.0: can't find device of ID00e0
> > pcieport 0000:00:1c.0: AER: Corrected error received: id=00e0
> > pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected,
> > type=Physical Layer, id=00e0(Receiver ID)
> > pcieport 0000:00:1c.0:   device [8086:9d14] error
> > status/mask=00000001/00002000
> > pcieport 0000:00:1c.0:    [ 0] Receiver Error
> > 
> > This happens 10-30 times per second (!), so dmesg fills up quickly.
> > The bug is present in both vanilla and Ubuntu kernels.
> 
> This is a pretty obvious bug in our AER code.  We normally clear
> correctable errors by writing the PCI_ERR_COR_STATUS register in
> handle_error_source().  The execution path looks like this:
> 
>   aer_isr_one_error
>     aer_print_port_info
>     if (find_source_device())
>       aer_process_err_devices
>         handle_error_source
>           pci_write_config_dword(dev, PCI_ERR_COR_STATUS, ...)
> 
> In this case, find_source_device() printed "can't find device of
> ID00e0" [sic] and returned false, so we don't call
> aer_process_err_devices().  The error is never cleared, so
> we discover it again and again.
> 
> I'll work on fixing this.  Incidentally, there's another report
> with similar symptoms here:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=109691

I've thought about this problem a bit, but realistically I don't have
time to do the fix I'd like to do, which would involve reading the AER
status registers in the ISR and also *clearing* the error indication,
also in the ISR.  I think the current design, where we read bits of
the status in various places, and clear it in yet other locations, is
error-prone.

Anybody else who is interested should feel free to take a crack at it.

Bjorn
