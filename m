Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s31.blu0.hotmail.com ([65.55.111.170]:61261 "EHLO
	blu0-omc4-s31.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902Ab3EMFgE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2013 01:36:04 -0400
Message-ID: <BLU0-SMTP1537DF5AB62CBF6B5D74907B2A00@phx.gbl>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed; delsp=yes
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Frank Rizzo" <thefrankrizzo@hotmail.com>
Subject: Re: Rescan PCIE bus to find recently powered on device.
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl>
 <BLU0-SMTP28241CA91CD69AFF09827B6B2A70@phx.gbl>
Date: Sun, 12 May 2013 22:35:57 -0700
MIME-Version: 1.0
From: Frank Rizzo <thefrankrizzo@hotmail.com>
In-Reply-To: <BLU0-SMTP28241CA91CD69AFF09827B6B2A70@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Let me be more specific.  Any idea how to fix the "device not available"  
issue?

-Frank


On Sun, 12 May 2013 15:13:59 -0700, Frank Rizzo  
<thefrankrizzo@hotmail.com> wrote:

> OK list, here's an update.  I had my software engineer do some tests on  
> his system, and this is what I get when he powers on the target device:
>
> [ 149.626692] pci 0000:01:00.0: [1a39:0004] type 0 class 0x000000
> [ 149.626721] pci 0000:01:00.0: reg 10: [mem 0x00000000-0x000fffff 64bit]
> [ 149.626741] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x000fffff 64bit]
> [ 149.626761] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00000fff 64bit]
> [ 149.631745] pcieport 0000:00:01.0: BAR 14: assigned [mem  
> 0xc0800000-0xc0afffff]
> [ 149.631837] gn_pcie 0000:01:00.0: device not available (can't reserve  
> [mem 0x00000000-0x000fffff 64bit])
>
> A simple lspci shows the device in the list, but since the driver failed  
> to register the device, it is inaccessible to his applications.
>
> Any ideas?
>
> -Frank
>
>
> On Thu, 18 Apr 2013 19:59:11 -0700, Frank Rizzo  
> <thefrankrizzo@hotmail.com> wrote:
>
>> Hey list.
>>
>> I'm working on a driver for a device that's external from the PC.  It's  
>> connected to the PC via a weird cable that connects to a PCIE card  
>> inside the case that appears to be nothing other than glue logic to  
>> allow the signals from the cable to be tossed onto the bus.
>>
>> When the external device is powered off during boot, nothing is found.  
>>  hwinfo doesn't find it, lspci doesn't find it, etc.  If you power on  
>> the device BEFORE booting, everything is found, and it works fine.  And  
>> lastly, if you power it on AFTER Linux has booted, you still can't find  
>> it.  I've tried echoing "1" to rescan, and everything else that I could  
>> find via Google search.
>>
>> So, what are my options here?  I'm not allergic to adding code to the  
>> driver to scan for the device periodically, if I knew HOW to find it.  
>>  And, once found, how do I get it registered?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
