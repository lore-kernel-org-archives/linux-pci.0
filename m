Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37031 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750754AbcDNUSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 16:18:21 -0400
Date: Thu, 14 Apr 2016 22:18:18 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Yehuda Yitschak <yehuday@marvell.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Marvell
 Armada 7K/8K PCIe controller
Message-ID: <20160414221818.4726e6c4@free-electrons.com>
In-Reply-To: <20160414174046.GA25285@rob-hp-laptop>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1460648177-31473-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160414174046.GA25285@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 14 Apr 2016 12:40:46 -0500, Rob Herring wrote:

> I already acked the last version, did something change?

>From the cover letter:

"""
Changes since v1:

 - Change the DT binding to take only one clock, since in fact all
   PCIe lane clocks are child of the PCIe main clock, so there is no
   need for the PCIe controllers to take a reference to both.

[...]

Rob: due to the change to the DT binding (even though minimal), I have
not kept your Acked-by. So if it still stands despite the DT binding
change, could you send it again? Thanks!
"""

> Acked-by: Rob Herring <rob@kernel.org>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
