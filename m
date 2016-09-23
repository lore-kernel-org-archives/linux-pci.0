Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Sep 2016 16:46:16 -0500
From: Rob Herring <robh@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Support quirk to disable 5 GT/s (PCIe
 2.x) link rate
Message-ID: <20160923214616.GA30743@rob-hp-laptop>
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

Acked-by: Rob Herring <robh@kernel.org>
