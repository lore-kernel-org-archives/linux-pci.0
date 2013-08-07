Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:35762 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab3HGCB7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 22:01:59 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 7 Aug 2013 11:51:19 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7784E3578050
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2013 12:01:55 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r7721iVQ10486266
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 12:01:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r7721ssv014031
	for <linux-pci@vger.kernel.org>; Wed, 7 Aug 2013 12:01:54 +1000
Date: Wed, 7 Aug 2013 10:01:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130807020152.GB6976@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <20130806061924.GB10876@weiyang.vnet.ibm.com>
 <20130806134421.GD31970@google.com>
 <20130806154742.GB10680@weiyang.vnet.ibm.com>
 <20130806180155.GB1246@google.com>
 <20130806205646.GA3590@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806205646.GA3590@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 02:56:46PM -0600, Bjorn Helgaas wrote:
>On Tue, Aug 06, 2013 at 12:01:55PM -0600, Bjorn Helgaas wrote:
>> On Tue, Aug 06, 2013 at 11:47:42PM +0800, Wei Yang wrote:
>> > On Tue, Aug 06, 2013 at 07:44:21AM -0600, Bjorn Helgaas wrote:
>> > >On Tue, Aug 06, 2013 at 02:19:24PM +0800, Wei Yang wrote:
>> > >> On Mon, Aug 05, 2013 at 11:58:50AM -0600, Bjorn Helgaas wrote:
>> > >> >[+cc Yinghai]
>> > >> >
>> > >> >On Fri, Aug 2, 2013 at 3:31 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> > >> >> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
>> > >> >> it introduce a new method to calculate the window alignment of P2P bridge.
>> > >> >>
>> > >> >> When the io_window_1k is set,  the calculation for the io resource alignment
>> > >> >> is different from the original one. In the original logic before 462d9303,
>> > >> >> the alignment is no bigger than 4K even the io_window_1k is set. The logic
>> > >> >> introduced in 462d9303 will limit the alignment to 1k in this case.
>> > >> >>
>> > >> >> This patch fix this issue.
>> > >> >
>> > >> >Presumably this fixes a bug, but you don't say what it is.  "different
>> > >> >from the original" is not a description of a problem.  You need
>> > >> >something like "with the current code, we allocate the wrong window
>> > >> >size in situation X, or we allocate a window with incorrect alignment
>> > >> >in situation Y, etc."
>> > >> >
>> > >> 
>> > >> With current code, we allocate the wrong window size when upstream bridge
>> > >> could be 1k aligned and one of the downstream port is 4k aligned.
>> > >> 
>> > >> In this case, the "min_align" should be 4k. But the current code set
>> > >> "min_align" to 1k.
>> > >
>> > 
>> > Hmm... sorry I should say. 
>> > 
>> > With current code, we allocate the wrong window size and alignment when upstream 
>> > bridge could be 1k aligned and one of the downstream port is 4k aligned.
>> > 
>> > In this case, the "min_align" should be 4k. But the current code set
>> > "min_align" to 1k.
>> 
>> Actually, I think only the alignment is wrong (not the size).  But I do
>> agree that this looks like a problem in the current code.  I'll write
>> this up and post the patch soon.
>
>Here's the patch I propose.  The code change is the same as I posted
>yesterday; only the changelog is new.  I'll put these in next pending
>comments.
>
>Bjorn
>
>
>commit 2d1d66780ecd12c9518835303f5302fc5262d49b
>Author: Bjorn Helgaas <bhelgaas@google.com>
>Date:   Mon Aug 5 16:15:10 2013 -0600
>
>    PCI: Align bridge I/O windows as required by downstream devices & bridges
>    
>    An upstream bridge's I/O window must be at least as aligned as any
>    downstream device or bridge requires.  In particular, if the upstream
>    bridge supports 1K alignment but a downstream bridge requires 4K alignment,
>    the upstream window must also be 4K aligned.
>    
>    Therefore, do not reduce the required alignment ("min_align") based on
>    the upstream bridge's capabilities.
>    
>    Reported-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>    Suggested-by: Yinghai Lu <yinghai@kernel.org>
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>index d4f1ad9..8333c92 100644
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -749,12 +749,12 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
> 	resource_size_t size = 0, size0 = 0, size1 = 0;
> 	resource_size_t children_add_size = 0;
>-	resource_size_t min_align, io_align, align;
>+	resource_size_t min_align, align;
>
> 	if (!b_res)
>  		return;
>
>-	io_align = min_align = window_alignment(bus, IORESOURCE_IO);
>+	min_align = window_alignment(bus, IORESOURCE_IO);
> 	list_for_each_entry(dev, &bus->devices, bus_list) {
> 		int i;
>
>@@ -781,9 +781,6 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> 		}
> 	}
>
>-	if (min_align > io_align)
>-		min_align = io_align;
>-
> 	size0 = calculate_iosize(size, min_size, size1,
> 			resource_size(b_res), min_align);
> 	if (children_add_size > add_size)

This looks good to me.

-- 
Richard Yang
Help you, Help me

