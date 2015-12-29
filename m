Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34225 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbbL2U0T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2015 15:26:19 -0500
MIME-Version: 1.0
In-Reply-To: <8B8F62BE6EB1824D91A8BF961FDC40B9179AE6E3DF@AUSX7MCPS305.AMER.DELL.COM>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
	<1450427719-29619-3-git-send-email-hare@suse.de>
	<CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
	<567410D3.7030909@suse.de>
	<CAKgT0Uc9vZGHvtUuzv4EkE2d4-U5F=22-YeSAOWBH=vGa4yJ5Q@mail.gmail.com>
	<567414BE.5090800@suse.de>
	<8B8F62BE6EB1824D91A8BF961FDC40B9179AE6E3DD@AUSX7MCPS305.AMER.DELL.COM>
	<CAKgT0UffHMebLKB3pwG9YxoBL0m9sjjoBLhF8s-q12LJDK5tEg@mail.gmail.com>
	<8B8F62BE6EB1824D91A8BF961FDC40B9179AE6E3DF@AUSX7MCPS305.AMER.DELL.COM>
Date: Tue, 29 Dec 2015 12:26:19 -0800
Message-ID: <CAKgT0UfwWyvgCaUGmwHDqYpbTGL21r1yw_uEpKt9xssj3rDjhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Update VPD size with correct length
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Jordan_Hargrave@dell.com
Cc: Hannes Reinecke <hare@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 29, 2015 at 11:01 AM,  <Jordan_Hargrave@dell.com> wrote:
>>On Mon, Dec 28, 2015 at 9:29 PM,  <Jordan_Hargrave@dell.com> wrote:
>>> I had posted a patch recently to enable exposing the VPD-R valyes to sysfs.  I need access
>>> to these to parse into systemd for network naming (biosdevname style names).
>>>
>>>
>>> The VPD-R is a readonly area contained within the PCI Vital Product
>>> data.  There are some standard and vendor-specific keys stored in
>>> this region.
>>>
>>> PN = Part Number
>>> SN = Serial Number
>>> MN = Manufacturer ID
>>> Vx = Vendor-specific (x=0..9 A..Z)
>>>
>>> Biosdevname/Systemd will use these VPD keys for determining Network
>>> partitioning and port numbers for NIC cards
>>
>>Can you please repost this as a patch instead of as a reply to our
>>thread about VPD size.  The fact is the subject is misleading as your
>>patch isn't actually related to VPD sizing.
>>
>
> I had already posted this a few weeks back but never got any feedback.
>
> [PATCH] Create sysfs entries for VPD-R keys
> https://marc.info/?l=linux-pci&m=144959803316031&w=2

Next time I would recommend resubmitting with the people who might be
interested in the Cc instead of just throwing it into an existing
thread as it really just muddies the waters for the existing thread to
have it branch off like this.

>>> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
>>> ---
>>>  drivers/pci/pci-sysfs.c |  216 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pci.h     |    2 +
>>>  2 files changed, 218 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>> index eead54c..4966ece 100644
>>> --- a/drivers/pci/pci-sysfs.c
>>> +++ b/drivers/pci/pci-sysfs.c
>>> @@ -1295,6 +1295,210 @@ static struct bin_attribute pcie_config_attr = {
>>>         .write = pci_write_config,
>>>  };
>>>
>>> +static umode_t vpd_attr_exist(struct kobject *kobj,
>>> +                             struct attribute *attr, int n)
>>> +{
>>> +       struct device *dev;
>>> +       struct pci_dev *pdev;
>>> +       const char *name;
>>> +       int i;
>>> +
>>> +       dev = container_of(kobj, struct device, kobj);
>>> +       pdev = to_pci_dev(dev);
>>> +
>>> +       name = attr->name;
>>> +       if (pdev->vpdr_data == NULL)
>>> +               return 0;
>>> +       i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
>>> +                                     pdev->vpdr_len, name);
>>> +       return (i >= 0 ? S_IRUGO : 0);
>>> +}
>>> +
>>
>>So I assume there is another patch that implements
>>pci_vpd_find_info_keyword so that it can go through the vpdr_data and
>>parse it?
>>
>
> That's already an existing function in drivers/pci/vpd.c

I see that now.  Just had to do a bit of grepping through the code.
Looks like previously it was used by mostly the Broadcom network
device drivers.

