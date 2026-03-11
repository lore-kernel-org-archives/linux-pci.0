Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61456377542
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270875; cv=none; b=GayD3JhqHHfuejDYC2e0cLREnEN9NoCfROXUMeEWzkPbcTgELJJ2AHKrYhxPvd6oWBupeJJ3Mz1wt6Jkni8bA0aYx3r+L5OhEgpHsNlkKZIgbLdyr83qT80PPQnCVxHbFW9Qr77aKKZtzFNoKg1GEV1w2NsUB2v6nPLBTopMaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270875; c=relaxed/simple;
	bh=PMFM4CqgSssQ4CnXzCICZtNXFK0XLwYNcekNrdndkt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XOKjr1mTCy5qtisziLgdcs/o9uEsAo77YeYy5xdsZbq+I0lRK26SBSeYdXD2prZ9aqJMcAVh3ZDFtWlTMtN0Ifa5/F4k7Uo8KFrjZ2KFY+0cvdkGnpqmRRP5uFnWNMa2gGmH3JOHD4Y4eWumC8NXqyBZhAMWR3wBm7OIylXJ2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGDbYIvm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGDbYIvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C29C4CEF7;
	Wed, 11 Mar 2026 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773270875;
	bh=PMFM4CqgSssQ4CnXzCICZtNXFK0XLwYNcekNrdndkt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BGDbYIvmJx1dWnQHEeX/lP8nZSOvuqeJra5Jw1QVZ2vijaUTEPk72D5GjzWP5qWIb
	 y9FT7Y2WFNNjqbVIOM7q0lZ4OO0ug86ZW6ktLt7xPTWpCKMnhd5xSIvlznAeLpC/bN
	 fqtbia3sg9ChiZMSAiF4jplAx+jTv+K1HtdyDbMC2ye9F++e7Y/9gl1KXVNyqZoVYe
	 VmNc22e5k9EZ7a5NU3z6MFB8mKeYslbBGsBVTQf+q5NPnaiwyLkAl3aaLGaTpuwDxX
	 wTOlwR6x+GgmV0lfam2/scLRRHouPNcfgosvUnxWhxZ8ezXoXITfF/QOz1MKpBVD/y
	 724rKy9n1gP4Q==
Date: Wed, 11 Mar 2026 18:14:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/5] vgaarb: mark vga_get() and wrappers as
 __must_check
Message-ID: <20260311231433.GA1083635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30fdf953-76b4-4aa6-b430-b9c73f91c8cb@hogyros.de>

On Thu, Mar 12, 2026 at 07:51:31AM +0900, Simon Richter wrote:
> On 3/11/26 5:07 AM, Bjorn Helgaas wrote:
> 
> > vga_get() is implemented in vgaarb.c and is only used there.  Can we
> > drop this declaration and the stub below, make it static and
> > __must_check in vgaarb.c?
> 
> It's documented API, and exported. If we make it private, we need to export
> vga_get_interruptible() and vga_get_uninterruptible() instead.

Yes.  vga_get_interruptible() and vga_get_uninterruptible() are
already exported by virtue of being defined in include/linux/vgaarb.h.
We would have to move those implementations to vgaarb.c and
EXPORT_SYMBOL them, leaving just the declaration in vgaarb.h.

Is there other API documentation I don't see?  Are you concerned about
out-of-tree drivers that might use vga_get()?  I don't know how much
to worry about that; usually I don't put too much effort into keeping
out-of-tree things working.

Bjorn
