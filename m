Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38298 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbCTVUt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 17:20:49 -0400
Received: by igbqf9 with SMTP id qf9so2437693igb.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:20:48 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:20:45 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
Message-ID: <20150320212045.GL26935@google.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:
> This patchset enables the SRIOV on POWER8.
> 
> The general idea is put each VF into one individual PE and allocate required
> resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
> allocation and adjustment for PF's IOV BAR.
> 
> On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
> sit in its own PE. This gives more flexiblity, while at the mean time it
> brings on some restrictions on the PF's IOV BAR size and alignment.

For patches 03-12 (the "PCI: " ones):

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It's fine if you want to take all these via the powerpc tree.  I don't see
much if anything in my queue that will conflict with them.

Bjorn
