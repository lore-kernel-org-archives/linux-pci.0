Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:25493
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751217AbcGPDZO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 23:25:14 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	nofooter <nofooter@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: RE: Memory and IO space Enabling different in x86 and ARM64
Date: Sat, 16 Jul 2016 03:25:04 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B98C5@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160715214757.GA1706@localhost>
In-Reply-To: <20160715214757.GA1706@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: Memory and IO space Enabling different in x86 and ARM64
>
> On Fri, Jul 15, 2016 at 08:29:49AM +0000, Bharat Kumar Gogada wrote:
> > Hi,
> >
> > I observe that memory and IO space are enabled by BIOS in x86.
> >
> > In ARM64 we need to call pci_enable_device form End Point to enable
> these resources.
> >
> > Why the resource enablement is different in x86 and ARM64 ?
>
> A portable driver should call pci_enable_device() if it needs access
> to any BARs.  As you've observed, the command register enable bits may
> be set differently on different architectures, and the PCI core
> doesn't set them automatically for you, so the driver can't rely on
> their initial settings.
>
> One reason why Linux doesn't enable them automatically before calling
> the driver's probe method is that it may not be possible to allocate
> space for all the BARs (e.g., if the platform doesn't support I/O port
> space, or if we just run out of space), but the driver may be able to
> operate the device even without all the BARs.
>
Thanks Bjorn


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

