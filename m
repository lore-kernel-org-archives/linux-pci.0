Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 12 Aug 2015 16:52:12 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Sean O. Stalley" <sean.stalley@intel.com>
cc: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz, akpm@linux-foundation.org, bigeasy@linutronix.de,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 1/4] mm: Add support for __GFP_ZERO flag to
 dma_pool_alloc()
In-Reply-To: <1438371404-3219-2-git-send-email-sean.stalley@intel.com>
Message-ID: <alpine.DEB.2.10.1508121649310.30617@chino.kir.corp.google.com>
References: <1438371404-3219-1-git-send-email-sean.stalley@intel.com> <1438371404-3219-2-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 31 Jul 2015, Sean O. Stalley wrote:

> Currently the __GFP_ZERO flag is ignored by dma_pool_alloc().
> Make dma_pool_alloc() zero the memory if this flag is set.
> 
> Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>

Acked-by: David Rientjes <rientjes@google.com>

This has impacted us as well, and I'm glad to see it fixed.
