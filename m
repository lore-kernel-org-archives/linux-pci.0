Return-Path: <SRS0=j+1X=73=rock-chips.com=jeffy.chen@kernel.org>
Return-Path: <SRS0=j+1X=73=rock-chips.com=jeffy.chen@kernel.org>
Message-ID: <599F7433.4070606@rock-chips.com>
Date: Fri, 25 Aug 2017 08:49:55 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
 Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 briannorris@chromium.org, Will Deacon <will.deacon@arm.com>,
 dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v4 0/4] PCI: rockchip: Move PCIE_WAKE handling into rockchip
 pcie driver
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com> <20170824165505.GM31858@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170824165505.GM31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08/25/2017 12:55 AM, Bjorn Helgaas wrote:
> Looking for acks from Shawn and Rob...
>
> And I'm not sure about the DT wake IRQ description.  That seems like it
> could potentially be generic than this Rockchip-specific proposal.
>
>
it looks like shawn already take the error handling patch into his 
series, so i'll remove that one in my next version.

i'll wait for those error handling patches to land, then rebase and 
resend this wake irq patches, thanks:)

>
