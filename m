Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21598 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbbHUU1a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Aug 2015 16:27:30 -0400
Date: Fri, 21 Aug 2015 13:27:08 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64
 systems
Message-ID: <20150821202707.GA920@agluck-desk.sc.intel.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
 <1415089784-28779-4-git-send-email-daniel@numascale.com>
 <20150821181910.GA31378@agluck-desk.sc.intel.com>
 <CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 11:38:13AM -0700, Yinghai Lu wrote:
> That commit could be reverted.
> According to
> https://lkml.org/lkml/2014/11/10/123

Do we really need to force the MIN_MEMORY_BLOCK_SIZE on small
systems?

What about this patch - which just uses max_pfn to choose
the block size.

It seems that many systems with large amounts of memory
will have a nicely aligned max_pfn ... so they will get
the 2GB block size.  If they don't have a well aligned
max_pfn, then they need to use a smaller size to avoid
the crash I saw.

-Tony


diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3fba623e3ba5..e14e90fd1cf8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1195,15 +1195,6 @@ static unsigned long probe_memory_block_size(void)
 	/* start from 2g */
 	unsigned long bz = 1UL<<31;
 
-	if (totalram_pages >= (64ULL << (30 - PAGE_SHIFT))) {
-		pr_info("Using 2GB memory block size for large-memory system\n");
-		return 2UL * 1024 * 1024 * 1024;
-	}
-
-	/* less than 64g installed */
-	if ((max_pfn << PAGE_SHIFT) < (16UL << 32))
-		return MIN_MEMORY_BLOCK_SIZE;
-
 	/* get the tail size */
 	while (bz > MIN_MEMORY_BLOCK_SIZE) {
 		if (!((max_pfn << PAGE_SHIFT) & (bz - 1)))
