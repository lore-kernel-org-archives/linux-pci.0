Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Jan 2016 07:28:35 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rogerq@ti.com, nsekhar@ti.com
Subject: Re: [PATCH 2/2] phy: ti-pipe3: configure usb3 phy to be used as pcie
 phy
Message-ID: <20160106132835.GA20318@rob-hp-laptop>
References: <1452077948-26232-1-git-send-email-kishon@ti.com>
 <1452077948-26232-3-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452077948-26232-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 06, 2016 at 04:29:08PM +0530, Kishon Vijay Abraham I wrote:
> DRA72 uses USB3 PHY for the 2nd lane of PCIE. The configuration
> required to make USB3 PHY used for the 2nd lane of PCIe is done
> here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
>  drivers/phy/phy-ti-pipe3.c                       |   30 +++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
