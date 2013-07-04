Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:36732 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab3GDBP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2013 21:15:27 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 4 Jul 2013 06:40:09 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 64F073940043
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2013 06:45:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r641FIaD27590674
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 06:45:18 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r641FLPF027691
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 11:15:21 +1000
Date: Thu, 4 Jul 2013 09:15:20 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH 0/4] optimization/fix/cleanup in
 pci_assign_unassigned_resources
Message-ID: <20130704011520.GA7554@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

Any comment on these patch set is welcome~

Not sure those are reasonable or not?

On Mon, Jul 01, 2013 at 11:10:28PM +0800, Wei Yang wrote:
>Here is some patches do the optimization/fix/cleanup for the function
>pci_assign_unassigned_resources().
>
>Wei Yang (4):
>  PCI: optimize pci_bus_get_depth() by enumerating on pci bus hierachy
>  PCI: add comment for pbus_size_mem() parameter
>  PCI: trivial cleanup in pbus_size_io()
>  PCI: fix the io resource alignment calculation in pbus_size_io()
>
> drivers/pci/setup-bus.c |   56 +++++++++++++++++++++++++++++++++++-----------
> 1 files changed, 42 insertions(+), 14 deletions(-)
>
>-- 
>1.7.5.4

-- 
Richard Yang
Help you, Help me

