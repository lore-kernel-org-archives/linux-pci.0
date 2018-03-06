Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:51925 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbeCFKNk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 05:13:40 -0500
Subject: Re: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
To: Shawn Guo <shawn.guo@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        <linux-pci@vger.kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
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
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180220153947.GA21801@e107981-ln.cambridge.arm.com>
 <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
 <20180305094918.GB28109@e107981-ln.cambridge.arm.com>
 <CAOMZO5CFXBciQBOpPDtZc9L48d5Y3zubCK8M=HWo+owEOTQkrQ@mail.gmail.com>
 <20180305122440.GA29780@e107981-ln.cambridge.arm.com>
 <13b24b99-9de7-3306-a8dc-509c06af2f63@ti.com> <20180306081614.GG28619@dragon>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <5118dcfd-eaf4-3ca0-8089-469bcf63de8e@axis.com>
Date: Tue, 6 Mar 2018 11:13:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180306081614.GG28619@dragon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/18 09:16, Shawn Guo wrote:
> On Mon, Mar 05, 2018 at 06:38:48PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On Monday 05 March 2018 05:54 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Mar 05, 2018 at 08:55:43AM -0300, Fabio Estevam wrote:
>>>> Hi Lorenzo,
>>>>
>>>> On Mon, Mar 5, 2018 at 6:49 AM, Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>>> It is a balance of urgency and making sure it is extensively tested -
>>>>> I'd prefer it to go via usual release cycle (and -next) and then it will
>>>>> trickle into stable kernels, let me know if that's not OK.
>>>>>
>>>>> I would understand your point if dwc maintainers were more proactive
>>>>> in testing their respective controllers - all of them should be affected
>>>>> by this fix but I have just heard from a few of them.
>>>>
>>>> We got this patch tested by: Koen, myself, Sebastian and the folks at
>>>> Pengutronix.
>>>>
>>>> Looks like a decent amount of testing IMHO.
>>>
>>> IIUC you all tested the same dwc host bridge variant (ie imx6) - I want
>>> to understand if it works across dwc variants because this patch affects
>>> them all.
>>>
>>>> In this case I would prefer that we could fix the regression into
>>>> 4.16-rc cycle rather than waiting until 4.17.
>>>
>>> I will decide what to do shortly - I would really appreciate if other
>>> dwc host bridge maintainers (that are CC'ed) can share the testing effort.
>>
>> For some reason I don't see the issues mentioned in this patch in dra7xx. The
>> root bus has a subordinate bus number as 01 but I'm able to read the
>> configuration space of the devices behind the bridge with bus number 2. I'll
>> have to take a closer look at what exactly happens.
> 
> Just for record, I do not seem to see this issue on pcie-histb driver
> as well.  Or did I miss anything?

Shawn:

You don't seem to have a PCIe switch, so your setup isn't affected by the bug.


Kishon:

Please add an endpoint device behind your switch, and retest.
You will probably not see your endpoint device without this fix.

On ARTPEC-6, 03:00.0 is only shown with this fix.


On ARTPEC-6 without this fix:

# lspci -v
00:00.0 Class 0604: Device 1912:0024
	Flags: bus master, fast devsel, latency 0, IRQ 44
	Memory at c0100000 (32-bit, prefetchable) [size=1M]
	Memory at c0200000 (32-bit, prefetchable) [size=1M]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [70] Express Root Port (Slot-), MSI 00
	Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
	Capabilities: [100] Advanced Error Reporting
	Kernel driver in use: pcieport

01:00.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [5c] Vital Product Data
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Upstream Port, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [230] Latency Tolerance Reporting
	Kernel driver in use: pcieport

02:01.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0, IRQ 45
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Downstream Port (Slot+), MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [220] Access Control Services
	Kernel driver in use: pcieport

02:02.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0, IRQ 46
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Downstream Port (Slot+), MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [220] Access Control Services
	Kernel driver in use: pcieport


On ARTPEC-6 with this fix:

# lspci -v
00:00.0 Class 0604: Device 1912:0024
	Flags: bus master, fast devsel, latency 0, IRQ 44
	Memory at c0100000 (32-bit, prefetchable) [size=1M]
	Memory at c0200000 (32-bit, prefetchable) [size=1M]
	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: c0300000-c03fffff [size=1M]
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [70] Express Root Port (Slot-), MSI 00
	Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
	Capabilities: [100] Advanced Error Reporting
	Kernel driver in use: pcieport

01:00.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=01, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: c0300000-c03fffff [size=1M]
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [5c] Vital Product Data
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Upstream Port, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [230] Latency Tolerance Reporting
	Kernel driver in use: pcieport

02:01.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0, IRQ 45
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: c0300000-c03fffff [size=1M]
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Downstream Port (Slot+), MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [220] Access Control Services
	Kernel driver in use: pcieport

02:02.0 Class 0604: Device 12d8:2304 (rev 05)
	Flags: bus master, fast devsel, latency 0, IRQ 46
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: None
	Prefetchable memory behind bridge: None
	Capabilities: [40] Power Management version 3
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device 0000:0000
	Capabilities: [c0] Express Downstream Port (Slot+), MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [20c] Power Budgeting <?>
	Capabilities: [220] Access Control Services
	Kernel driver in use: pcieport

03:00.0 Class 0c03: Device 1912:0015 (rev 02) (prog-if 30)
	Flags: fast devsel
	Memory at c0300000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [90] MSI-X: Enable- Count=8 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [150] Latency Tolerance Reporting


Best regards,
Niklas
