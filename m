Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbaASKla (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Jan 2014 05:41:30 -0500
Date: Sun, 19 Jan 2014 12:44:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: eiichiro.oiwa.nm@hitachi.com
Cc: bhelgaas@google.com, linux@eikelenboom.it, airlied@redhat.com,
	gregkh@linuxfoundation.org, konrad.wilk@oracle.com,
	linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org,
	airlied@linux.ie
Subject: Re: In "pci_fixup_video" check if this is or should be
 theprimaryvideo d
Message-ID: <20140119104410.GB4195@redhat.com>
References: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
 <CAErSpo678TwmMu7tB5u2uWogLCvQPyoZeXz3Do52XUTSGjYAwg@mail.gmail.c>
 <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9006873U52d90952@hitachi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 17, 2014 at 07:43:30PM +0900, eiichiro.oiwa.nm@hitachi.com wrote:
> Because legacy VGA is only one device on x86 System, I think qemu has to emulate a bridge
> for legacy VGA. The VGA Enable bit on its bridge control register has to set to 1. The VGA
> Enable bit describes in Table 3-10 Bridge Control register. When there are two VGA cards 
> on the same system, I think its system needs two bridges for each device. These bridges
> need bridge control registers. One VGA Enable bit on its bridge for legacy VGA has to set
> to 1. Another VGA Enable bit for second VGA has to set to 0.
> 
> 
> >On Thu, Jan 16, 2014 at 7:16 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> >> I think qemu is breaking "PCI-to-PCI Bridge Architecture Specification Revison 1.2
> >> June 9, 2003 Chapter 12. VGA Support".
> >
> >And what exactly do you think qemu is doing wrong?  Chapter 12 is ten
> >pages long.  Is there something there that prohibits two VGA devices
> >on the same bus?  I'm not a qemu developer, but if I were, I would
> >need a better hint about what is wrong before I could fix it.
> >
> >Again, sorry if you said this already and I missed it.
> >
> >>>[+cc Michael, Jesse, David, qemu-devel]
> >>>
> >>>On Wed, Jan 15, 2014 at 8:58 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> >>>> I suggest you should not break the PCI specification, as a developer of proprietary
> >>>> hypervisor, but I think your patch is no problem.
> >>>> Your PCI structure is specialized structure for your virtual machine.
> >>>> Maybe, your virtual machine will be causing another problem on Linux or other kernels
> >>>> because of breaking the PCI specification.
> >>>
> >>>I assume you think qemu is breaking the PCI spec.  What exactly do you
> >>>think is broken?  Please give specific references to the spec.  This
> >>>conversation is pretty fragmented, and I came in late, so I apologize
> >>>if I missed this.
> >>>
> >>>Bjorn
> >>>
> >

None of the bridges included in QEMU implements VGA support.
The spec explicitly says its optional, so that's ok.

As a result, you need to put device which has to work in
VGA mode on the root bus, any device behind a bridge
won't work in VGA mode (but might work in non VGA mode).

-- 
MST
