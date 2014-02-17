Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:36672 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaBQEuQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 16 Feb 2014 23:50:16 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Mon, 17 Feb 2014 10:20:12 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6E51F3940023
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 10:20:08 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1H4o4j026148976
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 10:20:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s1H4o7As024779
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 10:20:07 +0530
Date: Mon, 17 Feb 2014 12:50:04 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Support huge alignment in pbus_size_mem()
Message-ID: <20140217045004.GB3230@yanx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pbus_size_mem() limits resource alignment within 2G. We want to extend
this limit to support a 16G BAR. I found similar effort was tried before:

	https://lkml.org/lkml/2012/6/21/411

What's the result? Does anyone come up with an adaptive algorithm?

Regards,
Guo Chao

