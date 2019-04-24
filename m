Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF8C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253D821908
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfDXQB2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:01:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33492 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfDXQB2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 12:01:28 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hJKKp-0008Dk-J8; Wed, 24 Apr 2019 10:01:24 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com> <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <05e3edbe-de1f-e7da-013f-4c4d0c8a07ce@deltatee.com>
Date:   Wed, 24 Apr 2019 10:01:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424141148.GA244134@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux@yadro.com, linux-pci@vger.kernel.org, fomichev.ru@gmail.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-24 8:11 a.m., Bjorn Helgaas wrote:
> [+cc Mika for runtime PM of bridges, Logan for switchtec question]
> 
> On Wed, Apr 24, 2019 at 01:01:02PM +0300, Alexander Fomichev wrote:
>> On Tue, Apr 23, 2019 at 04:53:40PM -0500, Bjorn Helgaas wrote:
>>> On Mon, Apr 15, 2019 at 09:15:54AM -0500, Bjorn Helgaas wrote:
>>>> On Mon, Apr 15, 2019 at 04:59:03PM +0300, Alexander Fomichev wrote:
>>>>> PLX switches have an issue that their internal registers
>>>>> become inaccessible when runtime PM is enabled. Therefore PLX
>>>>> service tools can't communicate with the hardware. A kernel
>>>>> option "pcie_port_pm=off" can be used as a workaround. But it
>>>>> affects all the devices.
>>>>>
>>>>> So this solution is to add PLX switch devices to the quirk
>>>>> list for disabling runtime PM only for them.
>>>>
>>>> I assume the problem is actually that the config space registers
>>>> are inaccessible when the device is in D3hot?
>>>
>>> Reading this again, I realize you said "internal registers".  I
>>> don't know whether that actually means config space registers
>>> (which *should* work even when the device is in D3hot (see the
>>> PCIe reference below and PCI Power Management Spec r1.2, sec
>>> 5.4.1)), or MMIO registers (which are not expected to work while
>>> in D3hot).
>>>
>>> If the service tools read MMIO registers, presumably that goes
>>> through some driver that should be able to manage runtime PM.  Or,
>>> if there's no driver, I think your service tool could prevent
>>> runtime power management by changing
>>> /sys/devices/.../power/control to "on" (see
>>> Documentation/power/runtime_pm.txt).
>>
>> You're right. Config space registers are accessible. The driver
>> can't read/write MMIO registers (Device-Specific Registers as
>> they're called by Broadcom).
> 
> Ah, perfect.  That's exactly what's supposed to happen from a PCI
> hardware point of view.  Unfortunately I don't know much about how
> Linux power management works, but Rafael and Mika do.
> 
> How do your service tools access these MMIO registers?
> 
>    - via a PLX driver that provides read/write/ioctl on a char dev?
>    - read/write on /sys/devices/pci*/.../resource<x> ?
>    - mmap on /sys/devices/pci*/.../resource<x> ?
>    - read/write on /dev/mem?
>    - mmap on /dev/mem?
>    - something else?
> 
> I think there are several ways we might be able to fix this:
> 
>    - Write a driver along the lines of drivers/pci/switch/switchtec.c.
>      I don't see any runtime PM stuff in that driver, so maybe it's
>      magically taken care of by the PM/PCI core?  There might also be
>      an issue if both portdrv and your driver want to claim the same
>      device.  I don't know how switchtec deals with that.

Right, the switchtec device puts all its management MMIO registers 
behind a separate PCIe function which lets us bind a different driver 
and not conflict with the portdrv. I've noticed the PLX parts have an 
extra unused BAR in their upstream port function which means it will be 
an annoying hack to write a driver to use it seeing the portdrv needs to 
be registered to it.

Logan




