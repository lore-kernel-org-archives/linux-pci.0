Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36493 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFAXuC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 19:50:02 -0400
Received: by ieclw1 with SMTP id lw1so26120247iec.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2015 16:50:01 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:49:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150601234958.GG3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
> Current EEH recovery code works with the assumption: the PE has primary
> bus. Unfortunately, that's not true to VF PEs, which generally contains

"Primary bus" normally means the bus on the upstream side of a PCI bridge.
But a PE is not a bridge, so I don't know what it means here.

s/not true to VF PEs/not true for VF PEs/

> one or multiple VFs (for VF group case). The patch creates PEs for VFs
> at PCI final fixup time. Those PEs for VFs are indentified with newly

s/indentified/identified/

> introduced flag EEH_PE_VF so that we handle them differently during
> EEH recovery.
