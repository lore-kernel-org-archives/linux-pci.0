Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v5 2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Date: Tue, 05 Jul 2016 10:15:33 +0200
Message-ID: <3471444.31RlTMvDfn@wuerfel>
In-Reply-To: <1467686561-25638-2-git-send-email-shawn.lin@rock-chips.com>
References: <1467686561-25638-1-git-send-email-shawn.lin@rock-chips.com> <1467686561-25638-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 5, 2016 10:42:41 AM CEST Shawn Lin wrote:
> +config PCIE_ROCKCHIP
> +       tristate "Rockchip PCIe controller"
> +       depends on ARM64 && ARCH_ROCKCHIP
> +       depends on OF
> +       select MFD_SYSCON
> +       select PCI_MSI_IRQ_DOMAIN if PCI_MSI

Please use "depends on PCI_MSI_IRQ_DOMAIN" now, instead of "select PCI_MSI_IRQ_DOMAIN
if PCI_MSI", we have reworked how this is handled for consistency.

	Arnd
