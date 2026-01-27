Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11F2E0401;
	Tue, 27 Jan 2026 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553778; cv=none; b=cr/hDV31N6CYHVF478mQsChesu1BxdjTkRPp1l3dfVJZpZd1c0MkidmOF6wRnmFnOg1+vQ39tDaY1VL/XfNB5uc/6c7cNT8Kd6YXCUUkfr+IxbCyecCzXZetI0gDIbBEK92v1HmY2CuqIonQI0F8Wiv1BJXpnHTLcIn3/FSl/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553778; c=relaxed/simple;
	bh=ezxKf+roc8CqaN3UTazwnF33h8Lc4jzlpSmlukud7i0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AsUlZgEWiqrQLJfGqFftjkUgM0lUybTLzs6Y7cgGaa6zGYPJ9EibTW3cB/PNDpXNA+Oq0JdutlK3wIyfvLSno++qwTRGehk6oAOCrvKFD4vx0j1pfkrwCl3DU2SHtn+p9o2yWEbXRI3V7v9fjakzFtKMYiMkzKta8l2Vo9f/vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suvxqLDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suvxqLDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADF7C116C6;
	Tue, 27 Jan 2026 22:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769553777;
	bh=ezxKf+roc8CqaN3UTazwnF33h8Lc4jzlpSmlukud7i0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=suvxqLDlrEX44Z0wh4czJeKEchpyhPar0UMrXbCp3ye7k55uCKWqbX4XaEbz+fk9t
	 dNYOLBdm/1YSstghBcldaqi4tj44xvlpXlh8MhG//7UBZMqlQ4vi9aXearS+vhBZCC
	 F+RngaduHMtKapuUZyAjyEatXQXKYjZpU5F5i9ifnHaFWuz70GoCZDH/rABOSmC3a8
	 52dX5apqUvix92NKLAmB0B0EkmdLxVFP80LpFSpaF6pgcEE9RthTkAXFhucR03KQHV
	 AcDwpGLBTVOmbtrCCpMnOr9aqSmr5UgsoloblIlHD7Ohgc4grgmtM5AgGF7LMV0k0L
	 /dNzaTP2TLT3A==
Date: Tue, 27 Jan 2026 16:42:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 05/23] PCI: Remove old_size limit from bridge window
 sizing
Message-ID: <20260127224256.GA384149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb05789e-6a9a-6051-e3fa-ce9ac168c5df@linux.intel.com>

On Tue, Jan 27, 2026 at 01:39:39PM +0200, Ilpo Järvinen wrote:
> On Mon, 26 Jan 2026, Bjorn Helgaas wrote:
> > On Mon, Jan 26, 2026 at 11:16:01AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Dec 19, 2025 at 07:40:18PM +0200, Ilpo Järvinen wrote:
> > > > calculate_memsize() applies lower bound to the resource size before
> > > > aligning the resource size making it impossible to shrink bridge window
> > > > resources. I've not found any justification for this lower bound and
> > > > nothing indicated it was to work around some HW issue.
> ...

> > > > Reported-by: Simon Richter <Simon.Richter@hogyros.de>
> > > 
> > > I guess this report was
> > > https://lore.kernel.org/r/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de/,
> > > right?
> > 
> > And this looks like a regression in v6.18 that will persist in v6.19.
> > 
> > Is that the right thing?  I wonder if we should move these first five
> > patches to pci/for-linus so they land in v6.19?
> 
> Fine with me if you want to do that. Stable people would pick things that 
> landing in the merge window into Linus' tree anyway so the difference 
> isn't going to be that huge.
> 
> Patch 3 is the scariest of the changes and is not strictly even a fix 
> (without it there are two parallel alignment approaches though which 
> wastes some stack space). It will have some impact on resource allocation 
> when the new approach is enabled for everything were as previously the new 
> sizing/alignment approached were only used in the relative safe haven of 
> relaxed tail alignment cases; though in my tests, surprisingly few changes 
> did occur.
> 
> The patch 4 too is on the edge, if you want to push that through for-linus 
> (but it's not dangerous and is useful for complex topos).
> 
> I don't know how you are going to handle the pci/resource branch then 
> though as I expect the rest of the series to not apply cleanly without 
> those 5 patches.

OK, I'll leave it as-is, with all of this on pci/resource for v6.20.

I was concerned that lots of people would trip over the issue Simon
reported, but I don't see many reports on the web.

Bjorn
