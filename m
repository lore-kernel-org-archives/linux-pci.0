Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33251 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754575AbcDYNqQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2016 09:46:16 -0400
Date: Mon, 25 Apr 2016 15:46:11 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160425154611.3e7e9dc9@free-electrons.com>
In-Reply-To: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 14 Apr 2016 17:36:15 +0200, Thomas Petazzoni wrote:

> Thomas Petazzoni (2):
>   dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
>     controller
>   pci: host: new driver for Marvell Armada 7K/8K PCIe controller
> 
>  .../devicetree/bindings/pci/pci-armada8k.txt       |  38 +++
>  drivers/pci/host/Kconfig                           |  11 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-armada8k.c                   | 261 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  create mode 100644 drivers/pci/host/pcie-armada8k.c

Bjorn, any comment about this additional PCIe host driver? The
corresponding Device Tree binding has been approved by Rob Herring. The
driver itself is fairly trivial as it relies on the common Designware
logic.

DO not hesitate to let me know if any adaptation/change is needed. I'd
really like to have this merged for the 4.7 merge window.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
