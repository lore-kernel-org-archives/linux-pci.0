Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab2EXNoE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 May 2012 09:44:04 -0400
Date: Thu, 24 May 2012 09:43:56 -0400
From: Jason Baron <jbaron@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120524134356.GA781@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
 <20120523205238.GE23940@redhat.com>
 <CAE9FiQVnYd62BR7j+E=dFWvOKi-W6dBOCqJ21NmqFjmF+yhtKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQVnYd62BR7j+E=dFWvOKi-W6dBOCqJ21NmqFjmF+yhtKg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 05:00:05PM -0700, Yinghai Lu wrote:
> On Wed, May 23, 2012 at 1:52 PM, Jason Baron <jbaron@redhat.com> wrote:
> > Ok, I've also verified that quirk approach resolves the issue for me as
> > well. It might not be a bad solution, especially if we anticipate moving
> > to pciehp. We can also always change bridge vendor id to not hit the
> > quirk, if we choose to implement more complex guest, or acpi fixes. The
> > defaults for i/o and mem seem pretty sane too:
> >
> >
> > #define DEFAULT_HOTPLUG_IO_SIZE         (256)
> > #define DEFAULT_HOTPLUG_MEM_SIZE        (2*1024*1024)
> >
> > And further can be set on the guest command line via:
> >
> > /* pci=hpmemsize=nnM,hpiosize=nn can override this */
> >
> > So I don't see any down-side really to the quirk approach (which is a
> > quite simple 1-line patch to the guest), even if it is not a long-term
> > solution.
> 
> Good. please check attached patch,
> it should auto set that bit for apciphp when complex slot are
> supported by platform.
> 
> next, we still need to extend probe_resource() to support
> mmio/pref_mmio extension.
> that is for when you have a lot slots on hotplug bridge.
> 
> Thanks
> 
> Yinghai

Yes, I can comfirm that the patch works with my qemu hotplug bridge
code. Thanks!

Acked-by: Jason Baron <jbaron@redhat.com>

-Jason
