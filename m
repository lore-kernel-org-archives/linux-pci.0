Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 13 Oct 2017 16:42:13 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 1/4] dt-bindings: PCI: dra7xx: Add SoC specific
 compatible strings
Message-ID: <20171013214213.6bysqtoc2b7lm4sj@rob-hp-laptop>
References: <20171010101606.15951-1-kishon@ti.com>
 <20171010101606.15951-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010101606.15951-2-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 10, 2017 at 03:46:03PM +0530, Kishon Vijay Abraham I wrote:
> Add new compatible strings for dra74x SoC (also used by dra76x) and
> dra72x. This can be used to perform SoC specific configuration
> (like configuring PCIe in x2 lane mode).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
