Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbeAWOil (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 09:38:41 -0500
Date: Tue, 23 Jan 2018 08:38:39 -0600
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
Message-ID: <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 01:25:56PM +0000, Ron Yuan wrote:

I'm reproducing Sinan's picture here so we can see what you're talking
about:

> >>>>                root (MPS=256)
> >>>>                  |
> >>>>          ------------------
> >>>>         /                  \
> >>>>    bridge0 (MPS=256)      bridge1 (MPS=128)
> >>>>       /                       \
> >>>>     EP0 (MPS=256)            EP1 (MPS=128)
> >>>>

> > PERFORMANCE mode reduces MRRS not because of a starvation issue,
> > but because reducing EP1's MRRS allows EP0 to use a larger MPS.

> Looks like this case is talking about EP1 requests data directly
> from EP0, using MRRS to control the return data payload, while still
> keeping the traffic from EP0 to RC in 256B. 

No, this is not talking about EP1 requesting data from EP0.  That
would be peer-to-peer DMA, and PERFORMANCE mode explicitly assumes
there is no peer-to-peer DMA.  It reduces MRRS to allow EP0 to use a
larger MPS.

We must guarantee that no device receives a TLP larger than its MPS
setting.  The simple and obvious configuration is to set MPS=128 for
everything in Sinan's picture.  That works correctly but limits EP0's
performance.

What PERFORMANCE mode does is set MPS as shown in the picture and set
EP1's MRRS=128.  We're assuming no peer-to-peer DMA, but of course EP1
may still need to do DMA reads from system memory, and setting its
MRRS=128 means those reads will be of 128 bytes or less.

If we set EP1's MRRS=256, it could do a 256-byte DMA read from system
memory, the root port could send a 256-byte completion, and bridge1
would treat that as a malformed TLP because its MPS=128.
