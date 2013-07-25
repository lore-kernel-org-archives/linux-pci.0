Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:37561 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3GYVW5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 17:22:57 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so5715999oag.13
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 14:22:56 -0700 (PDT)
Date: Thu, 25 Jul 2013 15:22:53 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130725212253.GA25183@google.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1372691432-6440-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5O6CdzSw3bQyuKXsP+H0deJtGL1kXU+ddf_reA+ECq6w@mail.gmail.com>
 <20130709032019.GC7094@weiyang.vnet.ibm.com>
 <CAErSpo76aKk_Nq=MuL6Rsf98+fTxXQe=bJ-wQOhosKSDoYC8Ew@mail.gmail.com>
 <20130710013442.GA6671@weiyang.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710013442.GA6671@weiyang.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 10, 2013 at 09:34:42AM +0800, Wei Yang wrote:
> On Tue, Jul 09, 2013 at 11:38:06AM -0600, Bjorn Helgaas wrote:
> >On Mon, Jul 8, 2013 at 9:20 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> >> On Mon, Jul 08, 2013 at 03:15:13PM -0600, Bjorn Helgaas wrote:
> >>>On Mon, Jul 1, 2013 at 9:10 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> >>>> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
> >>>> it introduce a new method to calculate the window alignment of P2P bridge.
> >>>>
> >>>> When the io_window_1k is set,  the calculation for the io resource alignment
> >>>> is different from the original one. In the original logic before 462d9303,
> >>>> the alignment is no bigger than 4K even the io_window_1k is set. The logic
> >>>> introduced in 462d9303 will limit the alignment to 1k in this case.
> >>>>
> >>>> This patch fix this issue.
> >>>>
> >>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >>>> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> >>>> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> >>>> ---
> >>>>  drivers/pci/setup-bus.c |    4 ++++
> >>>>  1 files changed, 4 insertions(+), 0 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >>>> index bd0ce39d..5c60ca0 100644
> >>>> --- a/drivers/pci/setup-bus.c
> >>>> +++ b/drivers/pci/setup-bus.c
> >>>> @@ -755,6 +755,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >>>>                 return;
> >>>>
> >>>>         io_align = min_align = window_alignment(bus, IORESOURCE_IO);
> >>>> +       /* Don't exceed 4KiB for windows requesting 1KiB alignment */
> >>>> +       if (bus->self->io_window_1k && io_align == PCI_P2P_DEFAULT_IO_ALIGN_1K)
> >>>> +               io_align = PCI_P2P_DEFAULT_IO_ALIGN;
> >>>
> >>>Please explain why we need this change, with some actual values that
> >>>show the problem.  We need to know what the problem is, not merely
> >>>that the code behaves differently than it did before 462d9303.
> >>
> >> Yep, sorry for not listing the exact problem value.
> >>
> >> Assume:
> >>         1. pcibios_window_alignment() return 1.
> >>         2. window_alignment() return PCI_P2P_DEFAULT_IO_ALIGN_1K.
> >>         3. one of the child device has an IO resource with size of 2K.
> >>
> >> Result comparison:
> >>
> >>                     Before 462d9303             After 462d9303
> >>     min_align       1k                          1k
> >>                                         |
> >>                              after loop |
> >>                                         V
> >>     min_align       2k                          2k
> >>                                         |
> >>                          check boundary |
> >>                                         V
> >>     min_align       2k                          1k
> >>
> >> In this case, with 462d9303 the min_align will be set back to 1k even one of
> >> the child require 2k alignment.
> >>
> >>>
> >>>It appears to me that this change will break the ability to use 1K
> >>>windows.  For example, assume a bridge that supports 1K windows.
> >>>Assume we're using the default pcibios_window_alignment().  Currently
> >>>window_alignment() on the secondary bus returns
> >>>PCI_P2P_DEFAULT_IO_ALIGN_1K (0x400, which is 1K), so io_align = 0x400.
> >>>
> >>>With your change, I think io_align will be bumped back up to 4K in
> >>>this case, so we'll lose the ability to allocate a 1K window.
> >>
> >> After applying the change:
> >>
> >> Assume:
> >>         1. pcibios_window_alignment() return 1.
> >>         2. window_alignment() return PCI_P2P_DEFAULT_IO_ALIGN_1K.
> >>         3. one of the child device has an IO resource with size of 2K.
> >
> >What happens if no child has an I/O resource larger than 1K?  Can we
> >allocate a 1K window with 1K alignment in that case?
> >
> 
> Yes, it could. The result comparison would look like this.
> Since no child has an I/O resource larger than 1k, the min_align will remain
> 1k after loop. And because io_align(4K) is larger than min_align(1k), the
> final min_align would be 1k.
> 
> In this case, the code from commit 462d9303 and my patch both works.
> 
>  Result comparison:
>                      with  462d9303             with this patch
>      min_align       1k                          1k
>      io_align        1k                          4k
>                                          |
>                               after loop |
>                                          V
>      min_align       1k                          1k
>      io_align        1k                          4k
>                                          |
>                           check boundary |
>                                          V
>      min_align       1k                          1k
>      io_align        1k                          4k
> 
> >> Result comparison:
> >>
> >>                     with  462d9303             with this patch
> >>     min_align       1k                          1k
> >>     io_align        1k                          4k
> >>                                         |
> >>                              after loop |
> >>                                         V
> >>     min_align       2k                          2k
> >>     io_align        1k                          4k
> >>                                         |
> >>                          check boundary |
> >>                                         V
> >>     min_align       1k                          2k
> >>     io_align        1k                          4k
> >>
> >> With this patch, in the same case as above, the min_align is 2k after
> >> calculation.
> >>
> >> In my mind, the min_align is the lower bound, io_align is the upper bound. The
> >> final result of min_align should be in this range.
> >>
> >> Is my understanding correct? or I missed something important?

Since Gavin has reviewed this, I'm OK with it.  If you resend the series
with the updated changelogs and so on, I'll apply it.

Bjorn

> >>
> >>>
> >>>>         list_for_each_entry(dev, &bus->devices, bus_list) {
> >>>>                 int i;
> >>>>
> >>>> --
> >>>> 1.7.5.4
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>--
> >>>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >> --
> >> Richard Yang
> >> Help you, Help me
> >>
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Richard Yang
> Help you, Help me
> 
