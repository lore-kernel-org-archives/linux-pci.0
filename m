Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43372 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752049Ab3KYIM3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 03:12:29 -0500
Date: Mon, 25 Nov 2013 09:12:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <20131125091218.48bad3be@skate>
In-Reply-To: <20131125055222.GA28064@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
	<20131124025808.GQ29241@titan.lakedaemon.net>
	<20131125055222.GA28064@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Sun, 24 Nov 2013 22:52:22 -0700, Jason Gunthorpe wrote:

> > I'd like to get back on track with these small patches being Acked by
> > mvebu maintainers and then going through Bjorn.  Could you please resend
> > an updated patchset for this and 2/2?
> 
> I recall these two patches are waiting for Thomas to give his Ok. His
> testing found problems with the prior versions that I cannot detect on
> my hardware..

Correct. Sorry for the delay, I'll try to test them today. Thanks for
the reminder!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
