Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58744 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaAQPkI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2014 10:40:08 -0500
Received: by mail-ie0-f179.google.com with SMTP id ar20so809386iec.38
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2014 07:40:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
 <CAErSpo678TwmMu7tB5u2uWogLCvQPyoZeXz3Do52XUTSGjYAwg@mail.gmail.c> <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Jan 2014 08:39:45 -0700
Message-ID: <CAErSpo5oi1cMyXiLAOd5j5Gi0GwKZ7-LD-TkD6r8HM5TBEq3Dg@mail.gmail.com>
Subject: Re: Re[2]: In "pci_fixup_video" check if this is or should be
 theprimaryvideo d
To: eiichiro.oiwa.nm@hitachi.com
Cc: Sander Eikelenboom <linux@eikelenboom.it>,
	Dave Airlie <airlied@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 17, 2014 at 3:43 AM,  <eiichiro.oiwa.nm@hitachi.com> wrote:

To make progress here, I think you'll have to be even more detailed.

> Because legacy VGA is only one device on x86 System,

Where is it documented that there can be only one legacy VGA device in
an x86 system?  I assume there exists a system with two slots on bus
0.  What happens if a user installs two VGA cards in those slots?
Does that prevent the system from working at all because it's an
illegal configuration?

I think such a system could work correctly if the I/O Space and Memory
Space bits in the command registers were only set on one of the VGA
devices.

> I think qemu has to emulate a bridge
> for legacy VGA.

My Lenovo T410 has "00:02.0 VGA compatible controller," which I assume
would qualify as a "legacy VGA device," and there's no bridge related
to it.

> The VGA Enable bit on its bridge control register has to set to 1. The VGA
> Enable bit describes in Table 3-10 Bridge Control register. When there are two VGA cards
> on the same system, I think its system needs two bridges for each device.

I think you meant to say that if there are two VGA cards, we need
*one* bridge for each device, e.g., two bridges and two VGA cards.
But where does the requirement for the bridges come from?

> These bridges
> need bridge control registers. One VGA Enable bit on its bridge for legacy VGA has to set
> to 1. Another VGA Enable bit for second VGA has to set to 0.

If you have a set of peer bridges, i.e., bridges on the same primary
bus, I agree that at most one of them should have VGA Enable set.  If
more than one had VGA Enable set, a read on the primary bus could
receive multiple responses, which would be a PCI protocol violation.

Similarly, if there are multiple VGA devices on the same bus, I
believe that at most one could have I/O Space and Memory Space enabled
in their command registers.

But I don't see the requirement for a bridge for every VGA device.

>>On Thu, Jan 16, 2014 at 7:16 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
>>> I think qemu is breaking "PCI-to-PCI Bridge Architecture Specification Revison 1.2
>>> June 9, 2003 Chapter 12. VGA Support".
>>
>>And what exactly do you think qemu is doing wrong?  Chapter 12 is ten
>>pages long.  Is there something there that prohibits two VGA devices
>>on the same bus?  I'm not a qemu developer, but if I were, I would
>>need a better hint about what is wrong before I could fix it.
>>
>>Again, sorry if you said this already and I missed it.
>>
>>>>[+cc Michael, Jesse, David, qemu-devel]
>>>>
>>>>On Wed, Jan 15, 2014 at 8:58 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
>>>>> I suggest you should not break the PCI specification, as a developer of proprietary
>>>>> hypervisor, but I think your patch is no problem.
>>>>> Your PCI structure is specialized structure for your virtual machine.
>>>>> Maybe, your virtual machine will be causing another problem on Linux or other kernels
>>>>> because of breaking the PCI specification.
>>>>
>>>>I assume you think qemu is breaking the PCI spec.  What exactly do you
>>>>think is broken?  Please give specific references to the spec.  This
>>>>conversation is pretty fragmented, and I came in late, so I apologize
>>>>if I missed this.
>>>>
>>>>Bjorn
>>>>
>>
