Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1321976497.6971.6.camel@i7.infradead.org>
Subject: Re: [PATCH] intel-iommu: Manage iommu_coherency globally
From: David Woodhouse <dwmw2@infradead.org>
To: cody <mail.kai.huang@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	rajesh.sankaran@intel.com, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrisw@sous-sol.org, ddutile@redhat.com
Date: Tue, 22 Nov 2011 15:41:37 +0000
In-Reply-To: <4ECCA102.4040501@gmail.com>
References: <20111116040752.11878.18642.stgit@bling.home>
	 <1321617817.15493.33.camel@shinybook.infradead.org>
	 <4ECCA102.4040501@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2011-11-22 at 23:30 -0800, cody wrote:
> I have a question, Intel VT-d manual says the coherency bit is "RO", how 
> can it be configurable by the BIOS? Or there's another way to configure 
> the IOMMU to be coherent or non-coherent? (I didn't find such info in 
> the manual. I missed it?) 

It's not in the manual. We hide it so that only the BIOS can set it.
It's only read-only to *you*, the operating system that's supposed to
have control of the hardware.

You might think that we should expose it to the OS so that it can be set
according to the *usage* — so perhaps you'd set it non-coherent for VM
use (where you rarely modify the page tables) and coherent for
host-based DMA protection (where the constant clflushes in the fast path
cause a 10% performance hit on network bandwidth testing).

However, that would not be consistent with our goal of ensuring that the
BIOS can *always* screw you over as much as possible.

-- 
dwmw2

