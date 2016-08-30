Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60510 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751590AbcH3PZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2016 11:25:01 -0400
Date: Tue, 30 Aug 2016 17:24:47 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Yehuda Yitschak <yehuday@marvell.com>,
        Shadi Ammouri <shadi@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] pcie-designware: support for external MSI
 controller
Message-ID: <20160830172447.65d10772@free-electrons.com>
In-Reply-To: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 30 Aug 2016 14:57:07 +0200, Thomas Petazzoni wrote:

> Thomas Petazzoni (3):
>   dt-bindings: designware-pcie: document optional msi-parent property
>   pci: pcie-designware: add support for external MSI controller
>   arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K

Please discard this patch series, it's just pure crap. No changes at
all are needed on the pcie-designware driver, using the msi-parent
property already works, and my new code does nothing good.

The of_pci_find_msi_chip_by_node() API is on its way to being removed,
and it doesn't return anything useful.

Only PATCH 3/3 is needed, which I'll resubmit separately.

Sorry for the noise.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
