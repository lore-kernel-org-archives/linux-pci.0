Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37075 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbBJIPz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 03:15:55 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Tue, 10 Feb 2015 18:15:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5F9A12CE8040
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 19:15:49 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A8Feu341222304
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 19:15:49 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A8FFUM006992
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 19:15:15 +1100
Message-ID: <1423556085.4924.91.camel@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Feb 2015 19:14:45 +1100
In-Reply-To: <20150210062544.GB31098@richard>
References: <20150113180502.GC2776@google.com>
	 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1423528584.4924.70.camel@au1.ibm.com> <20150210015123.GC6326@richard>
	 <1423534451.4924.79.camel@au1.ibm.com> <20150210062544.GB31098@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-02-10 at 14:25 +0800, Wei Yang wrote:
> PF's resource will be assigned first, including normal BARs and IOV
> BARs.
> 
> Then PF's driver will create VFs, in virtfn_add(). In this function,
> VF's
> resources is calculated from its PF's IOV BAR.
> 
> If you reset VF's resource as PFs, no one will try to assign it again.

So the problem is that the flag indicating VF is lost ? IE. We should
still mark them unset, but preserve that flag ?

Cheers,
Ben.


