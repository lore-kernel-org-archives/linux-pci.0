Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59377 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754886AbaEGJS6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 05:18:58 -0400
Date: Wed, 7 May 2014 10:18:23 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140507091822.GA18456@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <12080862.flQZBvPba4@wuerfel>
 <20140506183811.GI13677@arm.com>
 <12021375.dFzSuv1Afb@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12021375.dFzSuv1Afb@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Tue, May 06, 2014 at 08:11:48PM +0100, Arnd Bergmann wrote:
> On Tuesday 06 May 2014 19:38:12 Will Deacon wrote:
> > Ok, I've respun the patch and included it below. It's turned probe() into a
> > bit of a beast, but the cleanup is a lot simpler (unless I'm missing
> > something).
> 
> Let's see if we can make it a bit more readable. None of these are important,
> but together they could improve readability.

Sure, I managed to incorporate most of your ideas, but ended up splitting
probe into two other functions; one for dealing with the ranges and the
other for dealing with config space. I'll send a v6 later on.

Cheers,

Will
