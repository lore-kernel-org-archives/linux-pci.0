Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
 <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
 <57483CAA.8000005@arm.com> <20160603085547.GB24547@red-moon>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57514783.6000407@arm.com>
Date: Fri, 3 Jun 2016 10:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <20160603085547.GB24547@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/06/16 09:55, Lorenzo Pieralisi wrote:
> On Fri, May 27, 2016 at 01:25:14PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
>>> +	} else {
>>> +		bus = pci_scan_root_bus(&pdev->dev, 0,
>>> +					&rockchip_pcie_ops, port, &res);
>>> +	}
>>> +	if (!bus)
>>> +		return -ENOMEM;
>>> +
>>> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
>>
>> Why do you have catter for the PCI_PROBE_ONLY case? Nobody should ever
>> use that for properly implemented HW.
> 
> I think that's just copy and paste and it is a useless check given
> that the only way we can set that flag on ARM/ARM64 is through DT
> (of_pci_check_probe_only()) and I doubt that systems probing this
> driver really require a PCI_PROBE_ONLY set-up.
> 
> So, unless you can explain to us why it is really needed, please
> remove the:
> 
> if (!pci_has_flag(PCI_PROBE_ONLY))
> 
> check.

Agreed. Maybe we should add a comment somewhere saying that this is
deprecated on arm/arm64, and only useful to slightly dumb virtualization
environments (kvmtool being the prime example).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
