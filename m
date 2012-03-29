Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:52701 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2C2GMd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2012 02:12:33 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 29 Mar 2012 11:42:27 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2T6CMMH4526232
	for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2012 11:42:24 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2TBgAUe017854
	for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2012 22:42:10 +1100
Date: Thu, 29 Mar 2012 14:12:20 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: How acpi_walk_resources() find specific _CRS for one device
Message-ID: <20120329061219.GB9782@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120328093004.GA31647@richard>
 <4F731005.6000506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F731005.6000506@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2012 at 09:20:05PM +0800, Jiang Liu wrote:
>On 03/28/2012 05:30 PM, Richard Yang wrote:
>> Experts
>> 
>> I am reading the PCI enumeration code on x86. One thing on ACPI
>> namespace puzzles me.
>> 
>> In the initialize process, the call flow is like this
>> acpi_pci_root_add()
>> 	try_get_root_bridge_busnr()
>> 		acpi_walk_resources(handle, METHOD_NAME__CRS,
>> 		         get_root_bridge_busnr_callback, res)
>This piece of code is to invoke ACPI method "_CRS" for "handle", and call
>get_root_bridge_busnr_callback for each resource descriptor returned by
>this method.
>Here "handle" is the object for the pci root bus or PCI host bridge.
>"_CRS" is the name of ACPI method, which exists under "handle".
>
>> 
Thanks for your clarification.

I read the acpi code again. And found the namespace tree is created in
acpi_scan_init()
{
	...
	result = acpi_bus_scan(ACPI_ROOT_OBJECT, &ops, &acpi_root);
	...
}

And then call the acpi_walk_namespace() to go through the whole
namespace. Am I right? And form those handles

I look at the SPEC and code again and find the namespace is loaded
by acpi_ns_load_namespace() right?

It will read DSDT/SSDT/PSDT by calling acpi_ns_load_table_by_type. 

While I grep the whole source code, but not find the definition of this
function. 
-- 
Richard Yang
Help you, Help me

