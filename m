Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C73E450A;
	Tue,  9 Jun 2026 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045141; cv=none; b=AUzTHYsVYzYQCMgZy+5moO7mvgBSMyy7C5oTXPpX7CRvEXlaKSVugRX3dtxVKKX+trne2bV6oGROGqfWMXLbJ0RF4sjVMOUdk9R8EzAmbUiDqVVxxFCC9ILhjqyEC+a5IO5VbV1IT0VI4XpLseTBfThp3eOe76t210qLr6/taP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045141; c=relaxed/simple;
	bh=Yl6uFB7h4FcM9O57SFPkn7nr1pJ4LVyJ2RloXgxYQdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MJ8bUBNnjO0i8GxCo8TE9wMMIjrJ+wMEw90hODP/5eaXcy0JB0ZWOKPQ3XM1XobQHgBO71ECc++DhkK+KAO97q4CcK8cYrgvhzmfvudjD/kYz39Qndi3Yz2dZ8l7TiPe6QmD9XE2NJOn7ODpBqyQ4zSPaL8bb4DUEtlNsbbaP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTr+6a2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTr+6a2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516961F00893;
	Tue,  9 Jun 2026 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781045140;
	bh=RsrMhm/FSh8bMoXqXZM8Zp+wWxL61CZwNUdEQaR+aVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BTr+6a2FceXyQwi6ug2vSzw899jOk6cKAsipEiFouGdN9G5sFC+hWzeyurQ3aerOW
	 jZ5HtkIKmyJeIw+s2izHlxhEM4UH4RTn5T0V8Yph1VdbYJuLzCYRHjRqHWDyI+DWXX
	 W8XiGb9XZ8DfBHSBZrr66ugzufM+I9p6dcgO5IdVOcmJa+pRNYsSUgveLhah9qgHcO
	 wPhfrXGEcLgBnMXGoxVlaenHLPexD+iMFew2tzVTd7HAG5/uzkFq9dnsCm8GW2d/1B
	 u91VtOSzJsOgGlWZfopQOt2TKhdRL9ZI21iaTzIjzJnpOTDqNl1qw826z51K6Mtwwu
	 9anj7xfA6487g==
Date: Tue, 9 Jun 2026 17:45:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <20260609224539.GA175244@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529230553.GE3195266@nvidia.com>

On Fri, May 29, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 03:09:46PM -0600, Alex Williamson wrote:
> > This deserves a /* CONFIG_PCI_P2PDMA */ reference like the previous
> > long span, though potentially a better solution would be to split the
> > core code out to a separate file with shared header.  I asked opus to
> > see what this would look like and it generated the patch below
> > (unverified, compile tested only).  Bigger diff, harder to follow
> > blame, but the shape of the core is much more apparent.  You're welcome
> > to take or leave it.
> 
> I think it is a good idea, it will make it easier to add more stuff to
> these different aspects.
> 
> Really they are now two different things with one layered on top of
> the other.

Sounds good to me too.
