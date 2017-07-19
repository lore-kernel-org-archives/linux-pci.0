Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9993 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdGSHv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 03:51:56 -0400
Subject: Re: [RFC PATCH v4 3/7] phy: rockcip-pcie: reconstruct driver to
 support per-lane PHYs
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
 <1500448979-93067-4-git-send-email-shawn.lin@rock-chips.com>
CC: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        <linux-pci@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e1afec0e-ba1b-4721-4ddb-c6ef3b85e65f@ti.com>
Date: Wed, 19 Jul 2017 13:20:03 +0530
MIME-Version: 1.0
In-Reply-To: <1500448979-93067-4-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 19 July 2017 12:52 PM, Shawn Lin wrote:
> This patch reconstructs the whole driver to support per-lane
> PHYs. Note that we could also support the legacy PHY if you
> don't provide argument to our of_xlate.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

This design looks good! I'll queue this once I start queuing 4.14.

Thanks
Kishon
