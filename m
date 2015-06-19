Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54617 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbbFSFpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Jun 2015 01:45:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1Z5p6u-0004TK-CN
	for linux-pci@vger.kernel.org; Fri, 19 Jun 2015 07:45:05 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 07:45:04 +0200
Received: from rgummal by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 07:45:04 +0200
To: linux-pci@vger.kernel.org
From: ravikiran gummaluri <rgummal@xilinx.com>
Subject: PCIe support for ARM64
Date: Fri, 19 Jun 2015 05:43:00 +0000 (UTC)
Message-ID: <loom.20150619T074145-299@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HI

I am developing PCIe root port driver for Xilinx device. We have used 
following patch for ARM64 bit support 
"https://lkml.org/lkml/2014/7/3/764". The link explains it as temporary 
patch and main line will be updated soon with those changes. We have not 
seen the changes till now. Can you let us know when we can expect the 
changes in mainline? We are planning to push our drivers to mainline.

Thanks & Regards
Ravikiran


