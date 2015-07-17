Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41309 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbGQFpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jul 2015 01:45:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZFySF-000728-Gn
	for linux-pci@vger.kernel.org; Fri, 17 Jul 2015 07:45:04 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 07:45:03 +0200
Received: from bharatku by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 07:45:03 +0200
To: linux-pci@vger.kernel.org
From: Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: legacy interrupt handling in ARM64
Date: Fri, 17 Jul 2015 05:43:11 +0000 (UTC)
Message-ID: <loom.20150717T073409-898@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In arm hw_pci->map_irq is used to map irq number to handle legacy interrupts.

How legacy interrupts are being handled in arm64, since hw_pci structure is 
absent in arm64.

Regards 
Bharat

