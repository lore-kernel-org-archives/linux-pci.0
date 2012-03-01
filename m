Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47533 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2CASUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2012 13:20:33 -0500
Received: by bkcik5 with SMTP id ik5so792383bkc.19
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2012 10:20:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXTJArPua7RbAVZBRp5CrdtXbHXziU+3L4ygAkn2VqTFQ@mail.gmail.com>
References: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
 <20120301172435.GA8505@kroah.com> <CAE9FiQXTJArPua7RbAVZBRp5CrdtXbHXziU+3L4ygAkn2VqTFQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 Mar 2012 11:20:12 -0700
Message-ID: <CAErSpo4fp9fOR-N9RBnGW3m_SjnL_85fuhjQNNLrPygSPX0SYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] usb, PCI: split quirk for usb host controller to three
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2012 at 10:45 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Mar 1, 2012 at 9:24 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Thu, Mar 01, 2012 at 09:17:07AM -0800, Yinghai Lu wrote:
>>> so we avoid checking class again and again in that quirk.
>>>
>>> need to be applied after pci/linux-next and usb/usb-next
>>
>> As those are two independant trees, this needs to wait until after
>> 3.4-rc1 is out.
>
> ok.
>
>>
>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>
>>> ---
>>>  drivers/usb/host/pci-quirks.c |   42 ++++++++++++++++++++++++++++--------------
>>>  1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> Is this really helping anything here?  You added code overall :(
>
> just make the code looks simple by removing
>
>        if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
>                        pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
>                        pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
>                        pdev->class != PCI_CLASS_SERIAL_USB_XHCI)
>                return;
> ...
>        if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
>   ...
>        else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
>   ...
>        else if (pdev->class == PCI_CLASS_SERIAL_USB_EHCI)
>    ...
>        else if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
>    ...
>
>
> also skip disable/enable device on non xhci controller.

Hmm...  From the description, I thought this patch only took advantage
of DECLARE_PCI_FIXUP_CLASS_FINAL to remove the "if (pdev->class ==
XXX)" tests.

If it *also* skips a disable/enable sequence on non-xhci controllers,
please make that a separate patch so it's clear what's happening.

It's very important to be clear about these things for people who are
deciding whether to backport patches into distros.  All the zillions
of PCI changes we're doing make their lives hard enough without having
subtle behavior changes hidden in patches that seem to be "code
restructure only, no behavior change."

Bjorn