>>> +static ssize_t vpd_attr_show(struct device *dev,
>>> +                            struct device_attribute *attr, char *buf)
>>> +{
>>> +       struct pci_dev *pdev;
>>> +       const char *name;
>>> +       char kv_data[257] = { 0 };
>>> +       int i, len;
>>> +
>>> +       pdev = to_pci_dev(dev);
>>> +       name = attr->attr.name;
>>> +       if (pdev->vpdr_data == NULL)
>>> +               return 0;
>>> +       i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
>>> +                                     pdev->vpdr_len, name);
>>> +       if (i >= 0) {
>>> +               len = pci_vpd_info_field_size(&pdev->vpdr_data[i]);
>>> +               memcpy(kv_data, pdev->vpdr_data + i +
>>> +                      PCI_VPD_INFO_FLD_HDR_SIZE, len);
>>> +               return scnprintf(buf, PAGE_SIZE, "%s\n", kv_data);
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>> +#define VPD_ATTR_RO(x) \
>>> +struct device_attribute vpd ## x = { \
>>> +       .attr = { .name = #x, .mode = S_IRUGO | S_IWUSR }, \
>>> +       .show = vpd_attr_show \
>>> +}
>>> +
>>> +VPD_ATTR_RO(PN);
>>> +VPD_ATTR_RO(EC);
>>> +VPD_ATTR_RO(MN);
>>> +VPD_ATTR_RO(SN);
>>> +VPD_ATTR_RO(V0);
>>> +VPD_ATTR_RO(V1);
>>> +VPD_ATTR_RO(V2);
>>> +VPD_ATTR_RO(V3);
>>> +VPD_ATTR_RO(V4);
>>> +VPD_ATTR_RO(V5);
>>> +VPD_ATTR_RO(V6);
>>> +VPD_ATTR_RO(V7);
>>> +VPD_ATTR_RO(V8);
>>> +VPD_ATTR_RO(V9);
>>> +VPD_ATTR_RO(VA);
>>> +VPD_ATTR_RO(VB);
>>> +VPD_ATTR_RO(VC);
>>> +VPD_ATTR_RO(VD);
>>> +VPD_ATTR_RO(VE);
>>> +VPD_ATTR_RO(VF);
>>> +VPD_ATTR_RO(VG);
>>> +VPD_ATTR_RO(VH);
>>> +VPD_ATTR_RO(VI);
>>> +VPD_ATTR_RO(VJ);
>>> +VPD_ATTR_RO(VK);
>>> +VPD_ATTR_RO(VL);
>>> +VPD_ATTR_RO(VM);
>>> +VPD_ATTR_RO(VN);
>>> +VPD_ATTR_RO(VO);
>>> +VPD_ATTR_RO(VP);
>>> +VPD_ATTR_RO(VQ);
>>> +VPD_ATTR_RO(VR);
>>> +VPD_ATTR_RO(VS);
>>> +VPD_ATTR_RO(VT);
>>> +VPD_ATTR_RO(VU);
>>> +VPD_ATTR_RO(VV);
>>> +VPD_ATTR_RO(VW);
>>> +VPD_ATTR_RO(VX);
>>> +VPD_ATTR_RO(VY);
>>> +VPD_ATTR_RO(VZ);
>>> +
>>> +static struct attribute *vpd_attributes[] = {
>>> +       &vpdPN.attr,
>>> +       &vpdEC.attr,
>>> +       &vpdMN.attr,
>>> +       &vpdSN.attr,
>>> +       &vpdV0.attr,
>>> +       &vpdV1.attr,
>>> +       &vpdV2.attr,
>>> +       &vpdV3.attr,
>>> +       &vpdV4.attr,
>>> +       &vpdV5.attr,
>>> +       &vpdV6.attr,
>>> +       &vpdV7.attr,
>>> +       &vpdV8.attr,
>>> +       &vpdV9.attr,
>>> +       &vpdVA.attr,
>>> +       &vpdVB.attr,
>>> +       &vpdVC.attr,
>>> +       &vpdVD.attr,
>>> +       &vpdVE.attr,
>>> +       &vpdVF.attr,
>>> +       &vpdVG.attr,
>>> +       &vpdVH.attr,
>>> +       &vpdVI.attr,
>>> +       &vpdVJ.attr,
>>> +       &vpdVK.attr,
>>> +       &vpdVL.attr,
>>> +       &vpdVM.attr,
>>> +       &vpdVN.attr,
>>> +       &vpdVO.attr,
>>> +       &vpdVP.attr,
>>> +       &vpdVQ.attr,
>>> +       &vpdVR.attr,
>>> +       &vpdVS.attr,
>>> +       &vpdVT.attr,
>>> +       &vpdVU.attr,
>>> +       &vpdVV.attr,
>>> +       &vpdVW.attr,
>>> +       &vpdVX.attr,
>>> +       &vpdVY.attr,
>>> +       &vpdVZ.attr,
>>> +       NULL,
>>> +};
>>> +
>>> +static struct attribute_group vpd_attr_group = {
>>> +       .name = "vpdr",
>>> +       .attrs = vpd_attributes,
>>> +       .is_visible = vpd_attr_exist,
>>> +};
>>> +
>>> +
>>> +static int pci_get_vpd_tag(struct pci_dev *dev, int off, int *len)
>>> +{
>>> +       u8  tag[3];
>>> +       int rc, tlen;
>>> +
>>> +       *len = 0;
>>> +       /* Quirk Atheros cards, reading VPD hangs system for 20s */
>>> +       if (dev->vendor == PCI_VENDOR_ID_ATHEROS ||
>>> +           dev->vendor == PCI_VENDOR_ID_ATTANSIC)
>>> +               return -ENOENT;
>>
>>I'm not really sure this is the right place for this type of quirk.
>>If this is really an issue maybe we should just disable VPD for these
>>devices.  Otherwise there isn't anything to stop someone from going in
>>and reading the VPD region via the existing VPD interfaces.
>>
>
> This could be moved elsewhere. There's a similar quirk for megaraid cards that was posted recently.
> [PATCH v4] pci: Limit VPD length for megaraid_sas adapter
>
>>> +       rc = pci_read_vpd(dev, off, 1, tag);
>>> +       if (rc != 1)
>>> +               return -ENOENT;
>>> +       if (tag[0] == 0x00 || tag[0] == 0xFF || tag[0] == 0x7F)
>>> +               return -ENOENT;
>>> +       if (tag[0] & PCI_VPD_LRDT) {
>>> +               rc = pci_read_vpd(dev, off+1, 2, tag+1);
>>> +               if (rc != 2)
>>> +                       return -ENOENT;
>>> +               tlen = pci_vpd_lrdt_size(tag) +
>>> +                       PCI_VPD_LRDT_TAG_SIZE;
>>> +       } else {
>>> +               tlen = pci_vpd_srdt_size(tag) +
>>> +                       PCI_VPD_SRDT_TAG_SIZE;
>>> +               tag[0] &= ~PCI_VPD_SRDT_LEN_MASK;
>>> +       }
>>> +       /* Verify VPD tag fits in area */
>>> +       if (tlen + off > dev->vpd->len)
>>> +               return -ENOENT;
>>> +       *len = tlen;
>>> +       return tag[0];
>>> +}
>>> +
>>> +static int pci_load_vpdr(struct pci_dev *dev)
>>> +{
>>> +       int rlen, ilen, tag, rc;
>>> +
>>> +       /* Check for VPD-I and VPD-R tag */
>>> +       tag = pci_get_vpd_tag(dev, 0, &ilen);
>>> +       if (tag != PCI_VPD_LRDT_ID_STRING)
>>> +               return -ENOENT;
>>> +       tag = pci_get_vpd_tag(dev, ilen, &rlen);
>>> +       if (tag != PCI_VPD_LRDT_RO_DATA)
>>> +               return -ENOENT;
>>> +
>>> +       rlen -= PCI_VPD_LRDT_TAG_SIZE;
>>> +       dev->vpdr_len = rlen;
>>> +       dev->vpdr_data = kzalloc(rlen, GFP_ATOMIC);
>>> +       if (dev->vpdr_data == NULL)
>>> +               return -ENOMEM;
>>> +
>>
>>Why not cache the ID string as well?  Seems like it might be a field
>>people would want to read on a regular basis in order to find out what
>>is there.
>>
> I could add that. What should attribute be called, 'vpdinfo', 'vpdi', etc?

I'd say keep it simple.  Maybe something like 'id-string' since that
is the name of the tag.
