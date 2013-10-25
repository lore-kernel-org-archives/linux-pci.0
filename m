Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mouse.start.ca ([64.140.120.56]:50269 "EHLO mouse.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab3JYCXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Oct 2013 22:23:34 -0400
Message-ID: <5269D61A.80602@start.ca>
Date: Thu, 24 Oct 2013 22:23:22 -0400
From: Mark Lord <kernel@start.ca>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>, Tejun Heo <tj@kernel.org>
CC: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Laight <David.Laight@ACULAB.COM>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v2 12/29] PCI/MSI: Introduce pcim_enable_msi*() family
 helpers
References: <cover.1382103786.git.agordeev@redhat.com> <6bc575621ef70f72b206e4aa944acd32f1a75718.1382103786.git.agordeev@redhat.com> <20131024105158.GB13159@mtj.dyndns.org> <20131024143108.GB26610@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20131024143108.GB26610@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13-10-24 10:31 AM, Alexander Gordeev wrote:
> On Thu, Oct 24, 2013 at 11:51:58AM +0100, Tejun Heo wrote:
>> I haven't looked into any details but, if the above works for most use
>> cases, it looks really good to me.
> 
> Well, if we reuse Michael's statistics:
> 
>  - 58 drivers call pci_enable_msix()
>  - 24 try a single allocation and then fallback to MSI/LSI
>  - 19 use the loop style allocation
>  - 14 try an allocation, and if it fails retry once
> 
> ...then I expect most of 19/58 (loop style) could be converted to
> pcim_enable_msix() and pcim_enable_msix_range() and all of 14/58
> (single fallback) should be converted to pcim_enable_msix() users.

Those are just the in-kernel drivers.
There are many, many more out-of-kernel drivers for embedded platforms,
hardware in-development, etc..

Let's not be overly presumptive about the size of the user base.

Cheers
