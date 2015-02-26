Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36025 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbbBZM2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Feb 2015 07:28:34 -0500
Date: Thu, 26 Feb 2015 13:27:30 +0100
From: Borislav Petkov <bp@suse.de>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Avoid info leak in __print_tlp_header
Message-ID: <20150226122730.GC3573@pd.tnic>
References: <20150225225859.GB19236@pd.tnic>
 <1424940903-9147-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1424940903-9147-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 09:55:03AM +0100, Rasmus Villemoes wrote:
> Commit fab4c256a58b ("PCI/AER: Add a TLP header print helper")
> introduced the helper function __print_tlp_header, but contrary to the
> intention, the behaviour did change: Since we're taking the address of
> the parameter t, the first 4 or 8 bytes printed will be the value of
> the pointer t itself, and the remaining 12 or 8 bytes will be
> who-knows-what (something from the stack).
> 
> We want to show the values of the four members of the struct
> aer_header_log_regs; that can be done without ugly and error-prone
> casts. On little-endian this should produce the same output as
> originally intended, and since no-one has complained about getting
> garbage output so far, I think big-endian should be ok too.
> 
> Fixes: fab4c256a58b ("PCI/AER: Add a TLP header print helper")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Cc: <stable@vger.kernel.org>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
