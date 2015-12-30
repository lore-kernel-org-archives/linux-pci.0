Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54855 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbbL3Mw7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2015 07:52:59 -0500
Subject: Re: Dmesg filled with "AER: Corrected error received"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5673E049.2010704@canonical.com>
 <20151229155822.GA17321@localhost>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
From: David Henningsson <david.henningsson@canonical.com>
Message-ID: <5683D3AB.1000609@canonical.com>
Date: Wed, 30 Dec 2015 13:52:59 +0100
MIME-Version: 1.0
In-Reply-To: <20151229155822.GA17321@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Indeed booting with pci=noaer (as suggested in the other bug) works 
around this issue as well. I'll use that for the time being.

Thanks for working on it!

// David

On 2015-12-29 16:58, Bjorn Helgaas wrote:
> On Fri, Dec 18, 2015 at 11:30:33AM +0100, David Henningsson wrote:
>> Hi Linux PCI maintainers,
>>
>> My dmesg gets filled with a few lines repeated over and over again:
>>
>> pcieport 0000:00:1c.0: AER: Corrected error received: id=00e0
>> pcieport 0000:00:1c.0: can't find device of ID00e0
>> pcieport 0000:00:1c.0: AER: Corrected error received: id=00e0
>> pcieport 0000:00:1c.0: PCIe Bus Error: severity=Corrected,
>> type=Physical Layer, id=00e0(Receiver ID)
>> pcieport 0000:00:1c.0:   device [8086:9d14] error
>> status/mask=00000001/00002000
>> pcieport 0000:00:1c.0:    [ 0] Receiver Error
>>
>> This happens 10-30 times per second (!), so dmesg fills up quickly.
>> The bug is present in both vanilla and Ubuntu kernels.
>
> This is a pretty obvious bug in our AER code.  We normally clear
> correctable errors by writing the PCI_ERR_COR_STATUS register in
> handle_error_source().  The execution path looks like this:
>
>    aer_isr_one_error
>      aer_print_port_info
>      if (find_source_device())
>        aer_process_err_devices
>          handle_error_source
>            pci_write_config_dword(dev, PCI_ERR_COR_STATUS, ...)
>
> In this case, find_source_device() printed "can't find device of
> ID00e0" [sic] and returned false, so we don't call
> aer_process_err_devices().  The error is never cleared, so
> we discover it again and again.
>
> I'll work on fixing this.  Incidentally, there's another report
> with similar symptoms here:
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=109691
>
> Bjorn
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
