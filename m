Return-Path: <SRS0=8J87=6G=arm.com=will.deacon@kernel.org>
Return-Path: <SRS0=8J87=6G=arm.com=will.deacon@kernel.org>
Date: Mon, 3 Jul 2017 11:47:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>, guodong.xu@linaro.org,
	bhelgaas@google.com, robh+dt@kernel.org, suzhuangluan@hisilicon.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 0/3]add PCIe driver for Kirin PCIe
Message-ID: <20170703104727.GB1573@arm.com>
References: <20170619102349.50652-1-songxiaowei@hisilicon.com>
 <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 02, 2017 at 06:36:57PM -0500, Bjorn Helgaas wrote:
> [+cc Catalin, Will, linux-arm-kernel]
> 
> Applied patches 2 & 3 to pci/host-kirin for v4.13.
> 
> I would like a MAINTAINERS update, too.  If you send me that, I'll
> squash it into the driver patch.
> 
> Catalin, Will, how do you want to handle the
> arch/arm64/configs/defconfig change (patch 3)?  It's currently on my
> branch, but I'm happy to drop it if another route is better.

defconfig updates usually go through arm-soc, via the relevant platform
maintainer, so it would be best to follow that route here too otherwise
you'll probably see conflicts in -next.

Will
