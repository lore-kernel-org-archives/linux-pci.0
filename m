Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40791 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbLWIF7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2015 03:05:59 -0500
Subject: Re: Dmesg filled with "AER: Corrected error received"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5673E049.2010704@canonical.com>
 <20151222215758.GA17235@localhost>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
From: David Henningsson <david.henningsson@canonical.com>
Message-ID: <567A55E9.6030608@canonical.com>
Date: Wed, 23 Dec 2015 09:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <20151222215758.GA17235@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2015-12-22 22:57, Bjorn Helgaas wrote:
> Hi David,
>
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
>>
>> I'm happy to try to help by providing more info as requested, and
>> I'm also able to build kernels to test patches (although that might
>> take some time, especially during the upcoming holidays).
>>
>> Computer: Dell Inspiron 13-7359
>> Kernel version: Linux version 4.4.0-040400rc5-generic (kernel@gloin)
>> (gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201512140221
>> SMP Mon Dec 14 02:23:36 UTC 2015
>> CPU: Skylake i3-6100U
>> Lspci: attached
>> Dmesg: I'm attaching an extract from kern.log which shows the most
>> recent boot and a few seconds thereafter.
>> Downstream bug report:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1521173
>
> Thanks a lot for the report and logs.  Do you happen to know whether this
> is a regression, and if so, when it first appeared?

Hi Bjorn and thanks for looking at it,

I'm not sure how far back I can go and still have Skylake working (this 
is a new laptop), but I just tried booting a 4.0.9 vanilla kernel and 
the problem is present there as well.

If anything, it seems to be at an even higher rate in 4.0.9, because in 
4.0.9, I get reports about "printk messages dropped", which I don't get 
in 4.4.0-rc5.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
