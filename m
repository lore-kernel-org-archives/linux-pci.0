Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171012205220.130048-1-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Oct 2017 15:27:16 -0700
Message-ID: <CAD=FV=VyERPq9yGE27Uvj6bs4Mru81gZAiqCOP=yQv3ai6-YDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: rockchip: assert PERST# in S3
To: Brian Norris <briannorris@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thu, Oct 12, 2017 at 1:52 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi,
>
> This patch series should mostly be self-descriptive, but it's motivated by the
> fact that I've found differing requirements from PCIe endpoint makers regarding
> the state of PERST# when in system suspend (S3). Additionally, some existing
> boards are not especially well suited for holding PERST# low in S3 (e.g., the
> pin is driven by a non-PMU GPIO, so it's hard or impossible to keep it
> asserted). So the solution is...give it a device tree property!
>
> Brian
>
> Brian Norris (3):
>   Documentation/devicetree: Add pcie-reset-suspend property
>   of/pci: Add of_pci_get_pcie_reset_suspend() to parse
>     pcie-reset-suspend
>   PCI: rockchip: Support configuring PERST# state via DT
>
>  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
>  drivers/of/of_pci.c                           | 25 +++++++++++++++++++++++++
>  drivers/pci/host/pcie-rockchip.c              |  7 +++++++
>  include/linux/of_pci.h                        |  7 +++++++
>  4 files changed, 50 insertions(+)

I'm nowhere near an expert on PCIe, but overall the series seems sane
to me.  ...and I'd agree that the discussions I've seen from different
vendors seem to have different opinions about what we should do with
this line in S3.  ...so FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
