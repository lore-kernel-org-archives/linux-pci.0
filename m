Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E622A817;
	Sat, 21 Mar 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100330; cv=none; b=D0m3EX6sjCn/BlNDaBQJoJClfEAsU+LlApstcrwMM33VBocADfvJfCpgPSNlGrsxA165nlSn1pTzYoC+KQBN6Y09JgnNqJUuSN0IowuCxvj1hKefuwKPBO2V4I9DB+HzLbizUIKnR4bDOXK2whWzqPguPEvuF7EU+GFoCCEUTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100330; c=relaxed/simple;
	bh=XdYlom3Qx5rfTfFIDsTKcd5uelX4cS/UU3CMJNrqMDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHEJq+nkCwEqYi7YAL7/O/Am/UqZoT8qfqsxYDgDVdHwymBXGu8ka53b/eDih8K37KY8luVk1Xx74KXFwdOx03m0kvnQOCBet0rUZcoIzoBRv5gqb4S3tqqLld2fxdUfyV//gn3cQo/IJRUG8nF//I/Xe0Y+TcXU2dSD+wgvAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgiHMJRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgiHMJRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BFC19421;
	Sat, 21 Mar 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774100329;
	bh=XdYlom3Qx5rfTfFIDsTKcd5uelX4cS/UU3CMJNrqMDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgiHMJRSu2ruv+rfKLyX8yncOhfETDLDFaOsjkxaTC8LQiJEtH1qYSUuRC/HlUbPi
	 NNTsv/vVYfcu8PmusKo9MwR7XK5iudkzz9WYy9yry0Ttgrsn3VIygNMUGUpAWO495i
	 2GY1rumtICV01JhRGA7PRYcbZdfoTJQvdkNcRR9V6nLcPOM+S7ZJ4PHR/hFQa9JS9c
	 NYVH0eB9UAd24I/6cmO4rfNQfqx/YymGkzI1POHMM+iPU0T8pPHljs870MiiDpoFRa
	 4iuNz13yZe8nYTYi71jfzgVfwdpwZcb5JQfFNkJrEoy0J6mZGmM3RaBRlmrYgtk73v
	 iMMYQWq7QQYaQ==
Date: Sat, 21 Mar 2026 19:08:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, 
	Frank.Li@nxp.com, kishon@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org, 
	linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
 <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>

On Fri, Mar 20, 2026 at 11:55:23PM +0900, Koichiro Den wrote:
> On Fri, Feb 27, 2026 at 05:57:40PM +0900, Koichiro Den wrote:
> > On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> > > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > > without changing the on-the-wire doorbell mapping.
> > > 
> > > 
> > > Background / problem
> > > ====================
> > > 
> > > ntb_hw_epf historically applies an extra offset when ringing peer
> > > doorbells: the link event uses the first interrupt slot, and doorbells
> > > start from the third slot (i.e. a second slot is effectively unused).
> > > pci-epf-vntb carries the matching offset on the EP side as well.
> > > 
> > > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > > mismatch is mostly masked. Doorbell events are effectively treated as
> > > "can hit any QP" and the off-by-one vector numbering does not surface
> > > clearly.
> > > 
> > > However, once per-vector handling is enabled, the current state becomes
> > > problematic:
> > > 
> > >   - db_valid_mask exposes bits that do not correspond to real doorbells
> > >     (link/unused slots leak into the mask).
> > >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> > >     expects a 0-based db_vector for doorbells.
> > >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> > >     it directly calls pci_epc_raise_irq(), which can sleep.
> > > 
> > > 
> > > Why NOT fix the root offset?
> > > ============================
> > > 
> > > The natural "root" fix would be to remove the historical extra offset in
> > > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > > Unfortunately this would lead to interoperability issues when mixing old
> > > and new kernel versions (old/new peers). A new side would ring a
> > > different interrupt slot than what an old peer expects, leading to
> > > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > > are implemented.
> > > 
> > > Therefore this series intentionally keeps the legacy offset, and instead
> > > fixes the surrounding pieces so the mapping is documented and handled
> > > consistently in masks, vector numbering, and per-vector reporting.
> > > 
> > > 
> > > What this series does
> > > =====================
> > > 
> > > - pci-epf-vntb:
> > > 
> > >   - Document the legacy offset.
> > >   - Defer MSI doorbell raises to process context to avoid sleeping in
> > >     atomic context. This becomes relevant once multiple doorbells are
> > >     raised concurrently at a high rate.
> > >   - Report doorbell vectors as 0-based to ntb_db_event().
> > >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > > 
> > > - ntb_hw_epf:
> > > 
> > >   - Document the legacy offset in ntb_epf_peer_db_set().
> > >   - Fix db_valid_mask to cover only real doorbell bits.
> > >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> > >     unused slot).
> > >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> > >     accordingly.
> > >   - Implement db_vector_count()/db_vector_mask().
> > > 
> > > 
> > > Compatibility
> > > =============
> > > 
> > > By keeping the legacy offset intact, this series aims to remain
> > > compatible across mixed kernel versions. The observable changes are
> > > limited to correct mask/vector reporting and safer execution context
> > > handling.
> > > 
> > > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > > applied separately for each tree. I am sending them together in this
> > > series to provide the full context and to make the cross-subsystem
> > > compatibility constraints explicit. Ideally the whole series would be
> > > applied in a single tree, but each subset is safe to merge on its own.
> > > 
> > > - Patch 1-5 can apply cleanly onto pci/endpoint latest:
> > >   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
> > >                  jiffies from pci_epf_mhi_edma_{read/write}")
> > > 
> > > - Patch 6-10 can apply cleanly onto ntb-next latest:
> > >   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
> > >                  path")
> > > 
> > > Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> > > (not vNTB) bridge scenario, but I believe no changes are needed in
> > > pci-epf-ntb.c.
> > > 
> > > 
> > > Changelog
> > > =========
> > > 
> > > Changes since v1:
> > >   - Addressed feedback from Dave (add a source code comment, introduce
> > >     enum to eliminate magic numbers)
> > >   - Updated source code comment in Patch 2.
> > >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> > >     Thank you both for the review.
> > 
> > Sorry, I accidentally used an incorrect series title.
> > The correct subject should be:
> > 
> >   [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
> > 
> > For reference, v1 is:
> > https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > 
> > Best regards,
> > Koichiro
> 
> Hi Mani (cc: Jon, Dave),
> 
> This series has been sitting for a while, so I'd like to check how to proceed.
> 
> I'm thinking of the following approach:
> 
>   - get the remaining acks from the NTB side
>     (Dave already gave Reviewed-by for Patch 6/10)
>   - then route the whole series via the PCI EP tree
> 
> Does that sound reasonable?
> 
> If so, I can prepare a v3 rebased onto the latest pci/endpoint.
> 

Yes please. We have queued a lot of endpoint patches for v7.1, so it makes sense
to route this series as a whole through PCI tree.

Also as you noted, all the NTB patches need an Ack from Dave.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
