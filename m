Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50955 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbaFXO01 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 10:26:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s5OEQRsN019197
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 09:26:27 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s5OEQRkD003147
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 09:26:27 -0500
Received: from [158.218.104.189] (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s5OEQP89008668	for
 <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 09:26:26 -0500
Message-ID: <53A98A95.2030401@ti.com>
Date: Tue, 24 Jun 2014 10:26:29 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
Subject: SATA AHCI controller detection during PCI enumeration
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

I have a board with PCI controller connected to a Marvell AHCI 
controller, 88SE9182 connected to a PCIe bus and the PCI scan doesn't 
show up the SATA end point. My question is in order to detect the EP,
is it expected to have a hard drive connected to the SATA port?
Currently with and without the SATA connected, the PCI scan doesn't
show up the device. Also is there any other requirements at the
hardware level to detect this SATA controller.

Thanks in advance for your reply.

Murali
