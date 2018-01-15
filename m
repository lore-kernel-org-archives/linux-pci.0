Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:58740 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeAOTwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jan 2018 14:52:49 -0500
Date: Mon, 15 Jan 2018 21:52:42 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180115195242.GL27654@lahna.fi.intel.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 15, 2018 at 10:36:08AM +0100, Koen Vandeputte wrote:
> The subordinate value indicates the highest bus number which can be
> reached downstream though a certain device.
> 
> Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> parent")
> ensures that downstream devices cannot assign busnumbers higher than the
> upstream device subordinate number, which was indeed illogical.
> 
> By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
> value of 0x01.
> 
> Due to this combined with above commit, enumeration stops digging deeper
> downstream as soon as bus num 0x01 has been assigned, which is always
> the case for a bridge device.
> 
> This results in all devices behind a bridge bus to remain undetected, as
> these would be connected to bus 0x02 or higher.
> 
> Fix this by initializing the RC to a subordinate value of 0xff, which is
> not altering hardware behaviour in any way, but informs probing
> function pci_scan_bridge() later on which reads this value back from
> register.
> 
> Following nasty errors during boot are also fixed by this:
> 
> [    0.459145] pci_bus 0000:02: busn_res: can not insert [bus 02-ff]
> under [bus 01] (conflicts with (null) [bus 01])
> ...
> [    0.464515] pci_bus 0000:03: [bus 03] partially hidden behind bridge
> 0000:01 [bus 01]
> ...
> [    0.464892] pci_bus 0000:04: [bus 04] partially hidden behind bridge
> 0000:01 [bus 01]
> ...
> [    0.466488] pci_bus 0000:05: [bus 05] partially hidden behind bridge
> 0000:01 [bus 01]
> [    0.466506] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to
> 05
> [    0.466517] pci_bus 0000:02: busn_res: can not insert [bus 02-05]
> under [bus 01] (conflicts with (null) [bus 01])
> [    0.466534] pci_bus 0000:02: [bus 02-05] partially hidden behind
> bridge 0000:01 [bus 01]
> 
> Fixes: a20c7f36bd3d ("PCI: Do not allocate more buses than available in
> parent")
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Jianguo Sun <sunjianguo1@huawei.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
