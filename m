Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9842 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751103AbcFQWXq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 18:23:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5HMJaxC079892
	for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2016 18:23:45 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23kqt3x6p1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2016 18:23:45 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Sat, 18 Jun 2016 08:23:42 +1000
Subject: Re: [PATCH] tracing: Expose CPU physical addresses (resource
 values) for PCI devices
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, karol herbst <karolherbst@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>, koriakin@0x04.net
Date: Sat, 18 Jun 2016 08:23:23 +1000
In-Reply-To: <20160617175901.7bd90d14@gandalf.local.home>
References: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	 <20160617175901.7bd90d14@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1466202203.24271.76.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-06-17 at 17:59 -0400, Steven Rostedt wrote:
> Sorry for the late reply, this patch got pushed down in my INBOX.
> 
> Could I get someone from PPC to review this patch, just to be safe?

The patch makes sense, I can try getting somebody onto porting
mmiotrace one of these days.

Cheers,
Ben.

> Thanks!
> 
> -- Steve
> 
> 
> 
> On Wed, 11 May 2016 14:06:57 -0500
> Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > Previously, mmio_print_pcidev() put "user" addresses in the trace
> > buffer.
> > On most architectures, these are the same as CPU physical
> > addresses, but on
> > microblaze, mips, powerpc, and sparc, they may be something else,
> > typically
> > a raw BAR value (a bus address as opposed to a CPU address).
> > 
> > Always expose the CPU physical address to avoid this arch-dependent
> > behavior.
> > 
> > This change should have no user-visible effect because this file
> > currently
> > depends on CONFIG_HAVE_MMIOTRACE_SUPPORT, which is only defined for
> > x86,
> > and pci_resource_to_user() is a no-op on x86.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  kernel/trace/trace_mmiotrace.c |   10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_mmiotrace.c
> > b/kernel/trace/trace_mmiotrace.c
> > index 68f376c..cd7480d 100644
> > --- a/kernel/trace/trace_mmiotrace.c
> > +++ b/kernel/trace/trace_mmiotrace.c
> > @@ -68,19 +68,15 @@ static void mmio_print_pcidev(struct trace_seq
> > *s, const struct pci_dev *dev)
> >  	trace_seq_printf(s, "PCIDEV %02x%02x %04x%04x %x",
> >  			 dev->bus->number, dev->devfn,
> >  			 dev->vendor, dev->device, dev->irq);
> > -	/*
> > -	 * XXX: is pci_resource_to_user() appropriate, since we
> > are
> > -	 * supposed to interpret the __ioremap() phys_addr
> > argument based on
> > -	 * these printed values?
> > -	 */
> >  	for (i = 0; i < 7; i++) {
> > -		pci_resource_to_user(dev, i, &dev->resource[i],
> > &start, &end);
> > +		start = dev->resource[i].start;
> >  		trace_seq_printf(s, " %llx",
> >  			(unsigned long long)(start |
> >  			(dev->resource[i].flags &
> > PCI_REGION_FLAG_MASK)));
> >  	}
> >  	for (i = 0; i < 7; i++) {
> > -		pci_resource_to_user(dev, i, &dev->resource[i],
> > &start, &end);
> > +		start = dev->resource[i].start;
> > +		end = dev->resource[i].end;
> >  		trace_seq_printf(s, " %llx",
> >  			dev->resource[i].start < dev-
> > >resource[i].end ?
> >  			(unsigned long long)(end - start) + 1 :
> > 0);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

