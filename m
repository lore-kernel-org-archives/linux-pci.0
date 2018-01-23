Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeAWRsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 12:48:23 -0500
Date: Tue, 23 Jan 2018 11:48:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ron Yuan <ron.yuan@memblaze.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bo Chen <bo.chen@memblaze.com>,
        William Huang <william.huang@memblaze.com>,
        Fengming Wu <fengming.wu@memblaze.com>,
        Jason Jiang <jason.jiang@microsemi.com>,
        Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
        Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
        William Cheng <william.cheng@microsemi.com>,
        "Kim Helper (khelper)" <khelper@micron.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
Message-ID: <20180123174821.GF5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org>
 <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org>
 <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org>
 <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <SHAPR01MB173D186666EBAFEC5367AACFEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SHAPR01MB173D186666EBAFEC5367AACFEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 02:01:27PM +0000, Ron Yuan wrote:
> Just got the log, see attachment. Kernel is under "perf" mode.
> SSD and Ethernet controller are both set to 256B MRRS. 

Here's what I see from lspci:

  3a:00.0 Root Port to 3b     MPS_cap=256 MPS=256 MRRS=128
  3b:00.0 NIC Endpoint        MPS_cap=512 MPS=256 MRRS=256
  3b:00.1 NIC Endpoint        MPS_cap=512 MPS=256 MRRS=256

Here, the NICs support up to MPS=512 but the Root Port only supports
MPS=256.  We must set MPS=256 for the NICs.  Otherwise, the NICs could
do 512-byte DMA writes to system memory, and the Root Port would treat
those TLPs as malformed.

There is no need to limit MRRS because there are no other devices
under this Root Port.  We can't tell from lspci what the maximum MRRS
is, but if the NICs support MRRS=4096, we could use that.

  ae:00.0 Root Port to af     MPS_cap=256 MPS=256 MRRS=128
  ae:01.0 Root Port to b0     MPS_cap=256 MPS=256 MRRS=128
  af:00.0 SSD Endpoint        MPS_cap=256 MPS=256 MRRS=256
  b0:00.0 SSD Endpoint        MPS_cap=256 MPS=256 MRRS=256

Everything here supports MPS=256, so that's what we should use.

As with the NICs, there's no need to limit MRRS here.  We don't know
what MRRS the endpoints support, but PERFORMANCE mode is being
unnecessarily conservative when it limits MRRS to the MPS (256 in this
case).

It's not as simple as just removing the "set MRRS=MPS" part because we
do rely on that in some topologies.  There are interesting topologies
where we *don't* need it, like both of the ones above, and we need to
make Linux smart enough to recognize them.
