Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab2JaWIw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 18:08:52 -0400
Message-ID: <5091A16B.7090303@redhat.com>
Date: Wed, 31 Oct 2012 18:08:43 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Subject: Re: [PATCH 2/4] PCI,sys: Use is_visible() with boot_vga attribute
 for pci_dev
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com> <1351718353-6124-3-git-send-email-ddutile@redhat.com> <CAE9FiQXQ6cODjkdgKC0XQUnat5_8uz=4gJr2qp5wS2J+=ur5EA@mail.gmail.com>
In-Reply-To: <CAE9FiQXQ6cODjkdgKC0XQUnat5_8uz=4gJr2qp5wS2J+=ur5EA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 05:53 PM, Yinghai Lu wrote:
> On Wed, Oct 31, 2012 at 2:19 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>> From: Don Dutile<ddutile@dddsys1.bos.redhat.com>
>
> should be
> From:  Yinghai Lu<yinghai@kernel.org>
>
sorry. Tried to credit you for 1st two patches.

>>
>> Should make pci_creae_sysfs_dev_files simpler.
>> Also fix possible memleak in remove path.
>>
>> Authored-by: Yinghai Lu<yinghai@kernel.org>
>
> should be:
> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
>
I didn't want to sign off for you b/c I reworded
the log.  I was trying to credit you for the patch
by stating you Authored it.  My apologies if that was
incorrect.

>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>
> patch 1 and 2 got acked-by from Greg KH
>
> https://patchwork.kernel.org/patch/1542941/
Yes, but didn't see it in Linus' git tree.
Should I have used one of Bjorn's tree/branch with
this patch in it as master of these patches ?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

