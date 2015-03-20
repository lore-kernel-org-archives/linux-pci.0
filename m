Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:60352 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbCTVaD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 17:30:03 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Sat, 21 Mar 2015 07:30:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id E43403578047
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2015 08:29:57 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2KLTnbn27590786
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2015 08:29:57 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2KLTO2H026377
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2015 08:29:24 +1100
Message-ID: <1426886935.4770.178.camel@au1.ibm.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 21 Mar 2015 08:28:55 +1100
In-Reply-To: <CAErSpo4vsw89bNbzJbqRiW4vy2Vzpmr-3DTdnUEhzUMPLUTn+g@mail.gmail.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20150320054327.GA8119@shangw>
	 <CAErSpo6zTLyDK+aaHK6+uwfs579Qq1vbXDx4rb9L4uNq=24dVA@mail.gmail.com>
	 <1426885502.4770.159.camel@au1.ibm.com>
	 <CAErSpo4vsw89bNbzJbqRiW4vy2Vzpmr-3DTdnUEhzUMPLUTn+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-03-20 at 16:16 -0500, Bjorn Helgaas wrote:
> 
> > The other option is you put the generic changes in a topic branch
> which
> > both of us merge and I take care of the rest.
> 
> Yeah, I chatted with Wei this morning, and he reminded me that there's
> really not very much drivers/pci content there.  So I think I can just
> ack those bits and you can take the whole thing.  I noticed some
> changelog typos I'll point out, then I'll be done.

Excellent, thanks.

Cheers,
Ben.


