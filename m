Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48285 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770Ab2JWNyx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Oct 2012 09:54:53 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3146762wgb.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Oct 2012 06:54:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121022234057.GA20265@xanatos>
References: <50841CCC.9030809@uli-eckhardt.de> <20121022234057.GA20265@xanatos>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 23 Oct 2012 07:54:32 -0600
Message-ID: <CAErSpo5-cvL1AmhR+KWo-LY-zS1HvfdVdUj_3tS7nQdcQRdjUg@mail.gmail.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Ulrich Eckhardt <usb@uli-eckhardt.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 22, 2012 at 5:40 PM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Sun, Oct 21, 2012 at 06:03:24PM +0200, Ulrich Eckhardt wrote:
>> Hello,
>>
>> I have problems to get my USB3 cardreader to work reliably when
>> connected to the USB3 port. Due to lack of other USB3 devices I
>> don't know if it is the cardreader or the USB3 host (NEC uPD720200)
>> but the cardreader always works reliable when connected to USB2.
>>
>> Sometimes it is not possible to use the cardreader directly after
>> power up and I have to restart the computer. Very often the
>> cardreader stops working after removing a SD-card and insert another
>> SD-card or during copying data.
>>
>> I have tested it with Kernel 3.6.2. The USB3 port is the one built
>> in the Mainboard M4A87DT EVO.
>
> Did a previous kernel version work?
>
>> I saw, that the outputs of lspci are different, if there is a
>> problem directly after startup.
>
> Bjorn, can you take a look at this PCI output, and tell me if it matters
> that the host has bus master and latency 0 when it works and is missing
> those properties when it doesn't?

Yes, I would think that would matter.  If the Bus Master bit in the
command register isn't set, the device won't be able to DMA.  Also, it
looks like the memory BAR is disabled (probably the Memory Space bit
in the command register is also cleared).

My guess is that these are just a consequence of the driver being
detached from the device for some reason.

It'd be nice to have a complete dmesg log for a case where the device
worked, then stopped working.  Also "lspci -vv" for both cases.

Bjorn
