Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34064 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab2ICJIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Sep 2012 05:08:30 -0400
Received: from /spool/local
	by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 3 Sep 2012 05:08:29 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D32E9C90040
	for <linux-pci@vger.kernel.org>; Mon,  3 Sep 2012 05:08:26 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8398QSc111026
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 05:08:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8398Qlh020529
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 06:08:26 -0300
Date: Mon, 3 Sep 2012 17:08:21 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
Message-ID: <20120903090821.GC2438@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120821151245.GA2356@ram-ThinkPad-T61>
 <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
 <20120822101533.GA2332@ram-ThinkPad-T61>
 <CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
 <CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
 <CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
 <20120823050958.GB2332@ram-ThinkPad-T61>
 <CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
 <20120827073335.GE20843@ram-ThinkPad-T61>
 <CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 03, 2012 at 01:07:46AM -0700, Yinghai Lu wrote:
> On Mon, Aug 27, 2012 at 12:33 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Thu, Aug 23, 2012 at 12:30:05PM -0700, Yinghai Lu wrote:
> >> Hi, Ram and Bjorn,
> >>
> >> On Wed, Aug 22, 2012 at 10:09 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> >> > +static inline int pci_next_resource_idx(int i, int flag)
> >> > +{
> >> > +       while (++i < PCI_NUM_RESOURCES) {
> >> > +               if ((i >= 0 && i < PCI_ROM_RESOURCE && (flag & PCI_STD_RES)) ||
> >> > +                   (i == PCI_ROM_RESOURCE && (flag & PCI_ROM_RES)) ||
> >> > +#ifdef CONFIG_PCI_IOV
> >> > +                   (i <= PCI_IOV_RESOURCE_END && (flag & PCI_IOV_RES)) ||
> >> > +#endif
> >> > +                   (i <= PCI_BRIDGE_RESOURCE_END && (flag & PCI_BRIDGE_RES)))
> >> > +                       return i;
> >> > +       }
> >> > +       return -1;
> >> > +}
> >>

.snip....

> >
> > Please decide which version you want and lets take the next step. I
> > think we have iterated over this interface quite a lot. Time to move on
> > :)
> >
> >
> > ---------------------------------------------------------------------
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 5e1ca3c..d95a31c 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -146,6 +146,54 @@ static int __init pcibus_class_init(void)
> >  }
> >  postcore_initcall(pcibus_class_init);
> >
> > +
> > +#define PCI_RES_SHIFT 4
> > +/*
> > + * capture the starting index of the next resource type
> > + * as well as the type of the resource
> > + */
> > +int res_idx[PCI_NUM_RESOURCES] = {
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES   */
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+1 */
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+2 */
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+3 */
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+4 */
> > +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+5 */
> > +(PCI_IOV_RESOURCES << PCI_RES_SHIFT) | PCI_ROM_RES, /* PCI_ROM_RESOURCE */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+1 */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+2 */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+3 */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+4 */
> > +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+5 */
> > +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START */
> > +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+1 */
> > +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+2 */
> > +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+3 */
> > +};
> 
> how about some one change the some type resource number?

She/he will have to change this code correspondingly. :) I can put in
some comments towards that. However this iterator implementation will
eventually change anyway; ones we restructure the resources in pci_dev
structure.

> 
> better have some marco helper.
> 
> > +#define res_type(idx)  (res_idx[idx] &  ((0x1 << PCI_RES_SHIFT) - 1))
> > +#define res_next(idx)  (res_idx[idx] >> PCI_RES_SHIFT)
> > +
> > +int pci_next_resource_idx(int i, int flag)
> > +{
> > +       i++;
> > +       while (i < PCI_NUM_RESOURCES) {
> > +               if (res_type(i) & flag)
> > +                       return i;
> > +               i = res_next(i);
> > +       }
> 
> here still have some two extra loop when only need to loop STD + BRIDGE.

true. its a tradeoff between space; your bitmap patch, and time; my code
above.  The loss of a few cycles or a few bytes of memory should be
highly insignificant in the grand scheme, as long as it is bounded by a
constant.

Anyway I am ok with either patch.
RP

