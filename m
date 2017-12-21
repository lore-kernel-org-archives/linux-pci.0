Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Dec 2017 07:13:58 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/7] ARM: dts: dra7: Enable x2 lane mode support
Message-ID: <20171221151358.GQ3875@atomide.com>
References: <20171219093133.16565-1-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, bcousson@baylibre.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [171219 01:34]:
> Add properties to enable PCIe x2 lane mode since all dra7
> based SoCs support x2 lane mode.
> 
> However only dra76-evm has a slot which can support x2 lane
> cards. Hence only enable x2 lane mode in dra76-evm.
> (am571x-idk can support x2 lane mode but that makes usb port
> not functional so not including the patch to enable
> x2 mode in am571x-idk)
> 
> Also included in this series is patch to enable PCIe configs
> (both host and device) in omap2plus_defconfig and
> multi_v7_defconfig
> 
> In order to get x2 mode working [1] is required.
> 
> However by keeping the older compatible, this series won't
> break functionality if this series is merged before [1]

OK applying into omap-for-v4.16/dt and omap-for-v4.16/defconfig.

Thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
