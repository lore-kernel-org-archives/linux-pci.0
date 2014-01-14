Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:59042 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbaANJPm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 04:15:42 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 14:45:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 090BEE0056
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:48:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0E9FOmW41025602
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:45:24 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0E9FRCu010782
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:45:28 +0530
Date: Tue, 14 Jan 2014 17:15:25 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Jack Morgenstein <jackm@dev.mellanox.co.il>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114091525.GB27684@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140114062215.GA19345@richard>
 <20140114105031.71882944@jpm-OptiPlex-GX620>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140114105031.71882944@jpm-OptiPlex-GX620>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 10:50:31AM +0200, Jack Morgenstein wrote:
>On Tue, 14 Jan 2014 14:22:15 +0800
>Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>
>> Error log:
>>   mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping
>> PF. mlx4_core: probe of 0003:05:00.0 failed with error -22
>
>1. Please include the full error log starting from host bootup and
>driver start

Will provide one later. 

>
>2. What FW is loaded on the card?

$ mst status
MST modules:
------------
    MST PCI module loaded
    MST PCI configuration module loaded

MST devices:
------------
/dev/mst/mt4099_pciconf0         - PCI configuration cycles access.
                                   domain:bus:dev.fn=0003:05:00.0 addr.reg=88 data.reg=92
                                   Chip revision is: 01
/dev/mst/mt4099_pci_cr0          - PCI direct access.
                                   domain:bus:dev.fn=0003:05:00.0 bar=0x3d0508d300000 size=0x100000
                                   Chip revision is: 01


# mlxburn -d  /dev/mst/mt4099_pci_cr0 -fwver
-I- FW Version: 2.30.3200


>
>3. Please provide output of "lspci -vv -nn" for the Mellanox device(s)

$lspci | grep Mel
0003:05:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
$lspci -s 0003:05:00.0 -n
0003:05:00.0 0280: 15b3:1003

The output with -vvv is attached in the first mail.

-- 
Richard Yang
Help you, Help me

