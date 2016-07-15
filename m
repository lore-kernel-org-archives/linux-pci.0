Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40320 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbcGOVsB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 17:48:01 -0400
Date: Fri, 15 Jul 2016 16:47:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory and IO space Enabling different in x86 and ARM64
Message-ID: <20160715214757.GA1706@localhost>
References: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 15, 2016 at 08:29:49AM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> I observe that memory and IO space are enabled by BIOS in x86.
> 
> In ARM64 we need to call pci_enable_device form End Point to enable these resources.
> 
> Why the resource enablement is different in x86 and ARM64 ?

A portable driver should call pci_enable_device() if it needs access
to any BARs.  As you've observed, the command register enable bits may
be set differently on different architectures, and the PCI core
doesn't set them automatically for you, so the driver can't rely on
their initial settings.

One reason why Linux doesn't enable them automatically before calling
the driver's probe method is that it may not be possible to allocate
space for all the BARs (e.g., if the platform doesn't support I/O port
space, or if we just run out of space), but the driver may be able to
operate the device even without all the BARs.

Bjorn
