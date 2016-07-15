Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:52549 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbcGOIdi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 04:33:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	nofooter <nofooter@xilinx.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>
Subject: Re: Memory and IO space Enabling different in x86 and ARM64
Date: Fri, 15 Jul 2016 10:33:06 +0200
Message-ID: <7127812.WYSppNUyGc@wuerfel>
In-Reply-To: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 15, 2016 8:29:49 AM CEST Bharat Kumar Gogada wrote:
> I observe that memory and IO space are enabled by BIOS in x86.
> 
> In ARM64 we need to call pci_enable_device form End Point to enable these resources.
> 
> Why the resource enablement is different in x86 and ARM64 ?
> 
> Please correct me if my observation is wrong.

This is a difference between systems with a BIOS and embedded systems with
a plain bootloader that ignores PCI. On an ARM64 server system with UEFI
you should expect the device to be usable too, but on an embedded system,
Linux takes the role of the BIOS.

	Arnd

