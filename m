Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 12 Jun 2017 11:00:03 -0500
From: Rob Herring <robh@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH] PCI: imx6: add regulator support
Message-ID: <20170612160003.jrt4emvti3hmqiiw@rob-hp-laptop>
References: <20170608080742.3910-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
In-Reply-To: <20170608080742.3910-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, hongxing.zhu@nxp.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 08, 2017 at 10:07:42AM +0200, Quentin Schulz wrote:
> Some boards might require to control a regulator to power the PCIe port.
> 
> This adds support for an optional regulator defined in Device Tree
> linked in the PCIe controller under `vpcie-supply`. If present, the
> regulator will be disabled and then enabled as part of the PCIe host
> initialization process and will be disabled when shutting down.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  4 +++
>  drivers/pci/dwc/pci-imx6.c                         | 34 +++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
