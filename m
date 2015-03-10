Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44684 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbCJEpG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 00:45:06 -0400
Date: Tue, 10 Mar 2015 05:45:01 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86:pci: Change  sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
Message-ID: <20150310044500.GA9015@gmail.com>
References: <1425959625-14551-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425959625-14551-1-git-send-email-xerofoify@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Nicholas Krause <xerofoify@gmail.com> wrote:

> This changes the structure sta2x11_dma_ops stucture to use switolb_dma_supported as it's 
> function for dma_supported hardware verus setting this value to NULL as this should be set 
> correctly for when dma_supported function needs to be called for hardware needing this 
> function to be supported. Otherwise hardware needing this function to be supported will 
> either cause a kernel panic or oops due to a NULL pointer being dereferenced in the 
> structure, sta1x11_dma_ops for the dma_supported function. Further more in  order to 
> prevent a kernel panic or oops here due to a NULL pointer being deferred here we add the 
> function, swiotlb_dma_supported as the dma_supported function for the structure,
> sta2x11_dma_ops.

Pleasedontresendtotallyunstructuredandunreadablechangelogs.

You also (still) don't explain where and how this supposed crash might 
happen in practice. Please don't resend unless you've addressed those 
deficiencies.

I.e. I'm not convinced you know what you are modifying there and what 
effects your modifications will have.

Thanks,

	Ingo
