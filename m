Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48795 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbbLHMPy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 07:15:54 -0500
Date: Tue, 8 Dec 2015 13:15:01 +0100 (CET)
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
Subject: Re: [PATCHv6 0/7] Driver for new "VMD" device
In-Reply-To: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1512081311540.3595@nanos>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 7 Dec 2015, Keith Busch wrote:

So this looks really good now (at least the irq related parts).

Bjorn, how should we handle this?

I can take it all through tip or just apply the irq/msi related parts
and provide you a branch to pull them from. Either way is fine.

Thanks,

	tglx
