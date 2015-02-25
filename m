Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbbBYXAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Feb 2015 18:00:04 -0500
Date: Wed, 25 Feb 2015 23:59:00 +0100
From: Borislav Petkov <bp@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] PCI/AER: Avoid info leak in __print_tlp_header
Message-ID: <20150225225859.GB19236@pd.tnic>
References: <1424818246-11841-1-git-send-email-linux@rasmusvillemoes.dk>
 <20150225185423.GA19236@pd.tnic>
 <CAErSpo5WwP1z+rzXzEM8_bJ2sq7rixOWiF5CqYYSK32r0sVYuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAErSpo5WwP1z+rzXzEM8_bJ2sq7rixOWiF5CqYYSK32r0sVYuw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 12:18:14PM -0800, Bjorn Helgaas wrote:
> Why are we worrying about byte order here at all?  I'd think we could
> just print t->dw0 directly with %08x.

Right, my only concern is since this is user-facing, someone/something
might depend on its format/byte order. But since no one has complained
about the bug so far, we might just as well do the simple thing and just
print t->dwX.

Btw, Bjorn, when applying the final version, please add the stable tag
too.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
