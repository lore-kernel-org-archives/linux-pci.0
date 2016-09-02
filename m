Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36714 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcIBPBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2016 11:01:36 -0400
Date: Fri, 2 Sep 2016 10:01:34 -0500
From: Rob Herring <robh@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
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
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 1/3] dt-bindings: designware-pcie: document optional
 msi-parent property
Message-ID: <20160902150134.GA17819@rob-hp-laptop>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472561830-20932-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472561830-20932-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 30, 2016 at 02:57:08PM +0200, Thomas Petazzoni wrote:
> This commit updates the Designware PCIe Device Tree binding
> documentation to document the optional msi-parent property. This
> property allows to point to an external MSI controller, which can
> optionally be provided. If provided, this external MSI controller is
> used in preference over the internal MSI controller of the Designware
> PCIe IP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
