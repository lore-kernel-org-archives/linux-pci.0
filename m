Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59596 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbaHFJ7q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 05:59:46 -0400
Date: Wed, 6 Aug 2014 11:59:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: bhelgaas@google.com, rdunlap@infradead.org, tony.luck@intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] RAS, trace: Update error definition format
Message-ID: <20140806095939.GB27033@pd.tnic>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
 <20140806093223.GA27033@pd.tnic>
 <20140806090853.GA21650@gchen.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140806090853.GA21650@gchen.bj.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 06, 2014 at 05:08:54AM -0400, Chen, Gong wrote:
> Bjorn ever mentioned for this:
> "I'd like to see all those "BIT(...)" things changed to use the #defines
> that already exist in include/uapi/linux/pci_regs.h, e.g.,
> PCI_ERR_COR_RCVR.  That way grep will find these uses, which will make
> maintenance easier."

So explain that in the commit message but don't use some bits out of
context.

In general, when you read your own commit message, always ask yourself
whether other people will be able to understand it, long time from now
and out of context.

If yes, only then send out the patch.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
