Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gateway13.websitewelcome.com ([69.56.150.12]:60820 "EHLO
	gateway13.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939AbaKUUQQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Nov 2014 15:16:16 -0500
Received: from cm1.websitewelcome.com (cm.websitewelcome.com [192.185.0.102])
	by gateway13.websitewelcome.com (Postfix) with ESMTP id 70933B0D602D2
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2014 13:51:31 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 21 Nov 2014 13:51:29 -0600
From: "Dean A." <linux-dev@sensoray.com>
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Hardware error from APEI =?UTF-8?Q?question=3F?=
Message-ID: <b8cf6dca143125ddebd0e4700aac8f13@sensoray.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We're receiving hardware kernel panics on kernel 3.13.  Has anyone seen 
similar hardware errors on the Intel Ivytown/C600 architecture from 
their PCI/PCIe cards?  These errors do not occur with the same card on 
other PCI chipsets (eg. 82G33/P35/P31, ICH9 family, 82801 PCI bridge).


{1} {Hardware Error}: Hardware error from APEI Generic Hardware Error 
Source: 32993
{1} {Hardware Error}: event severity: fatal
{1} {Hardware Error}:  Error 0, type: fatal
{1} {Hardware Error}:   section_type: PCIe error
{1} {Hardware Error}:   port_type: 1, legacy PCI end point
{1} {Hardware Error}:   version: 1.0
{1} {Hardware Error}:   command: 0x0007, status: 0x0018
{1} {Hardware Error}:   device_id: 0000:06:00.0
{1} {Hardware Error}:   slot: 7
{1} {Hardware Error}:   secondary_bus: 0x00
{1} {Hardware Error}:   vendor_id: 0x1797, device_id: 0x6869
{1} {Hardware Error}:   class_code: 000000
Kernel panic - not syncing: Fatal hardware error!
Shutting down cpus with NMI
Rebooting in 30 seconds

