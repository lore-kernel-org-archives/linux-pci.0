Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:44488 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbaANIww (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 03:52:52 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 18:52:50 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2381F2CE8051
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 19:52:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0E8qYpd9437600
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 19:52:35 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0E8qkVr007974
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 19:52:47 +1100
Date: Tue, 14 Jan 2014 16:52:44 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Or Gerlitz <ogerlitz@mellanox.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	yinghai@kernel.org, bhelgaas@google.com, amirv@mellanox.com,
	jackm@dev.mellanox.co.il, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114085244.GA27684@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140114062215.GA19345@richard>
 <52D4ED5D.80105@mellanox.com>
 <20140114082749.GA21105@richard>
 <52D4F7C8.50706@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D4F7C8.50706@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 10:39:36AM +0200, Or Gerlitz wrote:
>On 14/01/2014 10:27, Wei Yang wrote:
>>You can find the first three patches here:
>>https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/  pci/resource
>>
>>And the last one is here:
>>https://lkml.org/lkml/2013/12/19/701

This one introduced the "problem" at my side.

>can you be more specific which is  the patch that introduced the
>regression, e.g if you apply them one by one, when things break?
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

