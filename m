Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57359 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab2HaTq2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2012 15:46:28 -0400
Date: Fri, 31 Aug 2012 13:46:27 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Paolo <paolopiace@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: BAR0/1 & enumeration
Message-ID: <20120831194626.GB21160@parisc-linux.org>
References: <loom.20120831T212633-656@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120831T212633-656@post.gmane.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2012 at 07:29:50PM +0000, Paolo wrote:
> As newbie to the pcie world, I'm seeking help for understanding this:
> 
> How does the bios during enumeration finds whether BAR0/1 is set for pointing to
> the config-space of its function or to memory space for memory transactions?

BARs point to either memory or I/O space (discriminated by the bottom
bit of the register).  They never point to config space (indeed, since
they are found in config space, that wouldn't make sense).

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
