Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22122 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759955AbcAKUtN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 15:49:13 -0500
Date: Mon, 11 Jan 2016 20:49:11 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv7 0/6] Driver for new "VMD" device
Message-ID: <20160111204911.GB8743@localhost.localdomain>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
 <20160111170617.GA30780@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160111170617.GA30780@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the catches. Most were simple fixes, and I used your
cleanup suggestions for others. Will resend shortly.

On Mon, Jan 11, 2016 at 11:06:17AM -0600, Bjorn Helgaas wrote:
> Checkpatch complained about a few things that should be easy to fix up:
> 
>   x86-pci-allow-pci-domain
>   -:26: WARNING: struct dma_map_ops should normally be const
>   x86-pci-initial-commit-for-new
>   -:125: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Question on the maintenance: does this new driver file need a maintainer,
or does it fall under arch/x86/pci/ umbrella? I'm happy to supply updates
and/or fixes once this is merged, but I just want to understand who to
direct patches/pull requests to if the need arises.
