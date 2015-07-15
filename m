Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:38120 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbGOFrr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 01:47:47 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 15 Jul 2015 15:47:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id B7FCC357804F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 15:47:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F5lXWT38273258
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 15:47:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F5l9Qw027894
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 15:47:09 +1000
Date: Wed, 15 Jul 2015 13:46:51 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 4/4] PCI: consolidate return value check for
 pci_find_(ext_)capability
Message-ID: <20150715054651.GA24137@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1435627004-6029-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150714220021.GL24416@google.com>
 <20150715020206.GC6525@richard>
 <CAErSpo4o4z+OHdoLjhzEY4QwTN4dZkbjw5ot4sdUmOx8bFxyjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4o4z+OHdoLjhzEY4QwTN4dZkbjw5ot4sdUmOx8bFxyjA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 09:11:54PM -0500, Bjorn Helgaas wrote:
>On Tue, Jul 14, 2015 at 9:02 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, Jul 14, 2015 at 05:00:21PM -0500, Bjorn Helgaas wrote:
>>>On Tue, Jun 30, 2015 at 09:16:44AM +0800, Wei Yang wrote:
>>>> The return value of the pci_find_(ext_)capability is the position of this
>>>> Cap.  After previous two patches clean up, the position returned is an
>>>> unsigned value. Only 0 indicates the Cap is not presented.
>>>>
>>>> This patch consolidates the form of check from (pos <= 0)to (!pos).
>>>>
>>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>
>>>Applied to pci/misc with changelog as below.
>>>
>>>It seems pretty clear to me that pci_find_capability() returns either 0 or
>>>a u8 value.  pci_find_ext_capability() does return an int.  It looks to me
>>>like it can never be negative, but if you wanted it to be even more clear,
>>>you could easily change just pci_find_next_ext_capability() to use a u16
>>>for "pos".  That would be very simple and wouldn't change any interfaces.
>>
>> pci_find_capability() will return either 0 or a u8 value, while in the code
>> the return value is an "int" type. So for the first sight, it may not that
>> immediate. The same as pci_find_ext_capability().
>>
>> This is the reason for patch 2/3. The purpose is to make the return type
>> reflect the value it will return.
>>
>> Patch 3 does exactly what you said, use a u16 for "pos" in
>> pci_find_next_ext_capability().
>
>Yes.  Patch 3 contains this hunk:
>
>@@ -272,11 +272,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
>  * not support it.  Some capabilities can occur several times, e.g., the
>  * vendor-specific capability, and this provides a way to find them all.
>  */
>-int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
>+u16 pci_find_next_ext_capability(struct pci_dev *dev, int start, u16 cap)
> {
>        u32 header;
>        int ttl;
>-       int pos = PCI_CFG_SPACE_SIZE;
>+       u16 pos = PCI_CFG_SPACE_SIZE;
>
>        /* minimum 8 bytes per capability */
>        ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>
>I think the second piece (changing "pos" from int to u16) is enough to
>make it easy to analyze, and it only affects this function, so that
>seems obviously fine.
>
>The first piece (changing the return type) changes the signature of an
>exported interface.  That is more work, e.g., it's more of a hassle
>for distros to backport if they want to preserve interfaces, so it's
>not quite as obvious that it's worthwhile.

OK, I got your concern.

>
>Bjorn
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

