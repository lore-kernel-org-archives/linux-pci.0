Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:52549 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbbJEKAx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 06:00:53 -0400
Date: Mon, 5 Oct 2015 12:00:52 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, christian.melki@t2data.com,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: Fwd: SWIOTLB on 32-bit PAE.
Message-ID: <20151005100051.GA12506@8bytes.org>
References: <560E9007.1000604@t2data.com>
 <560E92A0.9030707@t2data.com>
 <20151003143630.GB17684@localhost>
 <20151003180007.GA4732@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151003180007.GA4732@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 03, 2015 at 02:00:19PM -0400, Konrad Rzeszutek Wilk wrote:
> Aye. I presume that you had done a small change already for this?
> Would you be willing to post it on lkml and CC me ?

Yes, I also think it is needed. SWIOTLB already correctly handles
buffers in HighMem, so enabling it for 32-bit PAE should be easy. Please
also CC me on the patch.


	Joerg

