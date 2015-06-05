Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35812 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbFETgx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 15:36:53 -0400
Received: by iesa3 with SMTP id a3so64794664ies.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 12:36:52 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:36:48 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: break when finding the first smaller resource
Message-ID: <20150605193648.GA20943@google.com>
References: <1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 02:24:17PM +0800, Wei Yang wrote:
> In commit d74b9027a4da(PCI: Consider additional PF's IOV BAR alignment in
> sizing and assigning), it stores additional alignment in realloc_head and
> take this into consideration for assignment.
> 
> After getting the additional alignment, it will re-order the head list to
> make sure resources with bigger alignment is ahead of the resources with
> smaller assignment in the head list. To make it happen, it iterate on the
> head list and find a smaller alignment resource and insert ahead of it.
> This should be done for the first occurrence, while the code now will
> iterate on the whole list.
> 
> This patch fixes this behavior by break when finding the first smaller
> resource in the head list.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

I applied this with the following changelog, included here so search
engines can find the original thread:


PCI: Fix IOV resource sorting by alignment requirement

In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
and assigning"), it stores additional alignment in realloc_head and takes
this into consideration for assignment.

After getting the additional alignment, it reorders the head list so
resources with bigger alignment are ahead of resources with smaller
alignment.  It does this by iterating over the head list and inserting
ahead of any resource with smaller alignment.  This should be done for the
first occurrence, but the code currently iterates over the whole list.

Fix this by terminating the loop when we find the first smaller resource in
the head list.

[bhelgaas: changelog]
Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
