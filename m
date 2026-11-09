Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244747;
	b=ILMMHZYvbBIeFWOSmsU6WKW7yAuKzHNB046h3wCUWo5GDPDx/q6emUTp2z7Fjk7aQina
	 8kZqJuS86lfrGWU7WHJGhh3XN08OSkD42KJCJyNNkJweU6PyDK1NoqI/XQG+DbuX0E7cc
	 BqXgfLjSmBPSWsHJ2oDIT9wvoI9zi3QVZxPyG8bAOkljReG6TwCH9KnwiWfwr4fg+iY3S
	 D17SpjW3Y9r7JGn7ivJfqHIYr9ZMf2a7f6dWzvNhcsy1ABh388bP1oG490iFEufalBd+g
	 FW9Hi2QRwqUd19G6BuLSzeFxue8pzAYDTMLicOlN/z6koRtli3Za7gr26pjUeznJIOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244747;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9zc9z0VlxaYjrpGQo9tZiPXiqIXZzYu9pB5jlY22bI8=;
	b=iyMzOaf8du4iSHk6vhG/1TsYUFVAi+emY84WSm1ErE3/S5U+hgMbwIfOoz02griqcVi3
	 hfMLfL63FY5TNANbVlfndGc8KzDUQA4kKzQmh3YYJQ+6SAMSYApByHeixZon+euuqt4L1
	 6nFlTHLlcDrhsmPRb4kGhfvzuabKi8+m59K90PsVAW02kcVK7ouKNsr7pjLbGBd+SbMxZ
	 qUmAkzkS/L8Lx1ielLHeg3nf9lDWbybtCsvUIou6DBqowqPqmTL6Kg/6YE7Johp/9NG71
	 CC4w6kflLN5BPojAaYm4XCbT4f5AvVvAKdl2iOzrKaXiKThcOygf2IpmRVcxWlM2lfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbkqZI3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827E606A326;
	Mon,  9 Nov 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbkqZI3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BA21F008A1;
	Mon,  9 Nov 2026 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794244746;
	bh=9zc9z0VlxaYjrpGQo9tZiPXiqIXZzYu9pB5jlY22bI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LbkqZI3GEXIML9TEO4qq2+RlToRjwi3Iv0YqJjwc7U84BpU8rndt7PTEPMvHMwCwB
	 E1WAhdfHZL1WHJ1PV4Mv1sVwusz+9NHfjHiRQfffl2JtvXVm4LiyoEZC04QGyBscm8
	 3whlLstdPNAlgeIIWRXKVftTQ7qroaaJPMRllo0Sc5mxI/iM0ZC3J/Rr4elBxC3KNN
	 8HDxlRFa8Sl75d30OoIHmROJMLuBwRS8yHOVo/oFUuWY4Tp95EKk6iWHjwUAi5fK6R
	 k7VPyA/U2FAHHSjZpAXuQFnARSXOTjsnUjV9+gi0HfKfc/lwXnOPi3NhCOxR76OGpH
	 Ch4AyY06FjcuA==
Date: Mon, 9 Nov 2026 11:19:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, vidyas@nvidia.com,
	cassel@kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: tegra194: Use FIELD_*() for register fields
Message-ID: <20261109171905.GA211363@bhelgaas>
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
In-Reply-To: <20261102092238.3917883-2-mmaddireddy@nvidia.com>

On Mon, Nov 02, 2026 at 02:52:37PM +0530, Manikanta Maddireddy wrote:
> Several Tegra194 APPL and DesignWare register fields are programmed
> with open-coded shifts, which makes the register programming more
> verbose than necessary.
> 
> Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> sites where values are shifted into fields. The LTSSM state constants
> are converted from pre-shifted register values to unshifted field
> values for FIELD_GET().
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com

Thanks for this patch; it's great to get rid of the redundant *_SHIFT
definitions.

But I'm confused about why this Link: is here.  It points to "[PATCH
v3 1/2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1
entrance latency", which looks like a functional change.

This patch should be zero functional changes; it should be purely
mechanical changes from explicit shifts to using FIELD_MODIFY() etc.

This patch doesn't mention aspm-l1-entry-delay-ns, so it doesn't
*look* like this includes the [PATCH v3 1/2] content.
