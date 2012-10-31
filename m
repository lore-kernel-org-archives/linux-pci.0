Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51126 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab2JaWUP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 18:20:15 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so874250bkc.19
        for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 15:20:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5091A16B.7090303@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
	<1351718353-6124-3-git-send-email-ddutile@redhat.com>
	<CAE9FiQXQ6cODjkdgKC0XQUnat5_8uz=4gJr2qp5wS2J+=ur5EA@mail.gmail.com>
	<5091A16B.7090303@redhat.com>
Date: Wed, 31 Oct 2012 15:20:12 -0700
Message-ID: <CAE9FiQWQSSpSvbgbHs0Dw3DkNVEL3KOcfN-vRQPY5E7KCrqPzg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI,sys: Use is_visible() with boot_vga attribute for pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>
Cc: linux-pci@vger.kernel.org, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 31, 2012 at 3:08 PM, Don Dutile <ddutile@redhat.com> wrote:
> On 10/31/2012 05:53 PM, Yinghai Lu wrote:
>>
>> On Wed, Oct 31, 2012 at 2:19 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>>>
>>> From: Don Dutile<ddutile@dddsys1.bos.redhat.com>
>>
>>
>> should be
>> From:  Yinghai Lu<yinghai@kernel.org>
>>
> sorry. Tried to credit you for 1st two patches.
>
>
>>>
>>> Should make pci_creae_sysfs_dev_files simpler.
>>> Also fix possible memleak in remove path.
>>>
>>> Authored-by: Yinghai Lu<yinghai@kernel.org>
>>
>>
>> should be:
>> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
>>
> I didn't want to sign off for you b/c I reworded
> the log.  I was trying to credit you for the patch
> by stating you Authored it.  My apologies if that was
> incorrect.
>
>

if you change log, you still can keep my old Signed-off and add
[ changelog updated.... Donald]
>>> Signed-off-by: Donald Dutile<ddutile@redhat.com>

>>
>>
>> patch 1 and 2 got acked-by from Greg KH
>>
>> https://patchwork.kernel.org/patch/1542941/
>
> Yes, but didn't see it in Linus' git tree.
> Should I have used one of Bjorn's tree/branch with
> this patch in it as master of these patches ?

if bjorn could give Acked-by, those pci change patches go together
with ixgbe changes via Dave's Net-next tree.

or bjorn add one branch in pci next tree to have the first 4 patches,
and let Dave to pull it and use as base for ixgbe change.

or just first 4 patches go into 3.7 directly...
