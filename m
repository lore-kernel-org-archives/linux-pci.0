Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:51990 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbaLIBJK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 20:09:10 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 9 Dec 2014 11:09:08 +1000
Date: Tue, 9 Dec 2014 12:08:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Alexey Voronkov <zermond@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Clear bridge MEM_64 flag if one child does not
 support it
Message-ID: <20141209010803.GA30604@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1418075552-26495-1-git-send-email-yinghai@kernel.org>
 <1418079372.13358.9.camel@kernel.crashing.org>
 <CAE9FiQX-vMu5+Kr09ngr95WvtoZTUSL5R2+NiVFeiN6q-BXLLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQX-vMu5+Kr09ngr95WvtoZTUSL5R2+NiVFeiN6q-BXLLg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 08, 2014 at 03:59:54PM -0800, Yinghai Lu wrote:
>On Mon, Dec 8, 2014 at 2:56 PM, Benjamin Herrenschmidt
><benh@kernel.crashing.org> wrote:
>> On Mon, 2014-12-08 at 13:52 -0800, Yinghai Lu wrote:
>>> 2. or scan the children resource other than ROM to clear bridge MEM_64
>>>    for mmio pref.
>>>
>>> The patch is using second way so will keep child mmio pref into bridge
>>> mmio pref range.
>>
>> That means that having a single ROM BAR that is 32-bit and prefetchable
>> will downgrade the entire window to 32-bit ? That's not going to work
>> either.
>
>the ROM BAR get skipped during the checking.
>
>+                       if (i != PCI_ROM_RESOURCE)
>+                               mem64_mask &= r->flags & IORESOURCE_MEM_64;
>+               }
>
>>
>> I have GPUs with 16G BARs for example... suddenly they don't fit
>> anaymore because we downgraded the window to 32 bit because somewhere
>> there's a 32-bit pref resource ?
>>
>> That will break more than it fixes...
>
>Please check if this patch break your platform. I tried on my setup on
>x86. and it is still
>working on 64 bit resource allocation.
>

Yinghai, With the patch, the Power8 machine boots up and have resources
assigned properly: 64-bits pref BARs are covered by 64-bits pref windows
and left memory BARs are covered by 32-bits non-pref windows. Note that
I didn't find an 32-bits-pref BAR on the system.

For SRIOV case, Richard still need test.

Thanks,
Gavin

>Thanks
>
>Yinghai
>

