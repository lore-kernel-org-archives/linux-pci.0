Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38570 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab2C1NUN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2012 09:20:13 -0400
Received: by iagz16 with SMTP id z16so1481636iag.19
        for <linux-pci@vger.kernel.org>; Wed, 28 Mar 2012 06:20:13 -0700 (PDT)
Message-ID: <4F731005.6000506@gmail.com>
Date: Wed, 28 Mar 2012 21:20:05 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Richard Yang <weiyang@linux.vnet.ibm.com>
CC: linux-pci@vger.kernel.org
Subject: Re: How acpi_walk_resources() find specific _CRS for one device
References: <20120328093004.GA31647@richard>
In-Reply-To: <20120328093004.GA31647@richard>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/28/2012 05:30 PM, Richard Yang wrote:
> Experts
> 
> I am reading the PCI enumeration code on x86. One thing on ACPI
> namespace puzzles me.
> 
> In the initialize process, the call flow is like this
> acpi_pci_root_add()
> 	try_get_root_bridge_busnr()
> 		acpi_walk_resources(handle, METHOD_NAME__CRS,
> 		         get_root_bridge_busnr_callback, res)
This piece of code is to invoke ACPI method "_CRS" for "handle", and call
get_root_bridge_busnr_callback for each resource descriptor returned by
this method.
Here "handle" is the object for the pci root bus or PCI host bridge.
"_CRS" is the name of ACPI method, which exists under "handle".

> 
> By reading the ACPI spec, this is trying to go through the namespace and
> find  the _CRS method/object.
> 
> 1. Hmm... I want to know this function is trying to go through the whole
>    namespace or just the device related namespace? 
> 2. If it is searching the whole namespace, how could this function find the
>    device specific resource just by given the "_CRS" as a parameter?
> 3. Also, if it just go through the device specific namespace, which
>    parameter identify this.
> 
> Here is an example in the ACPI specification in 9.11.1:
> Device (PCI0) { // PCI Root Bridge
> 	Name (_HID, EISAID("PNP0A03"))
> 	Name (_UID, 0)
> 	Name (_BBN, 0x00)
> 	Name (_SEG, 0x00) // assign segment 0 of module device to PCI0
> 	Name (_CRS, ResourceTemplate () {
> 		WordBusNumber (
> 			ResourceProducer,
> 			MinFixed, // _MIF
> 			MaxFixed,, // _MAF
> 			0x00, // _GRA
> 			0x00, // _MIN
> 			0xFF, // _MAX
> 			0x0, // _TRA
> 			0x80) // _LEN
> 		WordIO (
> 			ResourceProducer,
> 			MinFixed, // _MIF
> 			MaxFixed,,, // _MAF
> 			0x0000, // _GRA
> 			0x0000, // _MIN
> 			0x0CF7, // _MAX
> 			0x0, // _TRA
> 			0x0CF8) // _LEN
> 		DWordMemory (
> 			ResourceProducer,,
> 			MinNotFixed, // _MIF
> 			MaxNotFixed, // _MAF
> 			NonCacheable, // _MEM
> 			ReadWrite, // _RW
> 			0x0FFFFFFF, // _GRA
> 			0x40000000, // _MIN
> 			0x5FFFFFFF, // _MAX
> 			0x0, // _TRA
> 			0x00000000) // _LEN
> 	})
> 	}
> }
> 
> Device (PCI1) { // PCI Root Bridge
> 	Name (_HID, EISAID("PNP0A03"))
> 	Name (_UID, 0)
> 	Name (_BBN, 0x00)
> 	Name (_SEG, 0x01) // assign segment 1 of module device to PCI1
> 	Name (_CRS, ResourceTemplate () {
> 		WordBusNumber (
> 			ResourceProducer,
> 			MinFixed, //
> 			MaxFixed,, //
> 			0x00, //
> 			0x00, //
> 			0x7F, //
> 			0x0, //
> 			0x80) //
> 		WordIO (
> 			ResourceProducer,
> 			MinFixed, //
> 			MaxFixed, //
> 			0x0000, //
> 			0x0D00, //
> 			0x7FFF, //
> 			0x0, //
> 			0x7300) //
> 		DWordMemory (
> 			ResourceProducer,
> 			MinNotFixed,
> 			MaxNotFixed,
> 			NonCacheable,
> 			ReadWrite,
> 			0x0FFFFFFF,
> 			0x60000000,
> 			0x7FFFFFFF,
> 			0x0,
> 			0x00000000)
> 	})
> 	}
> }
> 
> We can see there are two PCI Root Bridge, and each has its own _CRS
> field. And each field has its own busnumber/iores/memios.
> 
> So, in the acpi_walk_resources() function, how to find the proper _CRS
> infomation for a root device?
> 

