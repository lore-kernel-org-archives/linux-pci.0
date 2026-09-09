Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE1332EC5;
	Wed,  9 Sep 2026 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935106; cv=none; b=H/KHisEAmiW1+KXbUNn6u7+lfPkt0VHyL5SVH7iZk3UC5M20zUC/jFXhVGUhLv5g0/IqzmG2kHoIPf4VA0NRKjFOrh5OT1uTYDJx/TdfEupEUV1QmuaQZXT3M07WX4FjSjIMPD0hwHyJiMSgyvtwbfCYvsG+/LKvsALvaZ2SWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935106; c=relaxed/simple;
	bh=AOewFTS6ieihztqKkKLl+atwCjCGxq3umT61cCjPZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dre0X1XYAe4Wc2lHDCv98nWEcdVo+s4Kz2Nx4V5PQyBT2OchhMV5Kr8OodoRbq666Grn/sHP18eHcbqoiml1bqvTYcyQxSSxpxc7fOS0zpkmF2gtDdfq8cVmrBtSIBbKCMS8RD3nM7xM9AfJb3pmvwv9HCfNd9P8ChTQMlCE9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sUgSCINj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUgSCINj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To
	:Content-ID:Content-Description:References;
	bh=DrC+7Y0NJBkWPiUOZb9XNcsmEjWyF+yA7+WdSLGh5K0=; b=sUgSCINjNSoFE1VE2/2P0axkp0
	D1n6pnrdcI/TpKK0xFh3GnoPDjB3f9PIT2Br+MGodZO+1FYrGqJ7gZXzQf+QZ7vgvbdFJDTp3DVGZ
	Y7BE9WeRKvnghD8HtPRF0wa2BxI+/JSCF8fNbvhjzWoqHlHsrUAmr5JwXTamczmxxNIOzuKSyg0RY
	xb1+87ryBuuaJLzM8gz2e8nfeX0SXOjuwFJmxtUJPMpA/aYflSEHsCeSYirVdHWRd0MVibbQpBSdp
	VGqnjjluFgliYKD8P+JvpXqFs2ip7iqhQ29CMmMV1rO8nugojqyPtY2NDyfOTqA3PYP8sVVBiEWxf
	+tw9qqDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Bjx-0000000Arxw-45XA;
	Wed, 09 Sep 2026 06:25:01 +0000
Date: Tue, 8 Sep 2026 23:25:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fengnan Chang <changfengnan@bytedance.com>,
	Luigi Rizzo <lrizzo@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	Guzebing <guzebing@bytedance.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
Message-ID: <aqD7FDvDhiEF_u0N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q5f5tlt.ffs@fw13>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> > it appears that GSIM is only effective in scenarios where multi disks at very high
> > IOPS; in some cases, there was a noticeable performance regression. 
> > If there’s something wrong with my configuration, please correct me.
> 
> So we have a NVME specific mechanism to tackle the same problem and a
> more generic version which is subsystem "independent".

I'm not sure they tackle the entirely same problem, although they are
very related.

> Can you folks please coordinate and get your act together so that we
> don't end up with two competing mechanisms which make things worse than
> they are now.

This is what I'm trying to get done here.  This is the first time I've
seen GSIM as I still try to read lkml, although I usuall fail.
Unfortunately neither the nvme nor block lists were Cced on it,
despite most of the numbers involving NVMe.

> TBH. I despise the NVME is special approach because it's fricking
> obvious that this is _NOT_ a NVME specific issue. But sure NVME is
> special as all other subsystems are special.

Note that we tried to look into generic helpers, Keith tried various
versions using DIMLIB, and we've also considered doing more work in the
block core similar what networking does with NAPI.  But we're always
interested common code if it works, glad someone is looking.  Although
somewhat more productive suggestions would be helpful.

