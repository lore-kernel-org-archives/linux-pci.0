Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64705 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaAQEOD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 23:14:03 -0500
Received: by mail-ie0-f177.google.com with SMTP id at1so1871457iec.22
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2014 20:13:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9006870U52d8928d@hitachi.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Jan 2014 21:13:39 -0700
Message-ID: <CAErSpo678TwmMu7tB5u2uWogLCvQPyoZeXz3Do52XUTSGjYAwg@mail.gmail.com>
Subject: Re: In "pci_fixup_video" check if this is or should be the
 primaryvideo d
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

On Thu, Jan 16, 2014 at 7:16 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
> I think qemu is breaking "PCI-to-PCI Bridge Architecture Specification Revison 1.2
> June 9, 2003 Chapter 12. VGA Support".

And what exactly do you think qemu is doing wrong?  Chapter 12 is ten
pages long.  Is there something there that prohibits two VGA devices
on the same bus?  I'm not a qemu developer, but if I were, I would
need a better hint about what is wrong before I could fix it.

Again, sorry if you said this already and I missed it.

>>[+cc Michael, Jesse, David, qemu-devel]
>>
>>On Wed, Jan 15, 2014 at 8:58 PM,  <eiichiro.oiwa.nm@hitachi.com> wrote:
>>> I suggest you should not break the PCI specification, as a developer of proprietary
>>> hypervisor, but I think your patch is no problem.
>>> Your PCI structure is specialized structure for your virtual machine.
>>> Maybe, your virtual machine will be causing another problem on Linux or other kernels
>>> because of breaking the PCI specification.
>>
>>I assume you think qemu is breaking the PCI spec.  What exactly do you
>>think is broken?  Please give specific references to the spec.  This
>>conversation is pretty fragmented, and I came in late, so I apologize
>>if I missed this.
>>
>>Bjorn
>>
