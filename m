Return-Path: <SRS0=qLx8=EG=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=qLx8=EG=intel.com=keith.busch@kernel.org>
Date: Thu, 11 Jan 2018 10:59:16 -0700
From: Keith Busch <keith.busch@intel.com>
To: Maik Broemme <mbroemme@libmpq.org>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ASPM powersupersave change NVMe SSD Samsung 960 PRO capacity to
 0 and read-only
Message-ID: <20180111175916.GB2860@localhost.localdomain>
References: <20171214184701.GA6322@libmpq.org>
 <20171215002155.GR30595@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6HyBgNdav_Atzpxe1RGvpviJF2vsLhkgATjL2B7GnYnwg@mail.gmail.com>
 <20171215190126.GI19904@libmpq.org>
 <20180111175040.GJ1377@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111175040.GJ1377@libmpq.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 06:50:40PM +0100, Maik Broemme wrote:
> I've re-run the test with 4.15rc7.r111.g5f615b97cdea and the following
> patches from Keith:
> 
> [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not supported
> [PATCH 2/4] PCI/AER: Provide API for getting AER information
> [PATCH 3/4] PCI/DPC: Enable DPC in conjuction with AER
> [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
> 
> The issue is still the same. Additionally to the output before I see now:
> 
> Jan 11 18:34:45 server.theraso.int kernel: dpc 0000:00:10.0:pcie010: DPC containment event, status:0x1f09 source:0x0000
> Jan 11 18:34:45 server.theraso.int kernel: dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
> Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0080(Receiver ID)
> Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0:   device [8086:19aa] error status/mask=00000020/00000000
> Jan 11 18:34:45 server.theraso.int kernel: pcieport 0000:00:10.0:    [ 5] Surprise Down Error    (First)
> Jan 11 18:34:46 server.theraso.int kernel: nvme0n1: detected capacity change from 1024209543168 to 0

Okay, so that series wasn't going to fix anything, but at least it gets
some visibility into what's happened. The DPC was triggered due to a
Surprise Down uncorrectable error, so the power settting is causing the
link to fail.

The NVMe driver has quirks specifically for this vendor's devices to
fence off NVMe specific automated power settings. Your observations
appear to align with the same issues.
