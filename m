Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:60409 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab3HEWVk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 18:21:40 -0400
Received: by mail-qa0-f54.google.com with SMTP id bv4so1290723qab.13
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 15:21:39 -0700 (PDT)
Date: Mon, 5 Aug 2013 16:21:35 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130805222135.GA29875@google.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
 <20130805195149.GA19127@google.com>
 <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
 <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
 <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 05, 2013 at 02:09:27PM -0700, Yinghai Lu wrote:
> On Mon, Aug 5, 2013 at 1:59 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> then, we should drop that 4k capping.
> >> I was thinking there could be strange or wild res with bigger than 4k.
> >
> > If there *were* an I/O BAR larger than 4KB, how should it be handled?
> > I don't think capping the alignment to 4KB sounds like the best way.
> > For example, a 16KB I/O BAR would still need to be aligned on 16KB.
> >
> > And I think capping to 4KB as you did above will break the powerpc
> > pcibios_window_alignment() implementation.  For example, if
> > pcibios_window_alignment() returned 16KB, and we later capped it to
> > 4KB, we're going to allocate space for the bridge window with the
> > wrong alignment.
> 
> Agree.

OK.  Can you guys try this out and see whether it fixes the problem?
I don't know what the actual problem *is*, so I can't tell whether
this is a possible fix.

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d4f1ad9..8333c92 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -749,12 +749,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
-	resource_size_t min_align, io_align, align;
+	resource_size_t min_align, align;
 
 	if (!b_res)
  		return;
 
-	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
+	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
@@ -781,9 +781,6 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	if (min_align > io_align)
-		min_align = io_align;
-
 	size0 = calculate_iosize(size, min_size, size1,
 			resource_size(b_res), min_align);
 	if (children_add_size > add_size)
