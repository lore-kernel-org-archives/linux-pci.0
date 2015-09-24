Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53369 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbIXXpH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 19:45:07 -0400
Date: Fri, 25 Sep 2015 01:36:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] mvebu PCI fixes and cleanups
Message-ID: <20150924233650.GA24416@lunn.ch>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 06:17:07PM +0100, Russell King - ARM Linux wrote:
> This small series contains a number of fixes and cleanups to the
> mvebu PCI host code.

Hi Russell

I've tested this on my Kirkwood based DIR665, which has a Marvell
TopDog wifi card on PCIe. I can join my wifi network, so no obvious
regression.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

