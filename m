Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbcHSBBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:01:14 -0400
Date: Thu, 18 Aug 2016 16:02:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v9 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160818210237.GP27353@localhost>
References: <1470297128-6213-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470297128-6213-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 04, 2016 at 03:52:07PM +0800, Shawn Lin wrote:
> This patch adds a binding that describes the Rockchip PCIe controller
> found on Rockchip SoCs PCIe interface.
> ...

> +- msi-map: Maps a Requester ID to an MSI controller and associated.

And associated *what*?

> +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie.
> +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie.
> +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie.

s/pcie/PCIe/ (also elsewhere in this patch)
