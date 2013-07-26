Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:50787 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab3GZNJw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 09:09:52 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so2191168oag.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2013 06:09:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4xftQjwKHsenuKuEvT10iOa+DuiYfSyJYLhp=ObcDZsQ@mail.gmail.com>
References: <1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com> <CAErSpo4xftQjwKHsenuKuEvT10iOa+DuiYfSyJYLhp=ObcDZsQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Jul 2013 07:09:31 -0600
Message-ID: <CAErSpo5AqqFy5uM+bQNiGnqKyRMwCwHOzta6NV4ZnBi2vJxD8A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add quirk for setting valid class for FSL PCI host bridge
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[-cc Anton (bounced)]

On Fri, Jul 26, 2013 at 7:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Ben, Paul, Minghuan, Kumar, Anton, linuxppc-dev
>
> On Fri, Jul 26, 2013 at 1:23 AM, Chunhe Lan <Chunhe.Lan@freescale.com> wrote:
>> Freescale platform has class code = 0x0b2000, when it boots. This makes
>> kernel PCI bus code to setup these devices resulting into the following
>> notice information when trying to enable them:
>>
>> pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
>>
>> This patch adds a ID specific(PCI_VENDOR_ID_FREESCALE & PCI_ANY_ID based)
>> 'early' fixup quirk to replace class code with PCI_CLASS_BRIDGE_PCI as
>> class. Then the above information disappears.
>>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/quirks.c |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index e85d230..906a04a3 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2772,6 +2772,16 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x342e, vtd_mask_spec_errors);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
>>  #endif
>>
>> +#ifdef CONFIG_FSL_PCI
>> +static void quirk_freescale_class(struct pci_dev *dev)
>> +{
>> +       dev_info(&dev->dev, "Setting PCI class for FSL PCI host bridge\n");
>> +       dev->class = (PCI_CLASS_BRIDGE_PCI << 8) | (dev->class & 0xff);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
>> +                       quirk_freescale_class);
>
> 1.  This looks an awful lot like quirk_fsl_pcie_head().
> quirk_fsl_pcie_head() is currently a HEADER quirk, but that runs
> *after* pci_setup_device(), where dev->class is used.  I suspect this
> should be an EARLY quirk instead.  But this quirk has a long history
> as a HEADER quirk, and I'm sure many people have tested it, so I don't
> know what's going on.
>
> 2.  I assume the Freescale vendor ID might be used for devices other
> than bridges, so I doubt it would be correct to overwrite the class
> for *every* Freescale device as you're doing here.
>
>> +#endif
>> +
>>  static void fixup_ti816x_class(struct pci_dev *dev)
>>  {
>>         /* TI 816x devices do not have class code set when in PCIe boot mode */
>> --
>> 1.7.6.5
>>
>>
