Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35155 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbaACA1F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jan 2014 19:27:05 -0500
Date: Thu, 2 Jan 2014 17:26:56 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Cl??ment <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Issue with the emulated PCI bridge implementation
Message-ID: <20140103002656.GA12098@obsidianresearch.com>
References: <20131226160534.36cc4203@skate>
 <20131226165241.2c50b244@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131226165241.2c50b244@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 26, 2013 at 04:52:41PM +0100, Thomas Petazzoni wrote:

> Here is an implementation of this idea, tested to work with an e1000e
> card, with the driver modified to do a few read/write to the I/O
> region. What do you think about it?

This seems reasonable, the only down side is that a stray read to an
unused portion of the Linux IO mapping will lock the machine instead
of getting a page fault - however I don't see that as a blocker.

Regards,
Jason
