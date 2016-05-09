Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 May 2016 15:24:56 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: niklass@axis.com, jespern@axis.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Axis
 ARTPEC-6 PCIe controller
Message-ID: <20160509202456.GA23043@rob-hp-laptop>
References: <1462794507-30262-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462794507-30262-1-git-send-email-niklass@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 01:48:27PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> This commit adds the Device Tree binding documentation that allows to
> describe the PCIe controller found in the Axis ARTPEC-6 SoC.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> Changes since v1:
>  - Rename syscon node to be more descriptive
> 
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
