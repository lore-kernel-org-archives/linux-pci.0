Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:48896 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520AbaCZSYA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 14:24:00 -0400
Received: by mail-oa0-f49.google.com with SMTP id h16so3045938oag.22
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2014 11:23:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5ncPGV9_ijfzCJJP28AX=4erb_iN2sei_DJC7eCsevMg@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
	<CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com>
	<CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
	<CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
	<CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
	<CAErSpo5-rWeWeayeTpzgg+N_UYWfyT5-qdYReQm0WDy0WwHFkg@mail.gmail.com>
	<CAMm_7EoCGgQ7aZfESY_-+WFdsZqpBrjEee94e6GyT50CLaVbdQ@mail.gmail.com>
	<CAErSpo5ncPGV9_ijfzCJJP28AX=4erb_iN2sei_DJC7eCsevMg@mail.gmail.com>
Date: Wed, 26 Mar 2014 14:23:59 -0400
Message-ID: <CAMm_7Epo7D53_Cui7zN1Zv0F4HAOSdUv6M9pLJxjrFAWbB7aNw@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
From: Cristina Olariu <colariu@elfiq.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 24, 2014 at 7:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Matt, Jordan]

> I was really trying to ask "what is the specific information you have
> about your network port that you want to match up with something from
> PCI?"

Sorry; what I had in mind was the PCI address: domain/bus/device/function.

> It sounds like what you're really after is "Consistent Network Device
> Naming" [1].  I'm not very familiar with it, but it might be a way to
> do what you need.  It looks like it can use SMBIOS to help figure out
> naming information, so maybe that will work even if we don't have the
> PCIe slot information.

That's true. I'm aware of biosdevname; I have a similar user
application, tailored for our platform.

I get a list of all PCI network devices and for each one I look up its
interface name in sysfs.
>From SMBIOS I get the list of physical slots along with their
corresponding  bus addresses.
Then, I match the lists and identify the physical slot for every network device.

I was trying to simplify the design and thought that it would be
easier if the physical slot number would be already available in sysfs
hierarchy.

> It does seem like the way we expose PCIe slot information is
> unnecessarily tied to the question of whether the slot supports
> hotplug.  Maybe the slot number, e.g., the PCIe or SHPC "Physical Slot
> Number" could be exposed in the device directory of the upstream
> bridge, e.g., /sys/devices/pci0000:00/0000:00:1c.3/slot.

Yes, this could be helpful. I was looking for a PCI address inside
/sys/bus/pci/slots/X but this is better.

Thank you,
Cristina

-- 
CRISTINA OLARIU * Elfiq Networks * Software Developer
T. 514.667.0611 x 821 *  E.  colariu@elfiq.com
