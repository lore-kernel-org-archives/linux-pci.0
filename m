Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:58659 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbBXI03 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:26:29 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Tue, 24 Feb 2015 18:26:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 50ED22BB0047
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 19:26:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1O8QEhb22937650
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 19:26:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1O8Pnvc002616
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 19:25:49 +1100
Message-ID: <1424766317.12891.32.camel@au1.ibm.com>
Subject: Re: [PATCH V11 08/17] powrepc/pci: Refactor pci_dn
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 19:25:17 +1100
In-Reply-To: <20150224081330.GE6220@google.com>
References: <20150113180502.GC2776@google.com>
	 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1421288887-7765-9-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20150220231917.GC21131@google.com> <20150223001349.GA7522@shangw>
	 <20150224081330.GE6220@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-02-24 at 02:13 -0600, Bjorn Helgaas wrote:
> 
> Ah, yes, now I see the problem.  I don't really like having to export
> pci_iov_virtfn_bus() and pci_iov_virtfn_devfn(), but it's probably not
> worth the hassle of changing it, and I think adding more pcibios
> interfaces
> would be even worse.

Aren't we going to eventually turn them all into host bridge ops ? :-)

Cheers,
Ben.


