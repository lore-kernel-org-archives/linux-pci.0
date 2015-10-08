Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41794 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932532AbbJHXTo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 19:19:44 -0400
Date: Fri, 9 Oct 2015 01:19:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/9] Further mvebu PCIe patches
Message-ID: <20151008231936.GA14688@lunn.ch>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 03, 2015 at 07:12:28PM +0100, Russell King - ARM Linux wrote:
> Jason, Thomas,
> 
> Here are further PCIe patches which follow on from the previous set of
> six I sent earlier in September.  This set:

Hi Russell

Tested on my Kirkwood based DLINK DIR665 with a topdog wireless lan
card. This does not make use of the GPIO reset, so those parts of the
patch are untested. But otherwise, no obvious regressions, i can join
the wireless LAN etc.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	   Andrew
