Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDLQJd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 12:09:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id u3CG9Rdo024774
	for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 11:09:27 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3CG9QvH016664
	for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 11:09:27 -0500
Received: from [158.218.103.0] (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3CG9Q0w013188	for
 <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 11:09:26 -0500
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Subject: PCI Endpoint device running Linux?
Message-ID: <570D1DC7.6040001@ti.com>
Date: Tue, 12 Apr 2016 12:09:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Has anyone wrote EP software for PCI h/w running Linux and
would like to share your experience? If so, please continue
to read below and provide your feedback.

Some of the PCI h/w such as Designware h/w that I work with 
support both EP and RC functions in the same h/w. It needs to be
configured to work in one of the mode. So far I have seen only
such h/w work in RC mode such as pcie-designware.c. But I haven't
come across any driver in Linux that implements a EP controller
similar to RC controller. At this point I am trying to do some
research to educate myself on what is required to be implemented
in Linux and what is the available software in PCI subsystem to
support EP controller and EP device function.

To support an EP such as a Ethernet NIC or FPGA, there is a 
firmaware/software in the EP h/w which as a standalone entity does
setup the Link, initialize the PCI h/w, configure its BAR sizes
etc and initialize itself so that it is detectable when RC side
boots up and do the enumeration. In addition, there is PCI device
driver running on RC side that communicates with the EP H/w
to implement a specific PCI device function such as NIC. My focus
is only on the EP side.

>From my understanding, at a high level, EP s/w needs to implement
3 main components similar to RC side.

1. EP Controller. This is what initialize the PCI H/W so that
   it becomes discoverable on a PCIe bus. It initialize the PCI
   h/w, setup PCI bus (SerDes), and make sure PCI Link is up
   and register itself with PCI sub system (assuming PCI in 
   Linux does support EP controller as well). But I don't know,
   if same API such as pci_scan_root_bus(), pci_bus_add_devices()
   etc are used in this case. Comments?

2. PCI Core functions such as resource management, APIs etc.
   For example, multiple functions can be implemented at the EP
   and memory/config resource windows to be allocated and
   managed similar to RC side. PCI core support EP as well??

3. EP PCI device functions. Device drivers for individual PCI
   device function. 

>From a high level, it appears similar to PCI RC side functions.
Is my understanding correct? Does the existing PCI
Core support implementing EP side software on Linux? and if so,
I believe, we need to enhance the existing RC controller to
work as EP and then write a PCI device driver to support the
EP PCI device function to work with RC side device driver.
Comments?

Thanks for reading and awaiting your feedback!
-- 
Murali Karicheri
Linux Kernel, Keystone
