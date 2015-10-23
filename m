Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:43507 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbbJWIXR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 04:23:17 -0400
Date: Fri, 23 Oct 2015 10:23:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/PCI: Don't alloc pcibios-irq when MSI is enabled
Message-ID: <20151023082314.GW27420@8bytes.org>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
 <20151021162329.GB1583@localhost>
 <56299523.1010201@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56299523.1010201@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 23, 2015 at 10:02:11AM +0800, Jiang Liu wrote:
> 	There's another patch already merged into mainstream kernel,
> which solves this issue in another way by making use of
> pci_dev->match_driver flag. Please refer to:
> cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers to IOMMU PCI
> devices")
> 	So I think this patch is redundant now.

Yeah, it fixes the same problem already fixed by your match_driver fix.
But I think this fix makes still sense as it avoids that the problem can
reappear in the future with other drivers. Setting pci_dev->match_driver
could be easily forgotten when writing new code.


	Joerg

