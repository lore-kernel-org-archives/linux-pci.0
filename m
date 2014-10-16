Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:64905 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaJPDnx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 23:43:53 -0400
Received: by mail-qg0-f53.google.com with SMTP id q107so1989806qgd.12
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2014 20:43:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141016001920.GA18777@shangw>
References: <1413416470-14828-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo5iWEiM_0WeLJHfhus_LXo5ByUbDktWzBO1tVqwkko7Sg@mail.gmail.com> <20141016001920.GA18777@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Oct 2014 21:43:32 -0600
Message-ID: <CAErSpo44eZJitWqLnY2wopLPT7BiDFcFAKuh8K-m8X30-VMNdQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Make reset warning messages different
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 15, 2014 at 6:19 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Wed, Oct 15, 2014 at 05:48:35PM -0600, Bjorn Helgaas wrote:
>>On Wed, Oct 15, 2014 at 5:41 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> We have same warning message for FLR and AF FLR and users can't
>>> know which type of resets the PCI device is taking when there are
>>> pending transactions. The patch makes them different for FLR and
>>> AF FLR cases.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  drivers/pci/pci.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 625a4ac..2d708cd 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3144,7 +3144,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>>>                 return 0;
>>>
>>>         if (!pci_wait_for_pending_transaction(dev))
>>> -               dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
>>> +               dev_err(&dev->dev, "Force FLR with pending transaction\n");
>>>
>>>         pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>>>
>>> @@ -3178,7 +3178,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>>>                                  PCI_AF_STATUS_TP << 8))
>>>                 goto clear;
>>>
>>> -       dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
>>> +       dev_err(&dev->dev, "Force AF FLR with pending transaction\n");
>>
>>Making the text different is fine, but I don't think "FLR" and "AF
>>FLR" are meaningful except to extremely technical people.  So I think
>>"reset" needs to stay spelled out in the message.
>>
>
> Agree, it's worthy to keep "reset". How about something like this:
>
>    "Force function level reset with pending transaction"         - FLR
>    "Force AF function level reset with pending transaction"      - AF FLR
>
> If above messages look good to you, I'll send out another revision.

How about something like "timed out waiting for pending transaction;
performing function level reset"?

"Force reset with pending transaction" sounds like a pending
transaction might be the mechanism we're using to perform the reset.

Out of curiosity, is there some issue you tripped over where it's
important for users to know this difference?

Just FYI, I'll be on vacation the rest of this week.

Bjorn
