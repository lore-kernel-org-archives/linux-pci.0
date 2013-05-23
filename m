Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:34322 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab3EWAOh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 May 2013 20:14:37 -0400
Date: Thu, 23 May 2013 02:13:53 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130523001353.GH31625@1wt.eu>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> Bjorn, Jason, Andrew, Gregory,
> 
> You'll find in this patch series 4 small patches that make various
> improvements to the Marvell PCIe driver.
(...)

FWIW, these patches applied on top of your pcie-v10 tree have made
my mini-pcie dual-nic appear for the first time on the mirabox. Till
now I never knew if it was a hardware or software issue since the NIC
does not appear in u-boot nor lspci, whatever the kernel versions,
including the original Marvell one's. The NIC has two functions (one
per controller) and no bridge, so it may be a side effect of your
improvements (or maybe you fixed a bug).

Anyway for me it's a great improvement !

I've not tried it on the OpenBlocks AX3 yet (it was not detected
there previously). But I have good hopes.

For reference, the NIC is Jetway's ADMPEIDLA (intel i350-AM2).

Best regards,
Willy

