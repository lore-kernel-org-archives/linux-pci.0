Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33914 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbKMVZ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2015 16:25:29 -0500
Date: Fri, 13 Nov 2015 16:24:42 -0500 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 1/6] msi: Relax msi_domain_alloc() to support parentless
 MSI irqdomains
In-Reply-To: <1447435057-5212-2-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1511131623530.3987@nanos>
References: <1447435057-5212-1-git-send-email-keith.busch@intel.com> <1447435057-5212-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 13 Nov 2015, Keith Busch wrote:

> From: Liu Jiang <jiang.liu@linux.intel.com>
> 
> Previously msi_domain_alloc() assumes MSI irqdomains always have parent
> irqdomains, but that's not true for the new Intel VMD devices. So relax
> msi_domain_alloc() to support parentless MSI irqdomains.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Tested-by: Keith Busch <keith.busch@intel.com>

Just for the record. This still misses your S-O-B as you are conveying
the patch

Thanks,

	tglx
