Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34947 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbGNV5m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 17:57:42 -0400
Received: by obbop1 with SMTP id op1so14824393obb.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 14:57:41 -0700 (PDT)
Date: Tue, 14 Jul 2015 16:57:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/4] PCI: move PCI_FIND_CAP_TTL to pci.h and use it in
 quirks
Message-ID: <20150714215737.GK24416@google.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1435627004-6029-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435627004-6029-2-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 30, 2015 at 09:16:41AM +0800, Wei Yang wrote:
> In some quirks, it tries to search a pci cap and use a ttl value to avoid
> infinite loop. While the value is hard coded to 48, which is the same as
> macro PCI_FIND_CAP_TTL.
> 
> This patch moves the definition of PCI_FIND_CAP_TTL to pci.h and replace
> the hard coded value with it.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Applied to pci/misc for v4.3 with changelog as follows.  Original patch
touched some code that was removed in v4.2, so I adjusted for that, too.

commit 875803b6ef5becdcc2d43b014531279dfaa978af
Author: Wei Yang <weiyang@linux.vnet.ibm.com>
Date:   Tue Jun 30 09:16:41 2015 +0800

    PCI: Move PCI_FIND_CAP_TTL to pci.h and use it in quirks
    
    Some quirks search for a HyperTransport capability and use a hard-coded TTL
    value of 48 to avoid an infinite loop.
    
    Move the definition of PCI_FIND_CAP_TTL to pci.h and use it instead of the
    hard-coded TTL values.
    
    [bhelgaas: changelog]
    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
