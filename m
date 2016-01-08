Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60713 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcAHJr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2016 04:47:58 -0500
Date: Fri, 8 Jan 2016 10:47:01 +0100 (CET)
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
Subject: Re: [PATCHv7 0/6] Driver for new "VMD" device
In-Reply-To: <20160106200339.GA21311@localhost.localdomain>
Message-ID: <alpine.DEB.2.11.1601081045300.3575@nanos>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com> <20160106200339.GA21311@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 6 Jan 2016, Keith Busch wrote:

> Hi all,
> 
> I very much appreciate all the feedback received. I dropped the
> controversial PCI parts and the user space pci-utils from this series,
> and I think satisfied all the requests I am aware of. Is there anything
> else preventing a 4.5 inclusion?

>From my side (the interrupt related parts) no objections. The rest needs to be
decided by Bjorn.

Thanks,

	tglx


