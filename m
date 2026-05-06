Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E330AAA9;
	Wed,  6 May 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091285; cv=none; b=kPAKzx/IC/xRgaPJouRxdSi0SKNiAN6vdAkvk6ztLCKxJhc9LYBNJA8I5X1dbEWBZbbmifMUk5OGdP5p10m5utysumUL+W6xbMfJ0RzrQu4gSgis1pGYTefpGeN89xfFq/D6o9nCAun2mj3cWboHjt88j3I/yFfO+OwWaz5anIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091285; c=relaxed/simple;
	bh=c/09Dj8C+PYr3EcGytaD3pkNgvnZRe+8FnSy5cU6O2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oh87cM01S/yShe5+WlQS9TbOwdCsOmDBEfLHR/AebodJDgrLvglXEzM+Fj7Ah+wnULobAy7uCOk52JZnrdD9d3dtyPDW1KzMv99Dx/DYd54caeUvPhq4YU0rQ3JLPomFtoEkWOiAOwfnEeZ0+dwIlQVDiEA7F9YUTOltoIiG87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmQ6k5Qm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmQ6k5Qm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE22C2BCB0;
	Wed,  6 May 2026 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778091284;
	bh=c/09Dj8C+PYr3EcGytaD3pkNgvnZRe+8FnSy5cU6O2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qmQ6k5QmvqOHLJ9mTiSkOLDLIy5fZcfiUtV8ZK5n3kmAsEADxh/DDanOE1nlv6Yes
	 Q1m5LZcGxb4zyhXTViuEUtuW+u1f2YCGmq42PrfPdCkWIsnoUUZrRdb3Pajn1eh2qG
	 StEr0KXZ+ihay4w+Ngizt9yOI7G3tyXnQ9+FBJYpSzrfo+909VmpalnVx2yxwO+rMf
	 9Oy0p92HPWGTf5p/FNFZnYZT+gKIZxdlRYbZNHwQ0/KQqmArtGjBUop96S3gHFJnHq
	 QLyDfTOrpBLJi1MsIr/PHX7UdgIevqKLFBY7/jQIZPkeRthMRAlnbi0BKAqJwCT1/t
	 W/xsnPXiHAvbw==
Date: Wed, 6 May 2026 13:14:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] PCI: pci_resource_alignment() improvement +
 cleanups
Message-ID: <20260506181443.GA804153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>

On Wed, Apr 29, 2026 at 03:26:06PM +0300, Ilpo Järvinen wrote:
> pci_resource_alignment() returns 0 when resource is already assigned
> and in case of disabled bridge windows. This has caused problems to
> calculations relying on pci_resource_alignment():
> 
> https://lore.kernel.org/linux-pci/LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM/
> 
> This series reworks pci_resource_alignment() interface to return always
> non-zero alignment if the resource exists. For assigned bridge windows,
> the calculation is using heuristic based on size and start address
> alignment as calculating the alignment again is costly (would require
> sizing the entire sub-hierarchy).
> 
> As pci_resource_alignment() is becoming more complicated, it's also
> moved to setup-res.c. While moving pci_resource_alignment()'s arguments
> are converted into const to tell compiler it can rely on resource
> remaining the same across the call.
> 
> This was intended to be part of a larger series that addresses some
> shortcomings in pci=realloc. The pci=realloc changes will recalculate
> bridge window sizes considering also assigned resources which required
> making these changes to pci_resource_alignment().
> 
> As this also relates to the issue linked above, I'm sending it already
> now without pci=realloc changes that are still incomplete. The first
> patches originate from the large pci=realloc work but seem generally
> useful even if independent of the alignment improvements so I've
> included them here without reorganizing the series to contain only
> alignment related changes.
> 
> Ilpo Järvinen (11):
>   PCI: Log all resource claims
>   PCI: Rename added to add_list
>   PCI: Consolidate add_list (aka realloc_head) empty sanity checks
>   PCI: Remove const removal cast
>   resource: Make resource_alignment() input const resource
>   powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get()
>     pci_dev const
>   PCI: Make pci_sriov_resource_alignment() pci_dev const
>   PCI: Convert pci_resource_alignment() input parameters to const
>   PCI: Move pci_resource_alignment() to setup-res.c file
>   PCI: Lower bound bridge windown alignment
>   PCI: Return valid alignment for assigned resources
> 
>  arch/powerpc/include/asm/machdep.h         |  2 +-
>  arch/powerpc/kernel/pci-common.c           |  2 +-
>  arch/powerpc/platforms/powernv/pci-sriov.c |  4 +-
>  arch/powerpc/platforms/powernv/pci.h       |  5 ++-
>  arch/powerpc/platforms/pseries/setup.c     |  5 ++-
>  drivers/pci/iov.c                          |  7 +--
>  drivers/pci/pci.h                          | 24 ++++-------
>  drivers/pci/setup-bus.c                    | 50 ++++++++++++----------
>  drivers/pci/setup-cardbus.c                |  2 +-
>  drivers/pci/setup-res.c                    | 37 ++++++++++++++++
>  include/linux/ioport.h                     |  2 +-
>  include/linux/pci.h                        |  8 ++--
>  kernel/resource.c                          |  2 +-
>  13 files changed, 94 insertions(+), 56 deletions(-)

Applied to pci/resource for v7.2, thanks!

Powerpc folks, the arch/powerpc changes here are minor (just adding
const), but heads up in case you see any issue.
