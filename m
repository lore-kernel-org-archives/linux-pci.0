Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:56809 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaJPATV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 20:19:21 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 16 Oct 2014 10:19:19 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1560F2BB003F
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 11:19:18 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9FNshoB10289430
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 10:54:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9G0JHeO007516
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 11:19:17 +1100
Date: Thu, 16 Oct 2014 11:19:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Make reset warning messages different
Message-ID: <20141016001920.GA18777@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1413416470-14828-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo5iWEiM_0WeLJHfhus_LXo5ByUbDktWzBO1tVqwkko7Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5iWEiM_0WeLJHfhus_LXo5ByUbDktWzBO1tVqwkko7Sg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 15, 2014 at 05:48:35PM -0600, Bjorn Helgaas wrote:
>On Wed, Oct 15, 2014 at 5:41 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> We have same warning message for FLR and AF FLR and users can't
>> know which type of resets the PCI device is taking when there are
>> pending transactions. The patch makes them different for FLR and
>> AF FLR cases.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 625a4ac..2d708cd 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3144,7 +3144,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>>                 return 0;
>>
>>         if (!pci_wait_for_pending_transaction(dev))
>> -               dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
>> +               dev_err(&dev->dev, "Force FLR with pending transaction\n");
>>
>>         pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>>
>> @@ -3178,7 +3178,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>>                                  PCI_AF_STATUS_TP << 8))
>>                 goto clear;
>>
>> -       dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
>> +       dev_err(&dev->dev, "Force AF FLR with pending transaction\n");
>
>Making the text different is fine, but I don't think "FLR" and "AF
>FLR" are meaningful except to extremely technical people.  So I think
>"reset" needs to stay spelled out in the message.
>

Agree, it's worthy to keep "reset". How about something like this:

   "Force function level reset with pending transaction"         - FLR
   "Force AF function level reset with pending transaction"      - AF FLR

If above messages look good to you, I'll send out another revision.

Thanks,
Gavin

>>  clear:
>>         pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>> --
>> 1.8.3.2
>>
>

