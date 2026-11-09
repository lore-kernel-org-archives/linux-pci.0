Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266822;
	b=jho+kTsoXwg4f8NXcCXg6h/G54hJ0aRHIYcYUs0sdQtaxBJl04WAWt67WmdmXjnLyDgw
	 IMZQ8Z7Mx9zqGSSd0VNub//K7sMv8BYLO7vKWuctEWeS6rXsgQ9YM1ScEb/sTMUHem2Ug
	 tEWT77YqJHou7vNXlCy3JzL+aUWvWSw9lTuO7hSdN8grNK5pV94sSDGpgTkY6xPf+/p7h
	 4F38u4P/bXyipujx07z1D35xAg9rEx5arJ61afX4x+BCsBRqNjkTAUlBk156eMxb+Bad/
	 TX/jAfGhWFwWHnNXLKWze89R7VjRc6hByV2T+lk9owHDcpEUGnUR+EVpg2HbO3cI6vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266822;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5T06KjKh3MrPBKKQKkoAa2wQ1L3CjHdGCtg0p/w53Yw=;
	b=f9ckntXH9HlO5Tbs0UOuORD26GoQzfMM2MCej/ks/y8/+FUKZWu6v9gl4FKx0ysb8BJH
	 FT9mJxaGS/C0NSoM7CJgEVFel4FH0xZeIz+Whd3/lExIL3XG58q80exhZ8pWa+ljW+GdE
	 7ydFYmyizfaR/NgVTdxtzT3FQUlI+BRBtbK1PXX1kcPI9toNZovhePjPU8EcnPVqCuwhx
	 jpF7qvGXiM/BysNcCmly4ziyBJiGdBszyENVXlfdvxU6ggJcKNP6g6hBFuoGbuD7AX2KV
	 yBGYDVGPbfjz58MdBiBSg9rwBsZo47dORGC70UOYV8znzxlSpdPgdOABpw3gukGbI1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGdD74TF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1C606A31C;
	Mon,  9 Nov 2026 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGdD74TF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755FE1F0089F;
	Mon,  9 Nov 2026 23:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266821;
	bh=5T06KjKh3MrPBKKQKkoAa2wQ1L3CjHdGCtg0p/w53Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NGdD74TFOS5SZwMEeZjGuRSYX7K2YVOZRodbDwe7+e58GU3kCItfqMre0oiWJEt31
	 bcBwyX0EdWPdxlU2a/jkb22sQrmkp0IvZmAeJQf3fiRUCzA/KAAOKytDwRLRNY2ah8
	 qQQXLWglsEkndBc8OEx0VBv7iFkQptvD+39jWgr7pTAKEZqGoEcO9qY6QXr7A9rFZF
	 uC0rkwMIgqDXY9/y7LUYw3iKr3Ko2fnDIVP3IF1jI6pX28poFm8/TP7kQ9Wnlh9tmk
	 w5dVOgxhecWjbEPw8njHK7nIqS8tKwLhmfT7Dg9QBUTJKp3VZaRS2xm812GjkKSulo
	 9YlIIz5+PQXYw==
Date: Mon, 9 Nov 2026 17:27:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
Message-ID: <20261109232700.GA345907@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>

