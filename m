Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 3 Jul 2017 07:55:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 0/3]add PCIe driver for Kirin PCIe
Message-ID: <20170703125520.GA13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170619102349.50652-1-songxiaowei@hisilicon.com>
 <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
 <20170703104727.GB1573@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170703104727.GB1573@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 guodong.xu@linaro.org, linux-pci@vger.kernel.org, suzhuangluan@hisilicon.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Xiaowei Song <songxiaowei@hisilicon.com>, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 11:47:27AM +0100, Will Deacon wrote:
> On Sun, Jul 02, 2017 at 06:36:57PM -0500, Bjorn Helgaas wrote:
> > [+cc Catalin, Will, linux-arm-kernel]
> > 
> > Applied patches 2 & 3 to pci/host-kirin for v4.13.
> > 
> > I would like a MAINTAINERS update, too.  If you send me that, I'll
> > squash it into the driver patch.
> > 
> > Catalin, Will, how do you want to handle the
> > arch/arm64/configs/defconfig change (patch 3)?  It's currently on my
> > branch, but I'm happy to drop it if another route is better.
> 
> defconfig updates usually go through arm-soc, via the relevant platform
> maintainer, so it would be best to follow that route here too otherwise
> you'll probably see conflicts in -next.

OK, dropped the defconfig change and updated my -next branch.

I'm still looking for a MAINTAINERS update.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
