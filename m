Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60364 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaCUWf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 18:35:58 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so3208802iec.29
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2014 15:35:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
 <CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com>
 <CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
 <CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com> <CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Mar 2014 16:35:37 -0600
Message-ID: <CAErSpo5-rWeWeayeTpzgg+N_UYWfyT5-qdYReQm0WDy0WwHFkg@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
To: Cristina Olariu <colariu@elfiq.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 3:47 PM, Cristina Olariu <colariu@elfiq.com> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=72681

>>>> On Fri, Mar 21, 2014 at 11:56 AM, Cristina Olariu <colariu@elfiq.com>
>>>> wrote:
>>>> >
>>>> > I was trying to use the pci_slot module in order to associate a network
>>>> > interface  to  its corresponding network port by matching devices with
>>>> > physical slot information.
>>>> >
>>>> > Unfortunately the PCIe slots on our platform don't support the hot-plug
>>>> > function and the pci_slot module doesn't expose the slots interface in
>>>> > sysfs.
>>>> >
>>>> > Is there another way to list devices by physical add-in slots?  We are
>>>> > using
>>>> > kernel version 3.4.67.
>>>> > Any pointers you may be able to offer would be appreciated.

Your lspci (from the bugzilla mentioned above) shows 12 devices that
claim to have a slot, based on the PCIe Capabilities Register, but
most of them have a "Physical Slot Number" of zero:

    00:01.0 Intel Root Port Slot #0 to [bus 01]
    00:02.0 Intel Root Port Slot #0 to [bus 02]
    00:02.2 Intel Root Port Slot #0 to [bus 03-09]
    00:03.0 Intel Root Port Slot #0 to [bus 0a-0b]
    00:03.1 Intel Root Port Slot #0 to [bus 0c-0d]
    00:03.2 Intel Root Port Slot #0 to [bus 0e]
    00:1c.0 Intel Root Port Slot #0 to [bus 10]
    00:1c.1 Intel Root Port Slot #0 to [bus 11]
    00:1c.2 Intel Root Port Slot #0 to [bus 12]
    04:00.0 PLX Downstream Port Slot #0 to [bus 05-06]
    04:01.0 PLX Downstream Port Slot #1 to [bus 07-08]
    04:08.0 PLX Downstream Port Slot #8 to [bus 09]

    03:00.0 PLX Upstream Port to [bus 04-09]
    05:00.0 Intel 82599ES 10G NIC (in Slot #0)
    07:00.0 Intel 82599ES 10G NIC (in Slot #1)

My guess is that the ones you care about are the slots connected to
the PLX Downstream Ports, but I don't know how to make a rule about
which ones we should expose.  I think the slot code can disambiguate
them by adding a suffix, so I guess one possibility is to expose them
all as, e.g., "0", "0-1", "0-2", "0-3", etc.  Then you'd end up with
the PLX Downstream Port slots being "0-9", "1", and "8", which seems
sort of ugly.

What's the network port information you want to match up with these
slot numbers?

Bjorn
