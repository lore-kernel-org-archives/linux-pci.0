Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34000 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbbGUPvq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 11:51:46 -0400
Date: Tue, 21 Jul 2015 17:51:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC Patch V1 00/12] Reorganize struct msi_desc to prepare for
 support of generic MSI
In-Reply-To: <20150721133031.GF16841@google.com>
Message-ID: <alpine.DEB.2.11.1507211749590.18576@nanos>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com> <20150721133031.GF16841@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 21 Jul 2015, Bjorn Helgaas wrote:
> Sergei pointed out typos in the "Use for_pci_msi_entry()" subject and
> changelogs; I assume you'll fix those.

Yes.

> Paul had a question on 09/12 regarding Kconfig, and I didn't see a
> resolution to that.

I'll reply to that right now.

> For the PCI parts:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thomas, I assume you'll take this via your tree.

That's the plan

Thanks,

	tglx
