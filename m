Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:40031 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbGOCDB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 22:03:01 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 15 Jul 2015 12:02:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EDD92CE8052
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 12:02:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F22mpe48955520
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 12:02:56 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F22Nhf026001
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 12:02:24 +1000
Date: Wed, 15 Jul 2015 10:02:06 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 4/4] PCI: consolidate return value check for
 pci_find_(ext_)capability
Message-ID: <20150715020206.GC6525@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1435627004-6029-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150714220021.GL24416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714220021.GL24416@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 05:00:21PM -0500, Bjorn Helgaas wrote:
>On Tue, Jun 30, 2015 at 09:16:44AM +0800, Wei Yang wrote:
>> The return value of the pci_find_(ext_)capability is the position of this
>> Cap.  After previous two patches clean up, the position returned is an
>> unsigned value. Only 0 indicates the Cap is not presented.
>> 
>> This patch consolidates the form of check from (pos <= 0)to (!pos).
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Applied to pci/misc with changelog as below.
>
>It seems pretty clear to me that pci_find_capability() returns either 0 or
>a u8 value.  pci_find_ext_capability() does return an int.  It looks to me
>like it can never be negative, but if you wanted it to be even more clear,
>you could easily change just pci_find_next_ext_capability() to use a u16
>for "pos".  That would be very simple and wouldn't change any interfaces.

pci_find_capability() will return either 0 or a u8 value, while in the code
the return value is an "int" type. So for the first sight, it may not that
immediate. The same as pci_find_ext_capability().

This is the reason for patch 2/3. The purpose is to make the return type
reflect the value it will return.

Patch 3 does exactly what you said, use a u16 for "pos" in
pci_find_next_ext_capability().

>
>commit d5fa86074987b1b5fcbfba8c9315e75ff7262f71
>Author: Wei Yang <weiyang@linux.vnet.ibm.com>
>Date:   Tue Jun 30 09:16:44 2015 +0800
>
>    PCI: Simplify pci_find_(ext_)capability() return value checks
>    
>    The return value of the pci_find_(ext_)capability() is either zero or the
>    position of a capability.  It is never negative.
>    
>    This patch consolidates the form of check from (pos <= 0) to (!pos).
>    
>    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

-- 
Richard Yang
Help you, Help me

