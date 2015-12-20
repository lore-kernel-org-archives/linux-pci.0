Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Dec 2015 21:38:50 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rogerq@ti.com, nsekhar@ti.com,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	tony@atomide.com, t-kristo@ti.com
Subject: Re: [PATCH v3 7/9] phy: ti-pipe3: use *syscon* framework API to set
 PCS value of the PHY
Message-ID: <20151220033850.GH9883@rob-hp-laptop>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-8-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450170968-11282-8-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 15, 2015 at 02:46:06PM +0530, Kishon Vijay Abraham I wrote:
> Deprecate using phy-omap-control driver to set PCS value of the PHY
> and start using *syscon* API to do the same.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |    2 ++
>  drivers/phy/phy-ti-pipe3.c                       |   34 +++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
