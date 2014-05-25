Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:57092 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbaEYKo4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 May 2014 06:44:56 -0400
Date: Sun, 25 May 2014 11:43:59 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
	"sthokal@xilinx.com" <sthokal@xilinx.com>
Subject: Re: [PATCH v7 0/4] Support for Generic PCI Host Controller
Message-ID: <20140525104359.GA2343@arm.com>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
 <201405232119.23891.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405232119.23891.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Fri, May 23, 2014 at 08:19:23PM +0100, Arnd Bergmann wrote:
> On Friday 23 May 2014, Will Deacon wrote:
> >   - Removed redundant MIGHT_HAVE_PCI selections from multiplatform-enabled
> >     SoCs
> > 
> >   - Included patch from Srikanth for generic Configuration Space access to
> >     be factored out and used by other drivers
> > 
> >   - Fixed minor issue in I/O port allocation (I had a >= instead of a >)
> > 
> 
> It seems strange that you include the patch from Srikanth but then use
> a separate copy of the same code in patch 2. Is that intentional?

That was a combination of me not being sure about the status of Srikanth's
patch (the review didn't seem to conclude) but also then forgetting to move
over to using it.

However, judging by your most recent comments, I'm glad I didn't spend any
time on it!

Will
