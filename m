Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:35920
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751495AbeAEO0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jan 2018 09:26:38 -0500
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Jim Quinlan" <jim2101024@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Subject: RE: Why do we check for "link-up" in *_pcie_valid_device()?
Date: Fri, 5 Jan 2018 14:26:34 +0000
Message-ID: <BLUPR0201MB1505659A7B1DDA658EFB7049A51C0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171214225821.GN30595@bhelgaas-glaptop.roam.corp.google.com>
 <BLUPR0201MB1505F95E1BE417834E847EE6A5020@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171222172815.GA55396@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 22, 2017 at 01:02:28PM +0000, Bharat Kumar Gogada wrote:
> Bjorn wrote:
>> In the PCI config access path, the *_pcie_valid_device() functions in=20
>> the dwc, altera, rockchip, and xilinx drivers all check whether the=20
>> link is up.
>>=20
>> I think this is racy because the link may go down after we check but=20
>> before we perform the config access.
>>=20
>> What would blow up if we removed the *_pcie_link_up() checks?
>>=20
>> I'd like to either remove the checks or add comments about why the=20
>> race is acceptable.  If we've covered this before, I apologize.
>> Adding a comment will keep me from pestering you about this again in=20
>> the future.

> In both Xilinx driver cases when link is down, hardware responds by=20
> AXI DECERR/SLVERR status which causes an exception, synchronous=20
> external abort to CPU.  This causes system to hang, so we need this=20
> check for both of our drivers.  We will add comments.

This is a problem, and checking whether the link is up is a workaround but =
not a real solution.  That means your system may hang if the link happens t=
o go down at the wrong time.

A real solution would be to handle the synchronous external abort so it doe=
sn't cause a system hang.

Yes, I agree that this is workaround. For pcie-xilinx.c for arm32, we can h=
ave fault handling similar to "imx6q_pcie_abort_handler" in drivers/pci/dwc=
/pci-imx6.c.
Since this driver is same for Microblaze architecture also, it requires sep=
arate handling.

For pcie-xilinx-nwl.c ARM64 as per link [1], linux kernel will hang for the=
 above AXI responses.=20
As of now arm64 RAS is still work in progress [2]. =20

[1] https://www.spinics.net/lists/arm-kernel/msg624203.html

[2] https://patchwork.kernel.org/patch/9973967/

The check can be removed, if above issues were addressed.

Regards,
Bharat



=20
