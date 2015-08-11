Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:32991 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbbHKAlB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 20:41:01 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 11 Aug 2015 10:40:59 +1000
Date: Tue, 11 Aug 2015 10:40:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com
Subject: Re: [PATCH v6 17/42] powerpc/powernv: Rename PE# fields in PHB
Message-ID: <20150811004005.GB18981@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-18-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C8B35C.4040501@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C8B35C.4040501@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 12:21:16AM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>This renames the fields related to PE# in "struct pnv_phb" for
>>better reflecting of their usages as Alexey suggested. It doesn't
>>introduce behavioural changes.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>Makes sense to move this to the beginning of the patchset as patches prior
>this are changing the same lines as this patch changes.
>

Ok. I'll try to reorder the patch...

Thanks,
Gavin


