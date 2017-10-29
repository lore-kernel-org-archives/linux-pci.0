Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38335 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdJ2GQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 02:16:50 -0400
Date: Sat, 28 Oct 2017 23:16:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Cc: "Wang, Liang-min" <liang-min.wang@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
Message-ID: <20171029061646.GA28105@infradead.org>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
 <20171024234351.0af0ff4a@t450s.home>
 <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
 <20171025000654.7621b84e@t450s.home>
 <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
 <20171028001907.7b8fa60d@t450s.home>
 <1509146439.11655.60.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509146439.11655.60.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 27, 2017 at 11:20:41PM +0000, Duyck, Alexander H wrote:
> I don't see this so much as a security problem per-se. It all depends
> on the hardware setup. If I recall correctly, there are devices where
> the PF function doesn't really do much other than act as a bit more
> heavy-weight VF, and the actual logic is handled by a firmware engine
> on the device.

Can you cite an example?  While those surely could exist in theory,
I can't think of a practical example.

Maybe we can start with the practical use case for this patch.  That
is what device is this intended for?
