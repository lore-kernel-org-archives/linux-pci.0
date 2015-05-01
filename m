Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41734 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbbEAJPH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 May 2015 05:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1Yo72F-0003C5-1C
	for linux-pci@vger.kernel.org; Fri, 01 May 2015 11:15:03 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2015 11:15:03 +0200
Received: from bharat.eldorado by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2015 11:15:03 +0200
To: linux-pci@vger.kernel.org
From: bharat <bharat.eldorado@gmail.com>
Subject: address cell and size cells parameter in PCIE
Date: Fri, 1 May 2015 09:09:03 +0000 (UTC)
Message-ID: <loom.20150501T110225-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HI I have a confusion regarding address cell and size cell values for pci
node in device tree. Is it compulsary that address cell value is 3 and size
cell value is 2 for PCIE.
On what basis the values of address cell and size cell should be assigned.



