Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49395 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbbGPNOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jul 2015 09:14:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZFizR-00088U-Mr
	for linux-pci@vger.kernel.org; Thu, 16 Jul 2015 15:14:18 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2015 15:14:17 +0200
Received: from bharat.eldorado by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2015 15:14:17 +0200
To: linux-pci@vger.kernel.org
From: Bharat Kumar Gogada <bharat.eldorado@gmail.com>
Subject: Pin and MSI interrupt handling arm64
Date: Thu, 16 Jul 2015 13:14:02 +0000 (UTC)
Message-ID: <loom.20150716T141846-338@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In arm hw_pci->map_irq is used to map irq number, and struct msi_chip 
containing details of setup_irq and teardown_irq is assigned to msi_chip in 
struct pci_bus in using hw_pci->add_bus. 

How PIN and MSI interrupt details are being handled/assigned by pci subsystem 
in arm64, since struct hw_pci is absent in arm64.

Regards
Bharat

