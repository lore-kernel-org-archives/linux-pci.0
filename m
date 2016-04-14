Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:51390 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbcDNBcI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 21:32:08 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 14 Apr 2016 11:32:05 +1000
Date: Thu, 14 Apr 2016 11:30:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	devicetree@vger.kernel.org, grant.likely@linaro.org,
	robherring2@gmail.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, dja@axtens.net
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
Message-ID: <20160414013052.GA23214@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0E13.6080409@ozlabs.ru>
 <20160413234246.GA5330@gwshan>
 <8771729.bnzLL9sLJY@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8771729.bnzLL9sLJY@new-mexico>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 09:57:32AM +1000, Alistair Popple wrote:
>Hi Gavin,
>
><snip>
>
>> >Why exactly cannot EEH reset changes go to a smaller separate patchset
>> >(before hotplug)?
>> >
>> 
>> As I explained before, the patchset's order is: PCI generic part,
>> PowerNV PCI related, EEH related, device-tree part and hotplug driver.
>> 
>> The EEH reset change is included in PATCH[37/45]. There is no point
>> to reorder the patches.
>
>I don't understand all of the dependencies but if possible splitting the 
>series up into a set of smaller self-contained patch series makes things 
>easier to review and may make it easier for you to get this functionality 
>reviewed and accepted into upstream.
>

Thanks, Alistair. I will move those cleanup/refactor related patches
to form a separate series which is expected to be merged first. That
will helps the reviewers to focus on the patches with complicated
changes as you suggested. Alexey, please let me know if that way is
you like to see or not.

Thanks,
Gavin

>Regards,
>
>Alistair
>

