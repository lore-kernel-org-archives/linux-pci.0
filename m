Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AE33A6E0;
	Fri, 24 Apr 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050029; cv=none; b=HNjkUnAHE3M4G/84tv5+Om2j/RVgUD4bZKw5yizUsQpBuKZIa69KrNMvK+e9TpMCDpE9SK/dcjzDMwg0xWAhtlakhIa4Nucr14p74h30jEeBag5DkZY3W17v/FMTbns4hor60XSqiSwo92BDJ5noTyWG2EvcGTuvZ9jofDFcA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050029; c=relaxed/simple;
	bh=eSw0n9DHniURNH3DP95DISd/QOgoRkxb7QWqjaPTzxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PuxARqHn507j/Es2uPCl8AIqsJ/Ea574z3w/IlKeBGiprCR/btpgt/8taFt02VGihbnbSbi9P3JZVufMOT08cyMQ+LcPc9Tb/MN5BR2jOFZ+v21cAJSKBg7TGMRWpgpMmD/tSIDvYqZcyFWwE6/gfRiwBM7P9EK2IibLd7NlMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTlHHSFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTlHHSFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C3C19425;
	Fri, 24 Apr 2026 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050029;
	bh=eSw0n9DHniURNH3DP95DISd/QOgoRkxb7QWqjaPTzxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QTlHHSFPYxc96ZzIrNJsgqff5ss3mW7qOJyHoY20TqlHlDoWaz71QO7OilTZ4bC9u
	 h2hkSQzxvhtTMdas3biNVbmYT0EGGDAQkUd3qjqnwlNnsgsCyEe+3fwoYjwj3jZodX
	 wKqrHgqTOk6c6bmJXHO1ft7Tm+HcyQq9bXankQ18HE6JWVu3ZI2TECi8hN8hBAM3vy
	 aPupjs9dnjL0CkV4frMyXfknE4qVBvXqF5KNi8/DDW+wpy7XTNR5A2KS672o09CYOK
	 gPMCNe43+PigkRiPz/3EDhFfFUQocPhPnqG96nsZxjosNNsouSmt1ay+gcKuziH8D3
	 gQsa0hlq1lv2g==
Date: Fri, 24 Apr 2026 12:00:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marco Nenciarini <mnencia@kcore.it>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: Guard Resizable BAR restore against
 unreachable devices
Message-ID: <20260424170027.GA16346@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776429882.git.mnencia@kcore.it>

On Fri, Apr 17, 2026 at 03:24:35PM +0200, Marco Nenciarini wrote:
> This series addresses Bjorn's review feedback on v1 [1].
> 
> v1 bounds-checked bar_idx before indexing dev->sriov->barsz[] in
> sriov_restore_vf_rebar_state(). Bjorn pointed out that the non-SRIOV
> sibling pci_restore_rebar_state() has the same issue, and that a
> PCI_POSSIBLE_ERROR(ctrl) check on the config read makes the intent
> of the guard more obvious than a post-hoc range check on the
> extracted field.
> 
> v2 therefore adopts PCI_POSSIBLE_ERROR(ctrl) after each Resizable
> BAR Control read in both functions, bailing out when config reads
> return the all-ones pattern. Patch 1 covers pci_restore_rebar_state().
> Patch 2 covers sriov_restore_vf_rebar_state(), with the NVIDIA GC6
> UBSAN splat as motivation.
> 
> Note that this changes behavior versus v1: on a bad read we abort
> the loop instead of skipping just the current BAR. This matches
> the structure Bjorn suggested in review and is safe because the
> all-ones pattern means the device is unreachable, so restoring the
> remaining BARs is moot.
> 
> Compile-tested on pci/next (full drivers/pci/ build). The error
> path cannot be exercised without reproducing the GC6 failure that
> killed the GPU in the original report.
> 
> The broader v1 discussion on the pci_restore_config_dword() retry
> loop and on save/restore behavior when the device has fallen off
> the bus is out of scope for this fix. Happy to tackle that
> separately if there is consensus.
> 
> [1] https://lore.kernel.org/all/20260408163922.1740497-1-mnencia@kcore.it/
> 
> Marco Nenciarini (2):
>   PCI: Skip Resizable BAR restore on read error
>   PCI/IOV: Skip VF Resizable BAR restore on read error
> 
>  drivers/pci/iov.c   | 6 ++++++
>  drivers/pci/rebar.c | 6 ++++++
>  2 files changed, 12 insertions(+)

Applied to pci/pm for v7.2, thanks!  Will be rebased after v7.1-rc1.

> base-commit: 40286d6379aacfcc053253ef78dc78b09addffda
> -- 
> 2.47.3
> 
