Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:62175 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbcC1VS6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2016 17:18:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe controller
Date: Mon, 28 Mar 2016 23:18:02 +0200
Message-ID: <5192758.5yjNn0Uus9@wuerfel>
In-Reply-To: <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com> <1459071058-18328-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 27 March 2016 11:30:57 Thomas Petazzoni wrote:
> +               ranges = <0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000       /* downstream I/O */
> +                         0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;    /* non-prefetchable memory */
> 

No 64-bit (prefetchable) MMIO area? Is this a hardware limitation,
or did you just forget to add it?

	Arnd
