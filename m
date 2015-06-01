Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:45329 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbbFAC0t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 May 2015 22:26:49 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 1 Jun 2015 12:26:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4E7723578053
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2015 12:26:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t512QY4A56164538
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2015 12:26:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t512QANt016214
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2015 12:26:11 +1000
Date: Mon, 1 Jun 2015 10:25:53 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: keep resource size during alignment reordering
Message-ID: <20150601022553.GA5855@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 10:40:00PM -0700, Yinghai Lu wrote:
>In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
>and assigning"), it stores additional alignment in realloc_head and takes
>this into consideration for assignment.
>During update the resource before reordering, it does not calculate
>resource end correctly.
>
>We need to keep the original resource size before updating start.
>otherwise we will smaller size during updating end.
>
>Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
>Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Wei Yang <weiyang@linux.vnet.ibm.com>


Thanks Yinghai,

I have tested this on Power8, your code is correct. :-)

>
>---
> drivers/pci/setup-bus.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>Index: linux-2.6/drivers/pci/setup-bus.c
>===================================================================
>--- linux-2.6.orig/drivers/pci/setup-bus.c
>+++ linux-2.6/drivers/pci/setup-bus.c
>@@ -428,9 +428,10 @@ static void __assign_resources_sorted(st
> 		 * consistent.
> 		 */
> 		if (add_align > dev_res->res->start) {
>+			resource_size_t r_size = resource_size(dev_res->res);
>+
> 			dev_res->res->start = add_align;
>-			dev_res->res->end = add_align +
>-				            resource_size(dev_res->res);
>+			dev_res->res->end = add_align + r_size - 1;
>
> 			list_for_each_entry(dev_res2, head, list) {
> 				align = pci_resource_alignment(dev_res2->dev,

-- 
Richard Yang
Help you, Help me

