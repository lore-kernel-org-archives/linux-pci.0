Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37952 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbbK3BA3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Nov 2015 20:00:29 -0500
Date: Sun, 29 Nov 2015 19:00:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
	arcml <linux-snps-arc@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] PCI support added to ARC
Message-ID: <20151130010026.GA17982@localhost>
References: <cover.1448375184.git.jpinto@synopsys.com>
 <9b80d6c1db4d7e2b5ee5dc0056a3d8284e7c2b9b.1448375184.git.jpinto@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44D3B42@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44D3B42@IN01WEMBXA.internal.synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 25, 2015 at 05:25:37AM +0000, Vineet Gupta wrote:
> On Tuesday 24 November 2015 08:02 PM, Joao Pinto wrote:

> > +++ b/arch/arc/include/asm/mach/pci.h
> > @@ -0,0 +1,97 @@
> > +/*
> > + *  arch/arc/include/asm/mach/pci.h
> > + *
> > + *  Copyright (C) 2004-2014 Synopsys, Inc. (www.synopsys.com)
> 
> Perhaps extend this to 2016 (and other copyrights in the patch too if needed)

What is the reasoning behind claiming a copyright date in the future?
That doesn't sound right to me.

Bjorn
