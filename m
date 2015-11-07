Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35160 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbbKGLoM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Nov 2015 06:44:12 -0500
Date: Sat, 7 Nov 2015 12:43:25 +0100 (CET)
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
Subject: Re: [PATCHv4 1/6] msi: Relax msi_domain_alloc() to support parentless
 MSI irqdomains
In-Reply-To: <1446849346-8242-2-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1511071240260.4032@nanos>
References: <1446849346-8242-1-git-send-email-keith.busch@intel.com> <1446849346-8242-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 6 Nov 2015, Keith Busch wrote:
> From: Liu Jiang <jiang.liu@linux.intel.com>
... 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>

Hehehe. Let me read that from/sob chain:

Liu wrote the patch and then handed it over to Jiang who sent it back
to Liu and Liu sent it to Keith.

Now what's missing is the SOB from Keith to make that chain perfect

Other than that, this is the right solution.

Thanks,

	tglx
