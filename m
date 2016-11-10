Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve1eur01on0074.outbound.protection.outlook.com ([104.47.1.74]:41120
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754559AbcKJSdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 13:33:15 -0500
Subject: Re: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
To: Bjorn Helgaas <helgaas@kernel.org>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1478011644-12080-1-git-send-email-noaos@mellanox.com>
 <20161109182232.GL14322@bhelgaas-glaptop.roam.corp.google.com>
 <20161110034640.GA5341@gwshan>
 <20161110150059.GA10384@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Amir Vadai <amirv@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>, <amir@vadai.me>
From: Noa Osherovich <noaos@mellanox.com>
Message-ID: <02e361f0-c2d9-d7d5-9daf-e1b7adbbfd7f@mellanox.com>
Date: Thu, 10 Nov 2016 17:58:39 +0200
MIME-Version: 1.0
In-Reply-To: <20161110150059.GA10384@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/10/2016 5:00 PM, Bjorn Helgaas wrote:

> On Thu, Nov 10, 2016 at 02:46:40PM +1100, Gavin Shan wrote:
>> On Wed, Nov 09, 2016 at 12:22:32PM -0600, Bjorn Helgaas wrote:
>>> [+cc Gavin, Amir, Majd, Alex]
>>>
>>> Hi Noa,
>>>
>>> On Tue, Nov 01, 2016 at 04:47:24PM +0200, Noa Osherovich wrote:
>>>> Mellanox devices were marked as having INTx masking ability broken.
>>> This was done by 11e42532ada3 ("PCI: Assume all Mellanox devices have
>>> broken INTx masking"), by Gavin Shan.  Possibly that was a little too
>>> aggressive.  I cc'd Gavin and Amir so they can comment.
>>>
>> I cannot know more HW details than Mellanox guys. So I assume the logic
>> in the code changes are correct. I totally agree with Bjron suggested
>> except one minor point: There will have two quirks for HEADER and FINAL
>> fixup separately as Bjorn suggested. One entry for one combination of
>> vendor/device will be put into section .pci_fixup_{header | final}.
>> The vendor/device IDs in the entries are compared with every PCI deivce
>> and the callbacks are invoked if they match. When number of entries in
>> section .pci_fixup_{header | final} increases, more time used to iterate
>> the section in pci_do_fixups(). The time will be saved if we can just
>> have one FINAL quirk as below, which probably makes code the easier to
>> be maintained.
>>
>> static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
>> {
>> 	if (pdev->device in broken_device_list)
>> 		quirk_broken_intx_masking(pdev);
>>         else if (pdev->dev is CONNECT4)
>>                 /* Check the firmware version to call quirk_broken_intx_masking() */
>> }
>>
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_MELLANOX, PCI_ANY_ID, PCI_ANY_ID,
>> 			mellanox_check_broken_intx_masking);
>>
>> Above comment bases on the fact: pdev->broken_intx_masking is used by
>> device driver only. We still need anohter one HEADER quirk for Mellanox
>> (not one for vendor/device ID combination) if we want to see finalized
>> pdev->broken_intx_masking before that point.
> So you're proposing to make the quirk applicable to *all* Mellanox
> devices, then check against a list inside the quirk.  You still have
> to maintain a table of the broken devices.  I'm OK with that, and if
> you do it that way, it probably does make sense to combine them as you
> suggest.
>
> I agree that it would be simpler if these were all FINAL quirks.  I
> don't think *any* of the quirk_broken_intx_masking() quirks need to be
> HEADER quirks.  All of them could be FINAL quirks instead.
>
> I do *not* want a mix of HEADER & FINAL quirks that set
> broken_intx_masking.  If we have a mix, it's not clear when it's
> really needed and it's not clear how to decide which to use.
>
> Now we're up to three patches:
>
>   1) Convert all quirk_broken_intx_masking() quirks (not just the
>      Mellanox ones) from HEADER to FINAL.
>
>   2) Convert the Mellanox quirks from "all Mellanox devices" to the
>      listed ones only, something like this:
>
>       static u16 mellanox_broken_intx[] = { ... };
>
>       static void mellanox_broken_intx_quirk(struct pci_dev *dev)
>       {
> 	int i;
>
> 	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx); i++) {
> 	  if (dev->device == mellanox_broken_intx[i]) {
> 	    dev->broken_intx_masking = 1;
> 	    return;
> 	  }
> 	}
>       }
>       DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_MELLANOX, PCI_ANY_ID, PCI_ANY_ID,
>         mellanox_broken_intx_quirk);
>
>   3) Add the CONNECT4-specific firmware version checks to
>      mellanox_broken_intx_quirk().

Ack.

>>>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>>> index c58752fe16c4..1c742842e76c 100644
>>>> --- a/include/linux/pci_ids.h
>>>> +++ b/include/linux/pci_ids.h
>>>> @@ -2262,6 +2262,22 @@
>>>>  #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
>>>>  #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
>>>>  #define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR 0x6340
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR 0x634a
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR 0x6354
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2 0x6732
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2 0x673c
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN 0x6368
>>>> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2 0x6750
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN 0x6372
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2 0x6764
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX2 0x676e
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3 0x1003
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO 0x1007
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX4 0x1013
>>>> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX 0x1015
> I forgot to mention: we normally don't add definitions to pci_ids.h
> unless they're used in more than one place (there's a comment about
> this at the top of pci_ids.h).  So these device IDs should all just be
> listed directly in the quirks or in the static table of broken
> devices.

Ack again. I'll send the patches early next week.

> Bjorn

