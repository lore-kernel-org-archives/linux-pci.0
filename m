Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33551 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbGNVhn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 17:37:43 -0400
Received: by oige126 with SMTP id e126so15803434oig.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 14:37:42 -0700 (PDT)
Date: Tue, 14 Jul 2015 16:37:38 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/4] PCI: code clean up on pci configuration space
Message-ID: <20150714213738.GJ24416@google.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 30, 2015 at 09:16:40AM +0800, Wei Yang wrote:
> This series is a clean up in the pci subsystem when accessing the pci
> configuration space.
> 
> The first one is to re-use the PCI_FIND_CAP_TTL to limit the times iterating
> in pci configuration space.
> 
> The next three are to use the exact type to access the pci cap and pcie ext
> cap.
> 
> Tested on x86 and powerpc on top of v4.1.
> 
> The original thread could be referenced in below link:
> http://comments.gmane.org/gmane.linux.kernel.pci/35931
> 
> ---
> v1->v2:
>    * define PCI_FIND_CAP_TTL in drivers/pci/pci.h instead of
>      include/linux/pci.h
>    * split the change for return position check from second one, and make the
>      forth patch
> 
> Wei Yang (4):
>   PCI: move PCI_FIND_CAP_TTL to pci.h and use it in quirks
>   PCI: use u8 to represent pci configuration space pos and cap
>   PCI: use u16 to represent pci express extended capabilities pos and
>     cap
>   PCI: consolidate return value check for pci_find_(ext_)capability

The first and last seem fine to me.  As far as I can tell, the last does
not actually depend on the u8 and u16 changes.

The u8 and u16 patches change the signatures of several exported functions.
Do they fix some problem?  Unless there's something broken, these seem like
pretty minor changes, and I don't think they're worth it.

Bjorn
