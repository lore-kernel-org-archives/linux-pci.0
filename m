Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45702 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbcGCGk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 3 Jul 2016 02:40:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1bJb4k-0004Ep-Bm
	for linux-pci@vger.kernel.org; Sun, 03 Jul 2016 08:40:24 +0200
Received: from 124.123.186.244 ([124.123.186.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 03 Jul 2016 08:40:18 +0200
Received: from valmikibow by 124.123.186.244 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 03 Jul 2016 08:40:18 +0200
To: linux-pci@vger.kernel.org
From: valmiki <valmikibow@gmail.com>
Subject: Performance mesaurement over pcie inconsistent
Date: Sun, 3 Jul 2016 06:40:12 +0000 (UTC)
Message-ID: <loom.20160703T083028-741@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Im trying to measure DMA performance over pcie. We dont have any counters 
in our hardware which shows per second data rate values. 
I'm trying to measure performance by taking kernel timestamps using 
ktime_get(), but for transferring 'n' bytes data i'm always getting 
inconsistent time difference, im taking timestamps before and after 
transferring data(latter timestamp taken when transfer complete interrupt 
comes). 

Is is good method to measure performance with software timestamps ? 
I need help in what would be better way to measure performance when we 
dont have hardware counters. 

what are the kernel provided better timestamping calls other that 
ktime_get and do_gettimeoftheday, which are more stable ?


Thanks & Regards,
Valmiki     

