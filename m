Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59602 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab2CARpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2012 12:45:45 -0500
MIME-Version: 1.0
In-Reply-To: <20120301172435.GA8505@kroah.com>
References: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
	<20120301172435.GA8505@kroah.com>
Date: Thu, 1 Mar 2012 09:45:44 -0800
Message-ID: <CAE9FiQXTJArPua7RbAVZBRp5CrdtXbHXziU+3L4ygAkn2VqTFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] usb, PCI: split quirk for usb host controller to three
From: Yinghai Lu <yinghai@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2012 at 9:24 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 01, 2012 at 09:17:07AM -0800, Yinghai Lu wrote:
>> so we avoid checking class again and again in that quirk.
>>
>> need to be applied after pci/linux-next and usb/usb-next
>
> As those are two independant trees, this needs to wait until after
> 3.4-rc1 is out.

ok.

>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/usb/host/pci-quirks.c |   42 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> Is this really helping anything here?  You added code overall :(

just make the code looks simple by removing

        if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
                        pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
                        pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
                        pdev->class != PCI_CLASS_SERIAL_USB_XHCI)
                return;
...
        if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
   ...
        else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
   ...
        else if (pdev->class == PCI_CLASS_SERIAL_USB_EHCI)
    ...
        else if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
    ...


also skip disable/enable device on non xhci controller.

Thanks

Yinghai
