Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51970 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab3JXVq0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2013 17:46:26 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r9OLkQfd005856
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2013 16:46:26 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r9OLkQfK001661
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2013 16:46:26 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Intel e1000e pcie NIC driver issue on RT Linux kernel
Date: Thu, 24 Oct 2013 21:46:25 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B70462535D@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver was downloaded from intel website and uses legacy irq. I am using 1G ethenet switch to connect my PC to the Ethernet port. 

Murali Karicheri
>> -----Original Message-----
>> From: Karicheri, Muralidharan
>> Sent: Thursday, October 24, 2013 5:41 PM
>> To: 'linux-pci-owner@vger.kernel.org'
>> Subject: Intel e1000e pcie NIC driver issue on RT Linux kernel
>> 
>> Hi,
>> 
>> I am having issues with e1000e driver to run on a RT patched Linux kernel. I am using
>> v3.10.10 on our custom platform. The driver works fine on non-RT kernel. When I do iperf,
>> the console is hung. The ping works fine. There is issue when passing higher traffic rate.
>> Anyone has any clue? Anybody tried this driver on a RT patched kernel and has success?
>> 
>> Please respond.
>> 
>> Thanks
>> 
>> Murali Karicheri
>> 
>> 

