Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:47128 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2D0J1a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 05:27:30 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 27 Apr 2012 14:57:27 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3R9R6vC26607794
	for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 14:57:07 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3REviFf012989
	for <linux-pci@vger.kernel.org>; Sat, 28 Apr 2012 00:57:44 +1000
Date: Fri, 27 Apr 2012 17:27:04 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com
Subject: Does my understanding correct?
Message-ID: <20120427092704.GA22529@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All, 

I draw a picture about the physical layout on a part of the pci system.

Each block represent a bridge or a device.
Am I correct?
   
    +-----------------------------+
    |                             |
    |                             |
    |      Bus#2                  |
    |   ------------------        |
    |                             |
    |                             |
    |                             |
    |               +-------------+
    |               |DownStream   |02:00.0 pci_dev
    +---------------+-------+-----+
                            |   Bus#3
             ---------------+------------------------------------------+---
                            |                                          |
                            |                                          |
    +---------------+-------+-----+               +---------------+----+--+-----+
    |               |UpStream     |03:00.0        |               |UpStream     |03:01.0
    |               +-------------+               |               +-------------+ a normal device
    |                             |               |                             |
    |                             |               |                             |
    |             Bus#4           |               |                             |
    |     -------------------     |               |                             |
    |                  +----------+               |                             |
    |                  |DownStream|               |                             | 
    +-----------------------+-----+               +-----------------------------+                       
                            |                                                 
                            | Bus#5                               
                ------------+------------                                                               


-- 
Richard Yang
Help you, Help me

