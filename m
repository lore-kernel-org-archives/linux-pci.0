Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Sep 2016 18:55:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Support quirk to disable 5 GT/s (PCIe
 2.x) link rate
Message-ID: <20160923235500.GA3569@localhost>
References: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 22, 2016 at 10:31:18AM -0700, Brian Norris wrote:
> rk3399 supports PCIe 2.x link speeds marginally at best, and on some
> boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
> ms waiting for training that will never happen, let's support a device
> tree quirk flag to disable generation 2 speeds entirely.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/pci/rockchip-pcie.txt      |  2 +
>  drivers/pci/host/pcie-rockchip.c                   | 57 +++++++++++++---------
>  2 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index ba67b39939c1..e769726fd093 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -42,6 +42,8 @@ Required properties:
>  Optional Property:
>  - ep-gpios: contain the entry for pre-reset gpio
>  - num-lanes: number of lanes to use
> +- rockchip,disable-gen2: present if PCIe generation 2.x (i.e., 5 GT/s link
> +	speeds) is not supported.
>  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
>  - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
>  - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.

We already have st,pcie-is-gen1 and fsl,max-link-speed for similar
issues.  Can you copy the naming of one of those?  The
"max-link-speed" one seems a little more general.

Bjorn
