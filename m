Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34873 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcBKPWP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2016 10:22:15 -0500
Received: by mail-ig0-f176.google.com with SMTP id hb3so37136234igb.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Feb 2016 07:22:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160201205400.GB4861@localhost>
References: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
	<1454300093.10542.3.camel@redhat.com>
	<CAJ2oMh+MjG8frrE3DjHBtwrsG1vGwMcDzQQ8f-n0q-YBS04DZg@mail.gmail.com>
	<20160201205400.GB4861@localhost>
Date: Thu, 11 Feb 2016 17:22:15 +0200
Message-ID: <CAJ2oMh+8pAP3AwF+jBt4rMJ2VhuehSCGHNw7-2VwSeRyV759BA@mail.gmail.com>
Subject: Re: Q: Relation between lanes to devices and to BARs
From: Ran Shalit <ranshalit@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 1, 2016 at 10:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Feb 01, 2016 at 08:41:28PM +0200, Ran Shalit wrote:
>> On Mon, Feb 1, 2016 at 6:14 AM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > On Sun, 2016-01-31 at 02:15 -0500, Ran Shalit wrote:
>> >> Hello,
>> >>
>> >> I am new to pci express drivers, and would please like to ask a question.
>> >> We develop a linux driver for a PCIe device board with 4 lanes.
>> >> 1. Is it expected that this will be recognized as a single device or
>> >> multiple device ?
>> >
>> > It depends whether your device is multifunction.
>>
>> It is a video capture & output deivce, (video4linux), so I guess it
>> means it has single functionality (video).' and therefore will aprear
>> as a single device.
>
> I'm not familiar with video devices, but it sounds likely that there
> would be at least two functions (one for input, another for output).
>
> It's a little confusing because the PCI/PCIe specs use "bus",
> "device", and "function" to describe device addressing, but in the
> Linux kernel, when we talk about a PCI device, we mean an individual
> *function*.  We maintain a struct pci_dev for each function, and a
> driver binds to the pci_dev for a single function.
>
> If you run "lspci", it shows a line for each function.  Here are a few
> from my system:
>
>   00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio Controller
>   00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 1
>   00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 4
>   00:1c.5 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 6
>
> The 00 is the PCI bus number; 1b and 1c are PCI device numbers; the
> .0, .3, and .5 are PCI function numbers.  In PCI spec terms, this is
> one single-function device (the audio controller at 00:1b.0) and one
> multi-function device with three functions (the root ports at 00:1c).
>
> In the kernel, we manage each function individually, so there are four
> pci_dev structs for the above list, and there could be four separate
> drivers bound to them.
>
>> >> 2. Is it that each lane rales to a different BAR or there is no
>> >> connection between these two ?
>> >
>> > No relation, all PCI/e devices have the same set of standard BARs
>> > available to them.
>>
>> So it probably means that there is no added complexity in terms of
>> device driver with multi lanes PCIe (compared to single lane).
>
> Right.  The number of PCIe lanes is invisible to the driver.  There
> are ways to find out and influence how many lanes a device uses, but
> in general, there's no need to do that.
>
> Bjorn

Hello,

If I may please ask one more on this issue.
You have made it clear the terms lanes & device in relation to
PCI/PCI-e device driver.
What about port ? Is there any relation between port to lane/device or
is there no relation between these terms.
For example, can it be 1 device with 2 lanes and 8 ports for example ?

Thank you very much,
Ran
