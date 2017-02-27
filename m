Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Feb 2017 13:42:53 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [RESEND PATCH v5 1/4] PCI: imx6: Add code to support i.MX7D
Message-ID: <20170227194253.i7vcouppxr62sgh5@rob-hp-laptop>
References: <20170220160900.7014-1-andrew.smirnov@gmail.com>
 <20170220160900.7014-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170220160900.7014-2-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 yurovsky@gmail.com, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 20, 2017 at 08:08:57AM -0800, Andrey Smirnov wrote:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 ++-

I guess the conclusion of the discussion is this is fine, so:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/host/pci-imx6.c                        | 121 ++++++++++++++++-----
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 112 insertions(+), 26 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
