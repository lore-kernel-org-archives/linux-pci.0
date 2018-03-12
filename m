Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:42738 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeCLNb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2018 09:31:57 -0400
Received: by mail-oi0-f51.google.com with SMTP id c18so12268251oiy.9
        for <linux-pci@vger.kernel.org>; Mon, 12 Mar 2018 06:31:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Mar 2018 10:31:56 -0300
Message-ID: <CAOMZO5AnKwhgznXh2rV-7LPCF0y+_nRRxNvc3jEbJFGPhjF=jQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root subordinate
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Koen,

On Mon, Jan 15, 2018 at 7:36 AM, Koen Vandeputte
<koen.vandeputte@ncentric.com> wrote:
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

This commit is in Linus' tree now as commit fc110ebdd014dd1368.

Could you please prepare a version that could be backported to 4.9
stable kernel?

Thanks
