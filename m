Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:35752 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbbBJA0V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 19:26:21 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Tue, 10 Feb 2015 10:26:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 32FAA2CE804E
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:26:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A0Q6hm49152030
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:26:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A0Pf3N022663
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 11:25:41 +1100
Message-ID: <1423527917.4924.66.camel@au1.ibm.com>
Subject: Re: [PATCH V11 00/17] Enable SRIOV on Power8
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Feb 2015 11:25:17 +1100
In-Reply-To: <20150204234442.GC20072@google.com>
References: <20150113180502.GC2776@google.com>
	 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20150204234442.GC20072@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-02-04 at 17:44 -0600, Bjorn Helgaas wrote:
> Ben, I know you chimed in earlier to help explain PEs.  Are you or
> another powerpc maintainer planning to ack all this?

I'll get through it in the next day or so.

Cheers,
Ben.


