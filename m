Return-Path: <SRS0=ErCP=BM=rock-chips.com=jeffy.chen@kernel.org>
Return-Path: <SRS0=ErCP=BM=rock-chips.com=jeffy.chen@kernel.org>
Message-ID: <59E11358.3090409@rock-chips.com>
Date: Sat, 14 Oct 2017 03:26:16 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 briannorris@chromium.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com> <20170911151029.25185-2-jeffy.chen@rock-chips.com> <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com> <2453698.N4jfPaHx71@aspire.rjw.lan> <59E10709.4020300@rock-chips.com> <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 10/14/2017 03:19 AM, Bjorn Helgaas wrote:
> I'm sure they're harmless.  The point is that the cleanup should be
> done near the failure, not in the caller of the caller of the function
> where the failure was detected.  You have:
>
>    rockchip_pcie_probe
>      rockchip_pcie_parse_dt
>        rockchip_pcie_setup_irq
>          err = dev_pm_set_dedicated_wake_irq
>          if (err)
>            dev_err(...)
>
> So you detect the error in rockchip_pcie_setup_irq(), but you clean up
> from it in rockchip_pcie_probe(), which doesn't make sense because
> rockchip_pcie_probe() doesn't do anything related to wakeup interupts.
>
right, but if something wrong happens in rockchip_pcie_probe() later 
than rockchip_pcie_setup_irq(), we may still need to clean it up ;)

i think the error handling is a little like what we do in the remove 
callback
> Bjorn
>
>
>
