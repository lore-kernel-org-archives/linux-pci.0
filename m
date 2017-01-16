Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 16 Jan 2017 11:44:22 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] PCI: mvebu: change delay after reset to the PCIe spec
 mandated 100ms
Message-ID: <20170116114422.GA25924@io.lakedaemon.net>
References: <20170116111142.6866-1-l.stach@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20170116111142.6866-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, patchwork-lst@pengutronix.de, kernel@pengutronix.de,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Mon, Jan 16, 2017 at 12:11:42PM +0100, Lucas Stach wrote:
> The current default of 20ms cause some devices, which are slow to initialize,
> to not show up during the bus scanning. Change this to the PCIe spec mandated
> 100ms and document this in the DT binding.
> 
> From PCIe base spec rev 3.0, chapter "6.6.1. Conventional Reset":
> 
> "To allow components to perform internal initialization, system software must
> wait a specified minimum period following the end of a Conventional Reset of
> one or more devices before it is permitted to issue Configuration Requests to
> those devices.
> 
> With a Downstream Port that does not support Link speeds greater than
> 5.0 GT/s, software must wait a minimum of 100 ms before sending a
> Configuration Request to the device immediately below that Port."
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 3 ++-
>  drivers/pci/host/pci-mvebu.c                        | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
