Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from haybaler.sackheads.org ([140.186.190.103]:60759 "EHLO
	haybaler.sackheads.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3ENP3s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2013 11:29:48 -0400
Received: from localhost (localhost.sackheads.org [127.0.0.1])
	by haybaler.sackheads.org (Postfix) with ESMTP id C10C6285A3
	for <linux-pci@vger.kernel.org>; Tue, 14 May 2013 11:06:23 -0400 (EDT)
Received: from haybaler.sackheads.org ([127.0.0.1])
	by localhost (haybaler.sackheads.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBeWkdAbVsne for <linux-pci@vger.kernel.org>;
	Tue, 14 May 2013 11:06:23 -0400 (EDT)
Date: Tue, 14 May 2013 11:06:23 -0400
From: Jimmie Mayfield <jimmie@sackheads.org>
To: linux-pci@vger.kernel.org
Subject: Seeking advice: Restoring MSI-X after device reset
Message-ID: <20130514150623.GA76670@sackheads.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi.  I'm looking for advice on how a device driver should handle 
restoring MSI-X following a device reset.  Here's my situation: we have an 
MSI-X-capable device that for various reasons might be reset by the
device driver.  One of the features of this device is that a reset also
wipes out the MSI-X structure in MMIO address space.  

So this leads to my question:  what is the recommended way for the driver 
to restore MSI-X following such a reset?  

I suppose one (perhaps naive) way would be to do something like this:
   free all IRQs
   pci_disable_msix();
   reset device
   pci_enable_msix()
   request new IRQs

That seems unclean.  Is there a better way?

JM