On Fri, Nov 06, 2026 at 03:43:21PM +0200, Ilpo Järvinen wrote:
> V4 got quite many comments from sashiko, some of them were a bit
> sketchy (bogus scenarios such as IOV BARs on a bridge) but there was
> still good feedback hidden under the clearly flawed facade.
> 
> There have been major changes so any retesting is appreciated (the
> 4 candidates patch is largely the same so I kept the Tested-by tags but
> everything around has been changing so even that is on the borderline
> when it comes to the validity of the existing tags).
> 
> I ended up dropping the nested window fix which I had anyway realized
> would not be necessary with the current resource code. I had earlier
> planned to change the resource side code to only try start addresses
> that qualify to size+align requirements and had thus kept the nested
> win fix. But it just makes PCI side more complicated requiring extra
> tweaks and checks. With that patch dropped, pci_align_resource() can
> alone decide the placement making the code much simpler.
> 
> Second major change is rewriting the gap calculation, which required
> including pbus_size_mem() refactoring that I was planning on doing
> anyway.
> 
> As with v4, the quirk is not included and one approach should still
> be selected to solve the Genoa/Zen4 iomem blackhole but that's not
> likely the one I proposed within my series so I left it out.
> 
> This series also does not attempt to address cases where user alignment
> override does not propagate to window size calculations and thus not
> into the align given to resource placement code (reported by sashiko).
> These are pre-existing issues and while they should be fixed
> eventually, I've no plans on increasing the scope and complexity of
> this series that is focused on solving real regressions caused by the
> commit 9036bd0efcb6 ("PCI: Align head space better").
> 
> For those who haven't read the previous version intros (no changes
> from v4 in this):
> 
> This series generalizes the resource placement algorithm. The commit
> 9036bd0efcb6 ("PCI: Align head space better") special cased one
> composite resource remainder case to fix a regression (in a long chain
> of regression fixes). Unfortunately, it introduced another regression
> (or a few, to be more accurate).
> 
> Instead of building more special tricks, generalize the PCI resource
> placement algorithm so it returns placement that gives better chances
> for the greedy assignment algorithm to find suitable space for
> subsequent assignments.
> 
> In short words, the new approach tries to find a placement for the
> current resource that blocks as little of the free space range as
> possible, considering both alignment and continuous free span of the
> remaining free space.
> 
> In addition, the series corrects composite resource sizing to account
> for gaps that have to be added due to alignment constraints and
> remainder space not fully connecting (filling space all the way to
> the bridge window align).
> 
> More detailed explanations in the patches themselves.
> 
> Unfortunately, this also causes yet another regression due to shuffling
> resources around. I've left my quirk out of this version as it seems
> the least likely approach to be used to resolve the issue. Some approach
> should still be applied but that decision seems largely independent of
> this series. The main part of the quirk discussion is here:
> 
>   https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen@linux.intel.com/
> 
> I find it likely that after this series the resources are packed tight
> enough to solve also
>   https://bugzilla.kernel.org/show_bug.cgi?id=220016
> from more than a year back but that remains to be seen (if we can still
> get the reporter to test it).
> 
> 
> I planning on making another series to properly honor
> pci=resource_alignment and improve locking as I realized the current
> approach allows parameter change to race with the fitting and
> assignment algorithm.
> 
> v5:
> - Reordered series, "simple" patches first
> - Added patch to skip resource with IORESOURCE_DISABLED
> - Added patches to fix __ffs*() (__ffs64 & zero handling)
> - Fix 2 more 1UL -> 1ULL, renamed roundup/down funcs to _u64
> - Rework considering user/arch min align, always take it into
>   account during placement if present (sashiko)
> - Rename pci_init_pci_resreq_data() -> pci_init_resreq_data() and make
>   it non-inline func
> - Drop nested window fix (unnecessary and w/o complexity is less)
> - Rename .user_align -> .min_align
> - Use struct to store candidate selection parameters
> - Rework candidate selection precedence
> - Calculate odd-multiple starting "2 blocks resource" using both blocks
> - Add a tie breaker to candidate selection using alignment of the left
>   edge
> - Do not use candidate logic if there's no full block or
>   rr->min_align > align (the latter is due to pre-existing problems
>   elsewhere).
> - If no candidate is possible, return right edge of the empty res
>   (not strictly necessary because one of the candidates is at res->start
>    and the caller should use large enough align if user align is present
>    but it doesn't hurt either)
> - Refactor pbus_size_mem() to support the new gap calculation
> - Reworked gap calculation entirely
> - Added debug print to sizing function
> - Fix many grammar errors / typos / consistency improvements
> 
> v4:
> - Drop my own quirk patch (one approach should still be picked!)
> - Use 1ULL to not lose bits in 32-bit case (sashiko)
> - Copy avail flags from full_avail.flags (sashiko)
> - Always return "resize" from pci_specified_resource_alignment() (sashiko)
> 
> v3:
> - Add roundup/down_pow_of_two64() (new patch) to avoid problems if
>   resource_size_t is 64-bit and unsigned long is 32-bit + use __ffs64()
>   (multiple potential issues mentioned by sashiko)
> - Do not print res->parent in parisc debug code as the resource is never
>   in the resource tree (found by sashiko).
> - Do not override user-alignment with the remainder moves (sashiko)
> - Consider optional sizes properly when sizing bridge window gaps (sashiko)
> - Move genoa quirk under arch/x86/
> - Rename quirk's static resource variable
> 
> v2:
> - Add patch to cleanup parisc debug print (do dyndbg conversion)
> - Add patch to prevent remainder tricks when alignment override is used
>   (found by sashiko)
> - Do not use PCIBIOS_MIN_IO/MEM but 1U as min align. The former seem
>   address space lower bounds even if parisc arch code misleadingly
>   uses them for ALIGN() call.
> - Fix res->end + 1 overflow case (found by sashiko)
> - Tweak debug print formatting
> - Reworked the iomem black hole quirk (now based on the bridge)
> 
> 
> Ilpo Järvinen (14):
>   resource: Mark free space assigned
>   parisc/PCI: Clean up resource debug print & use dynamic debug
>   PCI: Don't size or assign disabled BARs
>   PCI: Use __ffs64() for resource_size_t typed align
>   PCI: Prevent zero align from reaching __ffs64()
>   linux/log2.h: Add 64-bit roundup/down_pow_of_two_u64() variants
>   PCI: Derive aligns[] array size in a define
>   PCI: Honor alignment overrides
>   PCI: Place resources to either edge of the window
>   PCI: Separate align/raw size calculation from pbus_size_mem()
>   PCI: Calculate bridge window with optional sizes from scratch
>   PCI: Move size/align calculation fully into __pbus_size_mem()
>   PCI: Fix composite resource sizing
>   PCI: Add debug printing to window sizing

It looks like the early ones are straightforward and good-to-go.  How
many could we just apply in order to get them out of the way?
I'm guessing at least the first six (up to and including "PCI: Derive
aligns[] array size in a define")?

You mentioned "this also causes yet another regression" so I assume
there's something we're not quite ready to merge yet?  I'd like to get
the rest in linux-next as soon as we can.

>  arch/alpha/kernel/pci.c          |   3 +-
>  arch/arm/kernel/bios32.c         |   5 +-
>  arch/m68k/kernel/pcibios.c       |   4 +-
>  arch/mips/pci/pci-generic.c      |   5 +-
>  arch/mips/pci/pci-legacy.c       |   5 +-
>  arch/parisc/kernel/pci.c         |  20 +--
>  arch/powerpc/kernel/pci-common.c |   5 +-
>  arch/sh/drivers/pci/pci.c        |   5 +-
>  arch/x86/pci/i386.c              |   5 +-
>  arch/xtensa/kernel/pci.c         |   5 +-
>  drivers/char/agp/intel-gtt.c     |   5 +-
>  drivers/gpu/drm/i915/i915_gmch.c |   5 +-
>  drivers/pci/pci.c                |   4 +-
>  drivers/pci/pci.h                |   6 +
>  drivers/pci/setup-bus.c          | 263 ++++++++++++++++++++-----------
>  drivers/pci/setup-res.c          | 246 ++++++++++++++++++++++++++---
>  include/linux/log2.h             |  52 ++++++
>  include/linux/pci.h              |  15 +-
>  kernel/resource.c                |   3 +-
>  19 files changed, 510 insertions(+), 151 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.47.3
> 
