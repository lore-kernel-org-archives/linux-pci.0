Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34819 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933567AbbLRHoN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Dec 2015 02:44:13 -0500
Subject: Re: [PATCH 2/2] pci: Update VPD size with correct length
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <1450339169-52542-1-git-send-email-hare@suse.de>
 <1450339169-52542-3-git-send-email-hare@suse.de>
 <CAKgT0Uc5sX0=BYMUbnd2xaRtN8oahy77q=_FBiB-_YvRxhtG0Q@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5673B948.9020606@suse.de>
Date: Fri, 18 Dec 2015 08:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uc5sX0=BYMUbnd2xaRtN8oahy77q=_FBiB-_YvRxhtG0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/17/2015 06:13 PM, Alexander Duyck wrote:
> On Wed, Dec 16, 2015 at 11:59 PM, Hannes Reinecke <hare@suse.de> wrote:
>> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
>> be smaller than that. To figure out the actual size one has to read
>> the VPD area until the 'end marker' is reached.
>> Trying to read VPD data beyond that marker results in 'interesting'
>> effects, from simple read errors to crashing the card. And to make
>> matters worse not every PCI card implements this properly, leaving
>> us with no 'end' marker or even completely invalid data.
>> This path modifies the size of the VPD attribute to the available
>> size, and disables the VPD attribute altogether if no valid data
>> could be read.
>>
>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/pci/access.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 59ac36f..0a647b1 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -475,6 +475,56 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
>>          .release = pci_vpd_pci22_release,
>>   };
>>
>> +/**
>> + * pci_vpd_size - determine actual size of Vital Product Data
>> + * @dev:       pci device struct
>> + * @old_size:  current assumed size, also maximum allowed size
>> + *
>
> "old_siz"e was dropped so you can remove this line.
>
>> + */
>> +static size_t
>> +pci_vpd_pci22_size(struct pci_dev *dev)
>> +{
>> +       size_t off = 0;
>> +       unsigned char header[1+2];      /* 1 byte tag, 2 bytes length */
>> +
>> +       while (off < PCI_VPD_PCI22_SIZE &&
>> +              pci_read_vpd(dev, off, 1, header) == 1) {
>> +               unsigned char tag;
>> +
>
> The offset comparison is probably redundant.  There is already a check
> in pci_vpd_pci22_read that will check the offset and return -EINVAL if
> we have exceeded vpd->base.len.  As such you can probably just do the
> pci_read_vpd comparison and drop the offset length entirely.
>
Indeed it does. Will be doing so.

>> +               if (header[0] & PCI_VPD_LRDT) {
>> +                       /* Large Resource Data Type Tag */
>> +                       tag = pci_vpd_lrdt_tag(header);
>> +                       /* Only read length from known tag items */
>> +                       if ((tag == PCI_VPD_LTIN_ID_STRING) ||
>> +                           (tag == PCI_VPD_LTIN_RO_DATA) ||
>> +                           (tag == PCI_VPD_LTIN_RW_DATA)) {
>> +                               if (pci_read_vpd(dev, off+1, 2,
>> +                                                &header[1]) != 2)
>> +                                       return off + 1;
>> +                               off += PCI_VPD_LRDT_TAG_SIZE +
>> +                                       pci_vpd_lrdt_size(header);
>> +                       }
>> +               } else {
>> +                       /* Short Resource Data Type Tag */
>> +                       off += PCI_VPD_SRDT_TAG_SIZE +
>> +                               pci_vpd_srdt_size(header);
>> +                       tag = pci_vpd_srdt_tag(header);
>> +               }
>> +               if (tag == PCI_VPD_STIN_END)    /* End tag descriptor */
>> +                       return off;
>> +               if ((tag != PCI_VPD_LTIN_ID_STRING) &&
>> +                   (tag != PCI_VPD_LTIN_RO_DATA) &&
>> +                   (tag != PCI_VPD_LTIN_RW_DATA)) {
>> +                       dev_dbg(&dev->dev,
>> +                               "invalid %s vpd tag %02x at offset %zu.",
>> +                               (header[0] & PCI_VPD_LRDT) ? "large" : "short",
>> +                               tag, off);
>> +                       break;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>>   int pci_vpd_pci22_init(struct pci_dev *dev)
>>   {
>>          struct pci_vpd_pci22 *vpd;
>> @@ -497,6 +547,13 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
>>          vpd->cap = cap;
>>          vpd->busy = false;
>>          dev->vpd = &vpd->base;
>> +       vpd->base.len = pci_vpd_pci22_size(dev);
>> +       if (vpd->base.len == 0) {
>> +               dev_dbg(&dev->dev, "Disabling VPD access.");
>> +               dev->vpd = NULL;
>> +               kfree(vpd);
>> +               return -ENXIO;
>> +       }
>>          return 0;
>>   }
>
> It looks like this still doesn't address the VPD_REF_F0 issue I
> mentioned earlier.  We don't need to compute the length for each
> function we only need to do it once.  I would recommend modifying
> things so that you set vpd->base.len to 0 if the VPD_REF_F0 flag is
> set.
>
But that would effectively inhibit access to the VPD on those 
devices, rendering the entire 'f0_ops' thingie quite pointless, right?

I think it's better to directly retrieve the VPD length from the 
base pci device, that would give us the correct length _and_ save 
duplicate calculations.

> Also I wouldn't delete the vpd configuration if the length is not
> correct as that will likely break several quirks that already exist
> that are setting the length.  Also there is no need to return an
> error, the fact is the part has VPD but we cannot determine the length
> as such the correct solution is to leave it at 0.  We can leave that
> for a quirk to sort out later if needed.  You could probably move the
> dev_dbg message to just before the return 0 in the pci_vpd_pci22_size
> call and drop the entire if statement in the init function.
>
Okay.
Will be sending a new patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
