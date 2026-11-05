Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905763;
	b=q0d6+r20a1Clsz68xe37uaUTY935xLXPFe5rO87hsyVGXnkdQxwZAzusG1MtymQof3yU
	 PcFQPl/qQxksLKEIF/YbMrq9lrQbrLqlGIhusldWkysBsePO2DgE1paQFaSrCplKaoFQI
	 4jLfKax1E++J0MDu4isrXu9I4ZYYCog+KwzfFkRIjhHDjsNt+FeplpJXdGrAMJoBKWTXz
	 JJ7pnfswzmE4TodLhjPfF0HcZ1N/9t7+VNG7dOeW3J7d8S20lx798w9qAGlhcgiDNhJxu
	 sxFr6O+mbYjerwsj7rsp6fOa8ACTTO+1I3TccfoFm4rfqhc334Fwns4ipF2H56IflLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905763;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S3C4PF2NhTXtOwd86DNKzdZ6H+3X/Jp2dMuy9ZXfI48=;
	b=M7jq+aPbFj1uUnwQA1LUCFUJMc/Pi7S7qR5OODKbifZo6QDGx9T23Q4Ymw+Zm4zl1xFX
	 Bk+HaL9rNchG+GygIkQbJdUiQfOLvgr2TZvHwgVRNt18ACgMuySYC9z90Mm9gMDxI5y1u
	 TPotns0kvk4YnJqQWDH29ftRyWH7mMHJ8fVxLaiizyD8B9455+BHdG7bMTkG4Dc/4/gvC
	 iXxybWZEhUkT/pz2i5kcyQhaf8EkZcaJuxoEaXQ+V1gjEv0KdW3MTQG2SRxlxp/CxYbPN
	 ju5xXIj52Wz50DD4xQSlHQSOWEOHo0oFH++Mq88tg5ybaOUJwS5yf+SFKbv+tZG9KqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPykGLk2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D2606A31B;
	Thu,  5 Nov 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPykGLk2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42501F000C1;
	Thu,  5 Nov 2026 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905763;
	bh=S3C4PF2NhTXtOwd86DNKzdZ6H+3X/Jp2dMuy9ZXfI48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TPykGLk2V8AFxU8ceCJzw5TrdoQQ40JzCPcvUX54d8+j9Xz6RlklXpn2EFGX5sbh/
	 DZaahmDw9RRGrpXt+erL4W+oskf6qSTu5uJXYyxETilBviY33tAUQv3JmHyZvWeFX6
	 k8WOCTmH8RaLNRVrqYO5GcWtkuQzjEzxcJhee97E55jGLecqJ6Q386aodjLomyS1kZ
	 RsTlPtvAtNCOhHg2w79kY/x2o4fetr+Ge5rEdN26ofXGdVxm+FZ4OaSksr4xnWrPCB
	 xaplOh0DkoRI4rmoBcbIfbV6w36egObtDFP6Hz6Emp+ofmwJ/4NbZOBnRloaGgp73U
	 Gwjfk1SvNHFFg==
Date: Thu, 5 Nov 2026 12:09:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <auzUYZxQYkprXuIz@kbusch-mbp>
References: <20261105182706.3700908-1-kbusch@meta.com>
 <20261105182706.3700908-3-kbusch@meta.com>
 <sashiko-outbox-199778@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-199778@kernel.org>

On Thu, Nov 05, 2026 at 06:36:52PM +0000, sashiko-bot@kernel.org wrote:
> When pci_channel_offline(msi_desc_to_pci_dev(desc)) is true, doesn't
> pci_msix_mask() now unconditionally execute readl(desc->pci.mask_base) after
> pci_msix_mask_noflush() returns early?
> 
> Prior to this change, commit 2e2f69fc8ae2 ("PCI/MSI: Skip MSI/MSI-X
> programming while the channel is offline") added the pci_channel_offline()
> check to both pci_msix_write_vector_ctrl() and pci_msix_mask() so that
> pci_msix_mask() would return before the flushing readl(desc->pci.mask_base):
> 
> drivers/pci/msi/msi.h:pci_msix_write_vector_ctrl() {
> 	/* The Table is unreachable while the Link is down */
> 	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
> 		return;
> 	...
> }

Oh right. That check looks fairly recent, and I missed the merge from my
older version resolved this incorrectly. I'll respin it. 
