Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:34682 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab2DAIir (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Apr 2012 04:38:47 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sun, 1 Apr 2012 14:08:40 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q318cbCl4366568
	for <linux-pci@vger.kernel.org>; Sun, 1 Apr 2012 14:08:38 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q31E8Q1O001562
	for <linux-pci@vger.kernel.org>; Mon, 2 Apr 2012 00:08:26 +1000
Received: from localhost ([9.123.247.55])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q31E8Prm001544
	for <linux-pci@vger.kernel.org>; Mon, 2 Apr 2012 00:08:25 +1000
Date: Sun, 1 Apr 2012 16:38:35 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: What is the difference between number and secondary in pci_bus?
Message-ID: <20120401083835.GA23662@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All

In the structure of pci_bus.
There is number, primary, secondary and subordinate.

primary and subordinate are easy to understand, while the number and
secondary confused me. 

I think secondary means the current bus number.
Then what number stands for?

In pci_alloc_child_bus(), 
child->number = child->secondary = busnr;
So they are the same? 
Then we need two different field?

I search the git log while find these code is imported as the first
commit. So I don't see the history.

-- 
Richard Yang
Help you, Help me

