Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:55323 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab2DOOxx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2012 10:53:53 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sun, 15 Apr 2012 15:43:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3FElIlW716926
	for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 00:47:18 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3FErm2J017584
	for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 00:53:49 +1000
Date: Sun, 15 Apr 2012 22:53:45 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] Optimize the resource overlap check
Message-ID: <20120415145345.GA5314@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <1334284128-24925-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20120413094450.GE20495@ram-ThinkPad-T61>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120413094450.GE20495@ram-ThinkPad-T61>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn

Would you mind take a look at this one?

On Fri, Apr 13, 2012 at 05:44:50PM +0800, Ram Pai wrote:
>On Fri, Apr 13, 2012 at 10:28:48AM +0800, Wei Yang wrote:
>> In coalesce_windows() it tries to check whether the res1 and res2 overlap.
>> This function do four comparisons, which could be done with one
>> comparisons.
>> 
>> Also make the resource_check_overlap() a common function for others.
>> 
>> Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Signed-Off-By: Ram Pai <linuxram@us.ibm.com>
>

-- 
Richard Yang
Help you, Help me

