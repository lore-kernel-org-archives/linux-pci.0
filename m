Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170220153025.32096-1-andrew.smirnov@gmail.com>
References: <20170220153025.32096-1-andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 20 Feb 2017 07:47:42 -0800
Message-ID: <CAHQ1cqH3doxS_HHACXF3goJNQsm17cr5-7Xn1T18ZAY=nSTrmA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] i.MX7 PCI support
To: linux-pci@vger.kernel.org
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Andrey Yurovsky <yurovsky@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Ugh. Forgot to add correct CC list to patches #2 and #3 and drop
Lucas' Reviewed-by from patch #4 since code there changed. Please
ignore this thread. I'll resend all of the patches with aforementioned
corrections shortly.

Sorry for the noise.
Andrey

On Mon, Feb 20, 2017 at 7:30 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Hello, everyone:
>
> This is a fifth iteration of the code that adds PCI-subsystem bits
> necessary for enabling PCI support on i.MX7.
>
> Rob, Bjorn, power domain and reset bindings remained the same, please
> let me know if you still think that PHY aspect of the driver needs to
> be moved into a separate abstraction.
>
> Changes since v4 (can be found at [version4]):
>
>         - Dropped typo-fix patch (originally patch #1 of the
>           series). Bjorn, I am assuming that patch from v4 survived
>           and stayed in your tree, let me know if that is not true.
>
>         - Added patch with workaround to address speed change false
>           failures (I kept it as a separate patch to better document
>           exchange with NXP/Freescale that lead to that patch)
>
>         - Added patch to avoid speed change on links configured Gen1
>           only (Let me know if that is a terrible idea)
>
>         - Addressed section mismatch problem by moving call to
>           hook_fault_code to happend before driver registration.
>
> Changes since v3 (can be found at [version3]):
>         - Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
>         - Documented required reset and power domain DT bindings
>
> Changes since v2 (can be found at [version2]):
>
>         - Collected Reviewed-by for patch #2 from Lucas
>         - Reset logic implementation moved out into a reset controller
>           driver (see [reset1])
>         - Removed unused leftover code
>
> Changes since v1 (can be found at [version1]):
>
>         - All GPC related code moved into a separate driver (see [gpc1])
>         - Removed GPIO probe deferral logging
>         - Fixed section mismatch warning
>         - Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
>           Herring's request)
>
> [version4] https://lkml.org/lkml/2017/2/7/478
> [version3] https://lkml.org/lkml/2017/2/6/565
> [version2] https://lkml.org/lkml/2017/2/1/510
> [version1] https://lkml.org/lkml/2017/1/19/488
> [gpc1] https://lkml.org/lkml/2017/2/6/551
> [reset1] https://lkml.org/lkml/2017/2/6/554
>
> Andrey Smirnov (4):
>   PCI: imx6: Add code to support i.MX7D
>   PCI: imx6: Do not wait for speed change on i.MX7
>   PCI: imx6: Do not switch speed if Gen2 is disabled
>   PCI: imx6: Allow probe deferal by reset GPIO
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
>  drivers/pci/host/pci-imx6.c                        | 199 +++++++++++++++------
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 161 insertions(+), 55 deletions(-)
>
> --
> 2.9.3
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
