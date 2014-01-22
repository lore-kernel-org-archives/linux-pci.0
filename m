Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:41909 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaAVBlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2014 20:41:42 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so7394642qab.23
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2014 17:41:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140121191514.GD9905@xanatos>
References: <CAAzarHXkEZNKbWzbMAwHYWNm_=m1uiyGGWHSWv6T7-ARAELaHg@mail.gmail.com>
	<20140117182231.GA18421@google.com>
	<20140121191514.GD9905@xanatos>
Date: Wed, 22 Jan 2014 09:41:39 +0800
Message-ID: <CAAzarHXk_0Y+xCqrFGhZ0Y=UYvEu0-JQrsPpunKrLeVUL5k1uw@mail.gmail.com>
Subject: Re: USB EHCI broken on Celeron N2920 (Bay Trail)
From: Chris Cheng <chris.cheng@atrustcorp.com>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	"Chen, Jamie" <jamie.chen@intel.com>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=Big5
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sarah,
    The patch is useful, thanks for your help.

Thanks.
--
Chris Cheng  鄭宇廷
Atrust Computer Corp.  冠信電腦股份有限公司
http://www.atrustcorp.com
Tel: +886-3-3288837 ext.1074
3F., No.361, Fusing 1st Rd., Gueishan Township, Taoyuan County 333, Taiwan
333 桃園縣龜山鄉復興一路361號3F


2014/1/22 Sarah Sharp <sarah.a.sharp@linux.intel.com>:
> Hi Chris,
>
> We think the Baytrail BIOS has an issue where it doesn't set the EHCI
> PCI interrupt enable bit when the computer is in "EHCI only mode".
> Please try this patch:
>
> http://marc.info/?l=linux-usb&m=138998295909608&w=2
>
> Sarah Sharp
>
> On Tue, Jan 21, 2014 at 10:04:41PM +0800, Chris Cheng wrote:
>> I'm sorry forgot kernel version: 3.13.0 .
>> --
>> Chris Cheng  鄭宇廷
>> Atrust Computer Corp.  冠信電腦股份有限公司
>> http://www.atrustcorp.com
>> Tel: +886-3-3288837 ext.1074
>> 3F., No.361, Fusing 1st Rd., Gueishan Township, Taoyuan County 333, Taiwan
>> 333 桃園縣龜山鄉復興一路361號3F
>>
>>
>> 2014/1/21 Chris Cheng <chris.cheng@atrustcorp.com>:
>> > Here is kernel message:
>> >
>> > [    2.939251] usb 1-1: new high-speed USB device number 2 using ehci-pci
>> > [   18.490987] usb 1-1: device not accepting address 2, error -110
>> > [   18.595095] usb 1-1: new high-speed USB device number 3 using ehci-pci
>> > [   34.182233] usb 1-1: device not accepting address 3, error -110
>> > [   34.286352] usb 1-1: new high-speed USB device number 4 using ehci-pci
>> > [   44.744589] usb 1-1: device not accepting address 4, error -110
>> > [   44.849590] usb 1-1: new high-speed USB device number 5 using ehci-pci
>> > [   55.307858] usb 1-1: device not accepting address 5, error -110
>> > [   55.310239] hub 1-0:1.0: unable to enumerate USB device on port 1
>> >
>> > Thanks.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
