Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42334 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbcGOWQ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 18:16:58 -0400
Date: Fri, 15 Jul 2016 17:16:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH v3 0/3] pci: Aardvark PCIe controller driver for Marvell
 Armada 3700
Message-ID: <20160715221655.GD1706@localhost>
References: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160707224403.3279d807@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707224403.3279d807@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 07, 2016 at 10:44:03PM +0200, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> On Thu, 30 Jun 2016 11:32:29 +0200, Thomas Petazzoni wrote:
> 
> > This is the third iteration of the patch series that adds a PCIe
> > controller driver for the Aardvark PCI controller, which is used on
> > Marvell Armada 3700.
> 
> Have you had the chance to look into this third iteration, which
> hopefully integrates the feedback you made during your review of the
> second version?
> 
> I was hoping to get this in time for 4.8, so if you have any comments,
> do not hesitate to let me know so that I can address them.

Hi Thomas, I just returned from vacation, so I haven't looked at this
yet.  Sounds like we'll have a bonus week before v4.7 and I was
planning to do two pull requests anyway because of my vacation, so
there should still be time.

Bjorn
