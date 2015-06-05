Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38356 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbFETig (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 15:38:36 -0400
Received: by igblz2 with SMTP id lz2so22058510igb.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 12:38:35 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:38:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: keep resource size during alignment reordering
Message-ID: <20150605193831.GB20943@google.com>
References: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 10:40:00PM -0700, Yinghai Lu wrote:
> In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
> and assigning"), it stores additional alignment in realloc_head and takes
> this into consideration for assignment.
> During update the resource before reordering, it does not calculate
> resource end correctly.
> 
> We need to keep the original resource size before updating start.
> otherwise we will smaller size during updating end.
> 
> Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I applied this with the following changelog, included here so search
engines can find the original thread:


PCI: Preserve resource size during alignment reordering

In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
and assigning"), we store additional alignment in realloc_head and take
this into consideration for assignment.

In __assign_resources_sorted(), we changed dev_res->res->start, then used
resource_start() (which depends on res->start), so the recomputed res->end
was completely bogus.  Even if we'd had the correct size, the end would
have been off by one.

Preserve the resource size when we adjust its alignment.

[bhelgaas: changelog]
Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Wei Yang <weiyang@linux.vnet.ibm.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
