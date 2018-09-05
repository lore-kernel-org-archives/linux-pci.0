Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 5 Sep 2018 12:25:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
Message-ID: <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Follow capitalization conventions for subject.

On Wed, Sep 05, 2018 at 11:32:11AM +0900, Kunihiko Hayashi wrote:
> This introduces specific glue layer for UniPhier platform to support
> PCIe host controller that is based on the Designware PCIe Core, and
> this driver supports Root Complex (host) mode.

s/Designware/DesignWare/
s/Core/core/

> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> new file mode 100644
> index 0000000..13ce02e
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// PCI-express host controller driver for UniPhier SoCs
> +// Copyright 2018 Socionext Inc.
> +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Use /* ... */ comments except for the SPDX line.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
