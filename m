Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46690 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbcHHTt0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 15:49:26 -0400
Date: Mon, 8 Aug 2016 14:49:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/16] PCI: Fixup for 64bit resource with sparc
Message-ID: <20160808194921.GA6129@localhost>
References: <20160618022501.15648-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160618022501.15648-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 07:24:45PM -0700, Yinghai Lu wrote:
> Hi Bjorn,
> 
> After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
> to 64-bit resources), we have several reports on resource allocation
> failure, and we try to fix the problem with resource clip, and find
> more problems.
> 
> One is from sparc that have problem with clip as we don't parse
> mem64 for it.
> 
> This patchset try to fix the problem for sparc.
> 
> patch 1-3: try to fix the pci mmap for proc path for sparc, that will
> make fix for sparc 64bit resource offset handling much simple.
> 
> patch 4-11: parse MEM64 for sparc and other system with OF.
> So device 64bit resource could find their parent resource.
> 
> patch 12-15: MMIO64 handling enhancement
>         treat non-pref mmio64 if parent bridges are all pcie.
> 
> patch 16: restore old pref allocation logic if hostbridge does not support mmio64.
> 
> Khalid Aziz tested on some sparc platforms that have different offset to
> mem space start or support 64bit mmio.
> 
> -v13: update patchset with pci/resource that have pci_resource_to_user
>       changes. date 2016-06-17

Hi Yinghai,

Can you update these to apply to v4.8-rc1, and we can keep chipping
away at these?

Bjorn
