Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:43978 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3HQBJ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2013 21:09:58 -0400
Received: by mail-ve0-f174.google.com with SMTP id d10so1770224vea.19
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2013 18:09:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130814213249.3c568da8@concha.lan>
References: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
 <CAErSpo6Gp34O=L1ASPRLLBxwQShn6SN5EfXjDT+G7XAg3qbL-g@mail.gmail.com> <20130814213249.3c568da8@concha.lan>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 16 Aug 2013 18:09:37 -0700
Message-ID: <CALCETrWzExS8ROirkcwagU0Wg6WmREtAzJ0un+hTVWdzaeC1Kg@mail.gmail.com>
Subject: Re: PCI devices w/ multiple drivers at once? (sb_edac vs i2c-imc)
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-edac@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 5:32 PM, Mauro Carvalho Chehab
<m.chehab@samsung.com> wrote:
> Em Wed, 14 Aug 2013 16:04:06 -0600
> Bjorn Helgaas <bhelgaas@google.com> escreveu:
>
>> On Wed, Aug 14, 2013 at 3:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > I'm working on a driver for the Sandy Bridge iMC SMBUS controller.  It
>> > (mostly) lives on pci device 15, function 0.  So my driver registers
>> > as an ordinary PCI driver for that device (8086.3ca8).
>> >
>> > The problem is that sb_edac also registers for 8086.3ca8.  This means
>> > that the drivers conflict.  The sb_edac driver is actually driving
>> > functionality that's split between eleven (!) different pci devices,
>> > none of which overlaps the stuff I'm driving.
>> >
>> > What's the Right Way (tm) to handle this?  Should I just modify
>> > sb_edac to pick a different one of the 11 devices to probe?  Is there
>> > some standard way to handle this in the PCI code?
>
> The sb-edac driver needs to see lots of different devices in order to
> work, as the memory controller registers are on different PCI IDs.
>
> So, there's not much that can be done there, I'm afraid.
>
> Btw, we almost added a code there to also access the SMBUS, in order to
> enumerate the memories. We ended by not adding, because we were afraid
> or risking to race with BIOS. A race while access an I2C EEPROM memory
> can be very bad, as a read operation might be understood as write, thus
> destroying the DIMM configuration.

Do you have any more details about this issue?  As far as I can tell
(by experiment, not by magic reference code), it's simply not possible
to control the SMBUS in CLTT mode.  I can't find any evidence of BIOS,
SMI code, or anything else using the SMBUS registers, so races against
other software-ish things seem unlikely.

--Andy
