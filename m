Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	tinamdar@apm.com, treding@nvidia.com, rjui@broadcom.com,
	Minghuan.Lian@freescale.com, m-karicheri2@ti.com, hauke@hauke-m.de,
	marc.zyngier@arm.com, dhdang@apm.com, sbranden@broadcom.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe Host Controller
Date: Fri, 27 Nov 2015 16:51:38 +0100
Message-ID: <2717087.4cxEA98ZJk@wuerfel>
In-Reply-To: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 27 November 2015 20:32:03 Bharat Kumar Gogada wrote:
> +       do {
> +               err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> +               if (err != 1) {
> +                       check_link_up++;
> +                       if (check_link_up > LINKUP_ITER_CHECK)
> +                               return -ENODEV;
> +                       mdelay(1000);
> +               }
> +       } while (!err);

mdelay(1000) is not something anyone should do. Why can't you call
a sleeping function here?

	Arnd
