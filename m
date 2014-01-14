Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:37476 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaANJRI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 04:17:08 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 14:47:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id C2DDC1258051
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:48:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0E9GwfV54329362
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:46:58 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0E9GwFK018227
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:46:59 +0530
Date: Tue, 14 Jan 2014 17:16:57 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Jack Morgenstein <jackm@dev.mellanox.co.il>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114091657.GC27684@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140114062215.GA19345@richard>
 <20140114105412.16756f4e@jpm-OptiPlex-GX620>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140114105412.16756f4e@jpm-OptiPlex-GX620>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 10:54:12AM +0200, Jack Morgenstein wrote:
>Hi,
>In addition, I would like to know if you have enabled SRIOV in the
>driver.

I have disabled SR-IOV cap in order to focus on the exact problem.

>
>Please provide the output of the console command below.
>
>grep "mlx4_core" /etc/modprobe.d/*.conf

Output like below:

[root@tian-lp1 lib]# grep "mlx4_core" /etc/modprobe.d/*.conf
[root@tian-lp1 lib]#

>
>
>Thanks.
>
>-Jack

-- 
Richard Yang
Help you, Help me

