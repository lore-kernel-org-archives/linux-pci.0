Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49319 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779Ab3JaIyw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2013 04:54:52 -0400
Date: Thu, 31 Oct 2013 09:54:46 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu - The bridge secondary status register
 should be 0
Message-ID: <20131031095446.3c95fbb5@skate>
In-Reply-To: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 15 Oct 2013 14:16:30 -0600, Jason Gunthorpe wrote:
> There are no writable bits in the secondary status register, only
> write 1 to clear bits. The driver never sets any of the write 1 to
> clear bits so the status register should always be 0, just remove
> the set from the write path.
> 
> Someday the write 1 to clear bits should be copied/cleared directly
> from registers in the HW.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
