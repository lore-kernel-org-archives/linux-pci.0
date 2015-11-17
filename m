Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:44179 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbbKQBOu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2015 20:14:50 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 17 Nov 2015 11:14:48 +1000
Date: Tue, 17 Nov 2015 12:04:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
Message-ID: <20151117010446.GA26294@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D77.2060101@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D77.2060101@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 16, 2015 at 07:01:59PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>As we track M32 segment consumption, this introduces an array to
>>the PHB to track the mapping between M64 segment and PE number.
>>The information is going to be used to find M64 segment from the
>>PE number during PCI unplugging time in subsequent patches.
>
>
>It would not hurt to put a few words about how we managed to live without
>such a mapping for M64 before but we needed mapping for M32.
>

The M32 mapping (phb->ioda.m32_segmap[]) isn't used for anything before
this patcheset. There're no need for M64 mapping before this patchset
similarly, no need to add the words.

Thanks,
Gavin

