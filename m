Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36758 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeCFIQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 03:16:58 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so8445412pfx.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2018 00:16:58 -0800 (PST)
Date: Tue, 6 Mar 2018 16:16:17 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180306081614.GG28619@dragon>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180220153947.GA21801@e107981-ln.cambridge.arm.com>
 <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
 <20180305094918.GB28109@e107981-ln.cambridge.arm.com>
 <CAOMZO5CFXBciQBOpPDtZc9L48d5Y3zubCK8M=HWo+owEOTQkrQ@mail.gmail.com>
 <20180305122440.GA29780@e107981-ln.cambridge.arm.com>
 <13b24b99-9de7-3306-a8dc-509c06af2f63@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13b24b99-9de7-3306-a8dc-509c06af2f63@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 05, 2018 at 06:38:48PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Monday 05 March 2018 05:54 PM, Lorenzo Pieralisi wrote:
> > On Mon, Mar 05, 2018 at 08:55:43AM -0300, Fabio Estevam wrote:
> >> Hi Lorenzo,
> >>
> >> On Mon, Mar 5, 2018 at 6:49 AM, Lorenzo Pieralisi
> >> <lorenzo.pieralisi@arm.com> wrote:
> >>
> >>> It is a balance of urgency and making sure it is extensively tested -
> >>> I'd prefer it to go via usual release cycle (and -next) and then it will
> >>> trickle into stable kernels, let me know if that's not OK.
> >>>
> >>> I would understand your point if dwc maintainers were more proactive
> >>> in testing their respective controllers - all of them should be affected
> >>> by this fix but I have just heard from a few of them.
> >>
> >> We got this patch tested by: Koen, myself, Sebastian and the folks at
> >> Pengutronix.
> >>
> >> Looks like a decent amount of testing IMHO.
> > 
> > IIUC you all tested the same dwc host bridge variant (ie imx6) - I want
> > to understand if it works across dwc variants because this patch affects
> > them all.
> > 
> >> In this case I would prefer that we could fix the regression into
> >> 4.16-rc cycle rather than waiting until 4.17.
> > 
> > I will decide what to do shortly - I would really appreciate if other
> > dwc host bridge maintainers (that are CC'ed) can share the testing effort.
> 
> For some reason I don't see the issues mentioned in this patch in dra7xx. The
> root bus has a subordinate bus number as 01 but I'm able to read the
> configuration space of the devices behind the bridge with bus number 2. I'll
> have to take a closer look at what exactly happens.

Just for record, I do not seem to see this issue on pcie-histb driver
as well.  Or did I miss anything?

# lspci -v
00:00.0 PCI bridge: Device 19e5:5610 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 24
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 03800000-041fffff
        Prefetchable memory behind bridge: 03000000-037fffff
        [virtual] Expansion ROM at f4200000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: pcieport
lspci: Unable to load libkmod resources: error -12

01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
        Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 25
        Memory at f4000000 (32-bit, non-prefetchable) [size=128K]
        Memory at f3800000 (32-bit, non-prefetchable) [size=4M]
        I/O ports at 1000 [disabled] [size=32]
        Memory at f4040000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at f3000000 [disabled] [size=4M]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable- Count=10 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 90-e2-ba-ff-ff-18-2b-48
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: igb

01:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
        Subsystem: Intel Corporation Gigabit ET Dual Port Server Adapter
        Flags: bus master, fast devsel, latency 0, IRQ 26
        Memory at f4020000 (32-bit, non-prefetchable) [size=128K]
        Memory at f3c00000 (32-bit, non-prefetchable) [size=4M]
        I/O ports at 1020 [disabled] [size=32]
        Memory at f4084000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at f3400000 [disabled] [size=4M]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable- Count=10 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 90-e2-ba-ff-ff-18-2b-48
        Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
        Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
        Kernel driver in use: igb

Shawn
