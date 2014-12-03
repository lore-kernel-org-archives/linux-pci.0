Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:54390 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaLCAT2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Dec 2014 19:19:28 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so10399547qcv.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2014 16:19:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141124091729.3de7ae7b@lxorguk.ukuu.org.uk>
References: <1415847123-15558-1-git-send-email-michael.jamet@intel.com>
 <CAErSpo7Z5x=U3vSnxrFpwYUDrUrnrrBCe1F9_GQNYqWWQFWNpQ@mail.gmail.com>
 <BC567D27D6B7384F84318942321624DE16179E60@hasmsx109.ger.corp.intel.com>
 <CAErSpo5z41ZOL3xUwwSZ8UE_KGmCDOUmFQ3CY_QwF7JVhU1-EQ@mail.gmail.com> <20141124091729.3de7ae7b@lxorguk.ukuu.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Dec 2014 17:19:07 -0700
Message-ID: <CAErSpo407-LFjFh=224qGu5UC4pfMyd8FvWpNDEOsXqSAFfJeQ@mail.gmail.com>
Subject: Re: [PATCH] pci: support Thunderbolt requirements for I/O resources.
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Jamet, Michael" <michael.jamet@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Levy, Amir (Jer)" <amir.jer.levy@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 24, 2014 at 2:17 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> > This was also discussed internally and the only way to identify Thunderbolt devices is to check the device IDs.
>> > As you said, this will require us to maintain and keep the list up-to-date as we deliver new devices.
>>
>> I don't really see how this can work.  You're asking me to put changes
>> based on a secret spec into generic code that is used on every machine
>> with PCI.  I have no way to maintain something like that.
>
>>
>> This seems like a major screw up in the design and documentation of Thunderbolt.
>
> See
> https://developer.apple.com/library/mac/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/ThunderboltDevGuide.pdf
>
> page 10 for one of the brief public notes on the not relying on I/O space.

I agree with that recommendation not to rely on I/O space.  It applies
equally to *all* PCI devices, not just to Thunderbolt.

Presumably this patch fixes a problem.  The changelog says:

    Kernel shouldn't allocate the PCI I/O resources
    as it interferes with BIOS operation.
    Doing this may cause the devices in the Thunderbolt chain
    not being detected or added, or worse to stuck the
    Thunderbolt Host controller.

The problem of devices not being detected sounds like a general
problem (I assume the problem is actually that we do enumerate the
device, but we may not be able to assign I/O port space to it, which
means we may not be able to operate it).  This could happen with any
device.  If you can come up with a generic way to deal with it, that
might work.  Note that we do already have pci_enable_device_mem() for
drivers that don't need I/O space to operate their device.

If assigning I/O port space to a device can hang the Thunderbolt
controller, that sounds like a controller defect, and maybe you could
write a quirk to work around it.  I'm not opposed to adding
device-specific workarounds for things like that.  I just have trouble
with putting undocumented workarounds in the common path that
everybody uses.

Bjorn
