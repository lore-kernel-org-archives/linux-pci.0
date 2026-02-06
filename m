Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EA2E1C7C;
	Fri,  6 Feb 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418613; cv=none; b=IBZekcrk9gfQ63oNXwjTFBJEHMVQ4wxzOlf5HVEtbKU/M7v/tdwplGc6CQtVsmUUIkAZoJo/i8TNiANOXJXyIXPyOVBdosjSCOr3wnjiPEfCfCZc489XJY3FXIi6KNj7FbduMIt38BDVs5IpfgDy8fvjgcOYOSO3OFCrCGhsIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418613; c=relaxed/simple;
	bh=6WjCz7ZYMe/AH95Qk82FRiPfEqWKuEtaImrhUSXf088=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l+o0AvXz+XoFvixs2tv0/h5Mk26UjXP1p44VTr9SSROT4x5iSDy3CSOg9v54cQ8vbuDbq2HhmNaWjGlQzJ99QVSR0aW/2T654DxNwasaeEUoXJ+BUxA+NV2U8u+wTejLA38FGBM8xwgaw1w/ocT20Bf0994H6wSRBGXCm57d/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqpm40OT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqpm40OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D495C116C6;
	Fri,  6 Feb 2026 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770418612;
	bh=6WjCz7ZYMe/AH95Qk82FRiPfEqWKuEtaImrhUSXf088=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qqpm40OTRKnSEh/z/DRKrv+enLA5BVgBYbita40USFJSdugz22fdq2AbdHM2oQCxW
	 RQeWrpVfE+kGqVKahezLDa/LFNf2I6GTnXVrTrUwri93opGVQGkEeKM4KXgEk7f7+0
	 f38QCdVJDa+huInJqgcu040X35/FAZxp0i7bzaL7e71s6KPrGR3zR7pX1Z7oWeqw7c
	 5ZZoe783OUnn42Za3TB9cwZ34yRmbhf9DOc+Azn2kXsqDkdEWRvdyO4rjKoD+016DP
	 es1htKxSCIVDJtM7YVyUqDKtb3k05eBCXQ8iiZb7FuhCXhmZVmqbDAThm1D2xPA6Ad
	 ql8dr80Hy2qXA==
Date: Fri, 6 Feb 2026 16:56:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jinhui Guo <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Locking related improvements
Message-ID: <20260206225651.GA103421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>

On Fri, Jan 16, 2026 at 02:57:39PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> Here are a few locking related coding quality improvements, none of
> them aims to introduce any function changes. First two convert "must be
> asserted" comments into lockdep asserts for easier detection of
> violations. The last patch consolidates almost duplicated code in the
> bus/slot locking function.
> 
> This series based is based on top of the fix (the last change would
> obviously conflict with it):
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.2555-1-guojinhui.liam@bytedance.com/
> 
> 
> Ilpo Järvinen (3):
>   PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held
>   PCI: Use device_lock_assert() to verify device lock is held
>   PCI: Consolidate pci_bus/slot_lock/unlock/trylock()
> 
>  drivers/pci/pci.c | 120 ++++++++++++++++++++++++----------------------
>  1 file changed, 63 insertions(+), 57 deletions(-)

Applied the first two to pci/virtualization along with the other reset
changes for v6.20, thanks!

The last is a great idea but will need some rebase/rework on top of
Keith's changes.
