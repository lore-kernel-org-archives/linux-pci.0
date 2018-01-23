Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:48032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752076AbeAWXvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 18:51:14 -0500
From: Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Ron Yuan <ron.yuan@memblaze.com>
CC: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Bo Chen" <bo.chen@memblaze.com>,
        William Huang <william.huang@memblaze.com>,
        Fengming Wu <fengming.wu@memblaze.com>,
        Jason Jiang <jason.jiang@microsemi.com>,
        Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
        William Cheng <william.cheng@microsemi.com>,
        "Kim Helper (khelper)" <khelper@micron.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>
Subject: RE: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
Date: Tue, 23 Jan 2018 23:50:30 +0000
Message-ID: <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
References: <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
 <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorne,

Ceiling the MRRS to the MPS value in order to guarantee the interoperabilit=
y in pcie_bus_perf mode does not make sense. A device can make a memrd requ=
est according to the MRRS setting (which can be higher than its MPS), but t=
he completer has to respect the MPS and send completions accordingly. As an=
 example, system can configure MPS=3D128B and MRRS=3D4K, where an endpoint =
can a make 4K MemRd request, but the completer has to send completions as 1=
28B TLPs, by respecting the MPS setting. MRRS does not force a device to us=
e higher MPS value than it is configured to.

Another factor that need to be considered for storage devices is that suppo=
rt of T10 Protection Information (DIF). For every 512B or 4KB, a 8B PI is c=
omputed and inserted or verified, which require the 512B of data to arrive =
in sequence. If the MRRS is < 512B, this might pose out of order completion=
s to the storage device, if the EP has to submit multiple outstanding read =
requests in order to achieve higher performance. This would be a challenge =
for the storage endpoints that process the T10 PI inline with the transfer,=
 now they have to store and process the 512B sectors once they receive all =
the TLPs for that sector.

So, it is better to decouple the MRRS and MPS in pcie_bus_perf mode. Like s=
tated earlier in the thread, provide an option to configure MRRS separately=
 in pcie_bus_perf mode.

Regards,
Radj.

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org]=20
Sent: Tuesday, January 23, 2018 6:39 AM
To: Ron Yuan <ron.yuan@memblaze.com>
Cc: Sinan Kaya <okaya@codeaurora.org>; Bjorn Helgaas <bhelgaas@google.com>;=
 Bo Chen <bo.chen@memblaze.com>; William Huang <william.huang@memblaze.com>=
; Fengming Wu <fengming.wu@memblaze.com>; Jason Jiang <jason.jiang@microsem=
i.com>; Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>; Ra=
myakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>; William Cheng <w=
illiam.cheng@microsemi.com>; Kim Helper (khelper) <khelper@micron.com>; Lin=
ux PCI <linux-pci@vger.kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or =
pcie_bus_perf On NVMe Device

EXTERNAL EMAIL


On Tue, Jan 23, 2018 at 01:25:56PM +0000, Ron Yuan wrote:

I'm reproducing Sinan's picture here so we can see what you're talking
about:

> >>>>                root (MPS=3D256)
> >>>>                  |
> >>>>          ------------------
> >>>>         /                  \
> >>>>    bridge0 (MPS=3D256)      bridge1 (MPS=3D128)
> >>>>       /                       \
> >>>>     EP0 (MPS=3D256)            EP1 (MPS=3D128)
> >>>>

> > PERFORMANCE mode reduces MRRS not because of a starvation issue, but=20
> > because reducing EP1's MRRS allows EP0 to use a larger MPS.

> Looks like this case is talking about EP1 requests data directly from=20
> EP0, using MRRS to control the return data payload, while still=20
> keeping the traffic from EP0 to RC in 256B.

No, this is not talking about EP1 requesting data from EP0.  That would be =
peer-to-peer DMA, and PERFORMANCE mode explicitly assumes there is no peer-=
to-peer DMA.  It reduces MRRS to allow EP0 to use a larger MPS.

We must guarantee that no device receives a TLP larger than its MPS setting=
.  The simple and obvious configuration is to set MPS=3D128 for everything =
in Sinan's picture.  That works correctly but limits EP0's performance.

What PERFORMANCE mode does is set MPS as shown in the picture and set EP1's=
 MRRS=3D128.  We're assuming no peer-to-peer DMA, but of course EP1 may sti=
ll need to do DMA reads from system memory, and setting its
MRRS=3D128 means those reads will be of 128 bytes or less.

If we set EP1's MRRS=3D256, it could do a 256-byte DMA read from system mem=
ory, the root port could send a 256-byte completion, and bridge1 would trea=
t that as a malformed TLP because its MPS=3D128.
