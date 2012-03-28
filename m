Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:44147 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232Ab2C1JaU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2012 05:30:20 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 28 Mar 2012 15:00:14 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2S9U6U94268104
	for <linux-pci@vger.kernel.org>; Wed, 28 Mar 2012 15:00:07 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2SExtaf031977
	for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2012 01:59:55 +1100
Received: from localhost ([9.123.247.55])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2SExs6H031941
	for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2012 01:59:54 +1100
Date: Wed, 28 Mar 2012 17:30:04 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: How acpi_walk_resources() find specific _CRS for one device
Message-ID: <20120328093004.GA31647@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Experts

I am reading the PCI enumeration code on x86. One thing on ACPI
namespace puzzles me.

In the initialize process, the call flow is like this
acpi_pci_root_add()
	try_get_root_bridge_busnr()
		acpi_walk_resources(handle, METHOD_NAME__CRS,
		         get_root_bridge_busnr_callback, res)

By reading the ACPI spec, this is trying to go through the namespace and
find  the _CRS method/object.

1. Hmm... I want to know this function is trying to go through the whole
   namespace or just the device related namespace? 
2. If it is searching the whole namespace, how could this function find the
   device specific resource just by given the "_CRS" as a parameter?
3. Also, if it just go through the device specific namespace, which
   parameter identify this.

Here is an example in the ACPI specification in 9.11.1:
Device (PCI0) { // PCI Root Bridge
	Name (_HID, EISAID("PNP0A03"))
	Name (_UID, 0)
	Name (_BBN, 0x00)
	Name (_SEG, 0x00) // assign segment 0 of module device to PCI0
	Name (_CRS, ResourceTemplate () {
		WordBusNumber (
			ResourceProducer,
			MinFixed, // _MIF
			MaxFixed,, // _MAF
			0x00, // _GRA
			0x00, // _MIN
			0xFF, // _MAX
			0x0, // _TRA
			0x80) // _LEN
		WordIO (
			ResourceProducer,
			MinFixed, // _MIF
			MaxFixed,,, // _MAF
			0x0000, // _GRA
			0x0000, // _MIN
			0x0CF7, // _MAX
			0x0, // _TRA
			0x0CF8) // _LEN
		DWordMemory (
			ResourceProducer,,
			MinNotFixed, // _MIF
			MaxNotFixed, // _MAF
			NonCacheable, // _MEM
			ReadWrite, // _RW
			0x0FFFFFFF, // _GRA
			0x40000000, // _MIN
			0x5FFFFFFF, // _MAX
			0x0, // _TRA
			0x00000000) // _LEN
	})
	}
}

Device (PCI1) { // PCI Root Bridge
	Name (_HID, EISAID("PNP0A03"))
	Name (_UID, 0)
	Name (_BBN, 0x00)
	Name (_SEG, 0x01) // assign segment 1 of module device to PCI1
	Name (_CRS, ResourceTemplate () {
		WordBusNumber (
			ResourceProducer,
			MinFixed, //
			MaxFixed,, //
			0x00, //
			0x00, //
			0x7F, //
			0x0, //
			0x80) //
		WordIO (
			ResourceProducer,
			MinFixed, //
			MaxFixed, //
			0x0000, //
			0x0D00, //
			0x7FFF, //
			0x0, //
			0x7300) //
		DWordMemory (
			ResourceProducer,
			MinNotFixed,
			MaxNotFixed,
			NonCacheable,
			ReadWrite,
			0x0FFFFFFF,
			0x60000000,
			0x7FFFFFFF,
			0x0,
			0x00000000)
	})
	}
}

We can see there are two PCI Root Bridge, and each has its own _CRS
field. And each field has its own busnumber/iores/memios.

So, in the acpi_walk_resources() function, how to find the proper _CRS
infomation for a root device?

-- 
Richard Yang
Help you, Help me

