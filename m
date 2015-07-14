Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33582 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbbGNWA0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:00:26 -0400
Received: by oige126 with SMTP id e126so16131034oig.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:00:26 -0700 (PDT)
Date: Tue, 14 Jul 2015 17:00:21 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 4/4] PCI: consolidate return value check for
 pci_find_(ext_)capability
Message-ID: <20150714220021.GL24416@google.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1435627004-6029-5-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435627004-6029-5-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 30, 2015 at 09:16:44AM +0800, Wei Yang wrote:
> The return value of the pci_find_(ext_)capability is the position of this
> Cap.  After previous two patches clean up, the position returned is an
> unsigned value. Only 0 indicates the Cap is not presented.
> 
> This patch consolidates the form of check from (pos <= 0)to (!pos).
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Applied to pci/misc with changelog as below.

It seems pretty clear to me that pci_find_capability() returns either 0 or
a u8 value.  pci_find_ext_capability() does return an int.  It looks to me
like it can never be negative, but if you wanted it to be even more clear,
you could easily change just pci_find_next_ext_capability() to use a u16
for "pos".  That would be very simple and wouldn't change any interfaces.

commit d5fa86074987b1b5fcbfba8c9315e75ff7262f71
Author: Wei Yang <weiyang@linux.vnet.ibm.com>
Date:   Tue Jun 30 09:16:44 2015 +0800

    PCI: Simplify pci_find_(ext_)capability() return value checks
    
    The return value of the pci_find_(ext_)capability() is either zero or the
    position of a capability.  It is never negative.
    
    This patch consolidates the form of check from (pos <= 0) to (!pos).
    
    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
