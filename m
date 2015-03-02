Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:59908 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbbCBH7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 02:59:46 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 17:59:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6352D2CE804E
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2015 18:59:42 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t227xYH438797346
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:59:42 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t227x8As006317
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:59:09 +1100
Date: Mon, 2 Mar 2015 15:58:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v12 17/21] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150302075852.GJ21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083457.32124.55534.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224090037.GK6220@google.com>
 <CAErSpo7Yce518DXejsZW0cS34GFKYLxhctSoqk0y_C5UAiDQ9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7Yce518DXejsZW0cS34GFKYLxhctSoqk0y_C5UAiDQ9A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 11:10:33AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 3:00 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Feb 24, 2015 at 02:34:57AM -0600, Bjorn Helgaas wrote:
>>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>
>>> On PowerNV platform, resource position in M64 implies the PE# the resource
>>> belongs to.  In some cases, adjustment of a resource is necessary to locate
>>> it to a correct position in M64.
>>>
>>> Add pnv_pci_vf_resource_shift() to shift the 'real' PF IOV BAR address
>>> according to an offset.
>>>
>>> [bhelgaas: rework loops, rework overlap check, index resource[]
>>> conventionally, remove pci_regs.h include, squashed with next patch]
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> ...
>>
>>> +#ifdef CONFIG_PCI_IOV
>>> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>> +{
>>> +     struct pci_dn *pdn = pci_get_pdn(dev);
>>> +     int i;
>>> +     struct resource *res, res2;
>>> +     resource_size_t size;
>>> +     u16 vf_num;
>>> +
>>> +     if (!dev->is_physfn)
>>> +             return -EINVAL;
>>> +
>>> +     /*
>>> +      * "offset" is in VFs.  The M64 windows are sized so that when they
>>> +      * are segmented, each segment is the same size as the IOV BAR.
>>> +      * Each segment is in a separate PE, and the high order bits of the
>>> +      * address are the PE number.  Therefore, each VF's BAR is in a
>>> +      * separate PE, and changing the IOV BAR start address changes the
>>> +      * range of PEs the VFs are in.
>>> +      */
>>> +     vf_num = pdn->vf_pes;
>>> +     for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>> +             res = &dev->resource[i + PCI_IOV_RESOURCES];
>>> +             if (!res->flags || !res->parent)
>>> +                     continue;
>>> +
>>> +             if (!pnv_pci_is_mem_pref_64(res->flags))
>>> +                     continue;
>>> +
>>> +             /*
>>> +              * The actual IOV BAR range is determined by the start address
>>> +              * and the actual size for vf_num VFs BAR.  This check is to
>>> +              * make sure that after shifting, the range will not overlap
>>> +              * with another device.
>>> +              */
>>> +             size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>>> +             res2.flags = res->flags;
>>> +             res2.start = res->start + (size * offset);
>>> +             res2.end = res2.start + (size * vf_num) - 1;
>>> +
>>> +             if (res2.end > res->end) {
>>> +                     dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
>>> +                             i, &res2, res, vf_num, offset);
>>> +                     return -EBUSY;
>>> +             }
>>> +     }
>>> +
>>> +     for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>> +             res = &dev->resource[i + PCI_IOV_RESOURCES];
>>> +             if (!res->flags || !res->parent)
>>> +                     continue;
>>> +
>>> +             if (!pnv_pci_is_mem_pref_64(res->flags))
>>> +                     continue;
>>> +
>>> +             size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>>> +             res2 = *res;
>>> +             res->start += size * offset;
>>
>> I'm still not happy about this fiddling with res->start.
>>
>> Increasing res->start means that in principle, the "size * offset" bytes
>> that we just removed from res are now available for allocation to somebody
>> else.  I don't think we *will* give that space to anything else because of
>> the alignment restrictions you're enforcing, but "res" now doesn't
>> correctly describe the real resource map.
>>
>> Would you be able to just update the BAR here while leaving the struct
>> resource alone?  In that case, it would look a little funny that lspci
>> would show a BAR value in the middle of the region in /proc/iomem, but
>> the /proc/iomem region would be more correct.
>
>I guess this would also require a tweak where we compute the addresses
>of each of the VF resources.  Today it's probably just "base + VF_num
>* size", where "base" is res->start.  We'd have to account for the
>offset there if we don't adjust it here.
>

Oh, this is really an interesting idea.

I will do some tests to see the result.

>>> +
>>> +             dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
>>> +                      i, &res2, res, vf_num, offset);
>>> +             pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>>> +     }
>>> +     pdn->max_vfs -= offset;
>>> +     return 0;
>>> +}
>>> +#endif /* CONFIG_PCI_IOV */

-- 
Richard Yang
Help you, Help me

