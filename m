Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:10752
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751217AbcGPDXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 23:23:01 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
Subject: RE: Memory and IO space Enabling different in x86 and ARM64
Date: Sat, 16 Jul 2016 03:22:30 +0000
Message-ID: <8520D5D51A55D047800579B094147198258B98B2@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
 <7127812.WYSppNUyGc@wuerfel>
In-Reply-To: <7127812.WYSppNUyGc@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: Memory and IO space Enabling different in x86 and ARM64
>
> On Friday, July 15, 2016 8:29:49 AM CEST Bharat Kumar Gogada wrote:
> > I observe that memory and IO space are enabled by BIOS in x86.
> >
> > In ARM64 we need to call pci_enable_device form End Point to enable
> these resources.
> >
> > Why the resource enablement is different in x86 and ARM64 ?
> >
> > Please correct me if my observation is wrong.
>
> This is a difference between systems with a BIOS and embedded systems
> with a plain bootloader that ignores PCI. On an ARM64 server system with
> UEFI you should expect the device to be usable too, but on an embedded
> system, Linux takes the role of the BIOS.
>
Thanks Arnd Bergmann



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

