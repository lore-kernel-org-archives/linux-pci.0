Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39434 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab2ICIHr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Sep 2012 04:07:47 -0400
Received: by pbbrr13 with SMTP id rr13so7729108pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 03 Sep 2012 01:07:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120827073335.GE20843@ram-ThinkPad-T61>
References: <CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
	<20120816044104.GQ2449@ram-ThinkPad-T61>
	<20120821151245.GA2356@ram-ThinkPad-T61>
	<CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
	<20120822101533.GA2332@ram-ThinkPad-T61>
	<CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
	<CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
	<CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
	<20120823050958.GB2332@ram-ThinkPad-T61>
	<CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
	<20120827073335.GE20843@ram-ThinkPad-T61>
Date: Mon, 3 Sep 2012 01:07:46 -0700
Message-ID: <CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 27, 2012 at 12:33 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Thu, Aug 23, 2012 at 12:30:05PM -0700, Yinghai Lu wrote:
>> Hi, Ram and Bjorn,
>>
>> On Wed, Aug 22, 2012 at 10:09 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>> > +static inline int pci_next_resource_idx(int i, int flag)
>> > +{
>> > +       while (++i < PCI_NUM_RESOURCES) {
>> > +               if ((i >= 0 && i < PCI_ROM_RESOURCE && (flag & PCI_STD_RES)) ||
>> > +                   (i == PCI_ROM_RESOURCE && (flag & PCI_ROM_RES)) ||
>> > +#ifdef CONFIG_PCI_IOV
>> > +                   (i <= PCI_IOV_RESOURCE_END && (flag & PCI_IOV_RES)) ||
>> > +#endif
>> > +                   (i <= PCI_BRIDGE_RESOURCE_END && (flag & PCI_BRIDGE_RES)))
>> > +                       return i;
>> > +       }
>> > +       return -1;
>> > +}
>>
>> no, you can not merge them.
>> when it start as -1, and user only need the bridge resource, it will
>> loop from 0 to 16.
>
> True. But the logic by itself is not wrong. It is sub-optimal.
>
>>
>> I optimized it more to skip some searching. please check v5 and v6.
>> v5 will store aside the mask, and use the bit map later.
>> v6 will still to do the local checking, but will skip some ++i loop.
>
> :) The v5 patch; the bitmask one, took me some time to understand.
> But yes it does a good job.
>
> There is one thing I dont like in that patch. You have to call to
> pci_dev_resource_n(), but that function is not there anywhere in
> upstream tree. Its only in your tree. Can we bring pci_dev_resource_n()
> into this patch and make it self-sustained?

I'd like to keep every patch to be smaller.

>
> Also, please find below, one other patch proposal, which improves upon
> your v5 patch. Instead of having a array of bitmask, this patch
> maintains a single dimensional array with an entry for each resource.
> Each entry captures its type; ie PCI_RES_*,  and index of the starting location
> of the next resource type.  Using this information one can quickly cut down on
> the number of useless iterations. It also does compile time
> initialization of the array, unlike the v5 patch which does runtime
> initialization.

only one time. and could move the initialization call to other place.

>
> Please decide which version you want and lets take the next step. I
> think we have iterated over this interface quite a lot. Time to move on
> :)
>
>
> ---------------------------------------------------------------------
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5e1ca3c..d95a31c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -146,6 +146,54 @@ static int __init pcibus_class_init(void)
>  }
>  postcore_initcall(pcibus_class_init);
>
> +
> +#define PCI_RES_SHIFT 4
> +/*
> + * capture the starting index of the next resource type
> + * as well as the type of the resource
> + */
> +int res_idx[PCI_NUM_RESOURCES] = {
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES   */
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+1 */
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+2 */
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+3 */
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+4 */
> +(PCI_ROM_RESOURCE << PCI_RES_SHIFT) | PCI_STD_RES, /* PCI_STD_RESOURCES+5 */
> +(PCI_IOV_RESOURCES << PCI_RES_SHIFT) | PCI_ROM_RES, /* PCI_ROM_RESOURCE */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+1 */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+2 */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+3 */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+4 */
> +(PCI_BRIDGE_RESOURCES << PCI_RES_SHIFT) | PCI_IOV_RES, /* PCI_IOV_START+5 */
> +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START */
> +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+1 */
> +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+2 */
> +(PCI_NUM_RESOURCES << PCI_RES_SHIFT) | PCI_BRIDGE_RES, /* PCI_BRIDGE_START+3 */
> +};

how about some one change the some type resource number?

better have some marco helper.

> +#define res_type(idx)  (res_idx[idx] &  ((0x1 << PCI_RES_SHIFT) - 1))
> +#define res_next(idx)  (res_idx[idx] >> PCI_RES_SHIFT)
> +
> +int pci_next_resource_idx(int i, int flag)
> +{
> +       i++;
> +       while (i < PCI_NUM_RESOURCES) {
> +               if (res_type(i) & flag)
> +                       return i;
> +               i = res_next(i);
> +       }

here still have some two extra loop when only need to loop STD + BRIDGE.

> +       return -1;
> +}
> +
> +struct resource *pci_dev_resource_n(struct pci_dev *dev, int n)
> +{
> +       if (n >= 0 && n < PCI_NUM_RESOURCES)
> +               return &dev->resource[n];
> +
> +       return NULL;
> +}
> +
> +
>  static u64 pci_size(u64 base, u64 maxbase, u64 mask)
>  {
>         u64 size = mask & maxbase;      /* Find the significant bits */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e444f5b..adae706 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1351,6 +1351,25 @@ static inline int pci_domain_nr(struct pci_bus *bus)
>          (pci_resource_end((dev), (bar)) -              \
>           pci_resource_start((dev), (bar)) + 1))
>
> +#define PCI_STD_RES            (1<<0)
> +#define PCI_ROM_RES            (1<<1)
> +#define PCI_BRIDGE_RES         (1<<2)
> +#define PCI_IOV_RES            (1<<3)
> +#define PCI_ALL_RES    (PCI_STD_RES|PCI_ROM_RES|PCI_BRIDGE_RES|PCI_IOV_RES)
> +#define PCI_NOSTD_RES          (PCI_ALL_RES & ~PCI_STD_RES)
> +#define PCI_NOIOV_RES          (PCI_ALL_RES & ~PCI_IOV_RES)
> +#define PCI_NOROM_RES          (PCI_ALL_RES & ~PCI_ROM_RES)
> +#define PCI_NOBRIDGE_RES       (PCI_ALL_RES & ~PCI_BRIDGE_RES)
> +#define PCI_STD_ROM_RES                (PCI_STD_RES | PCI_ROM_RES)
> +#define PCI_STD_IOV_RES                (PCI_STD_RES | PCI_IOV_RES)
> +#define PCI_STD_ROM_IOV_RES    (PCI_NOBRIDGE_RES)
> +#define for_each_pci_resource(dev, res, flag) \
> +       for (i = pci_next_resource_idx(-1, flag), \
> +                       res = pci_dev_resource_n(dev, i); \
> +            res; \
> +            i = pci_next_resource_idx(i, flag), \
> +                       res = pci_dev_resource_n(dev, i))
> +
>  /* Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>   * the generic device structure functions of these calls.
>
