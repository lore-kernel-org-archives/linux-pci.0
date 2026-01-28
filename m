Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A52EA169
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634669; cv=none; b=W1zxsSA6kl1SJBtDcvIjqIuJTD4fYrcz5MCStea955m78uKjMzjXx3Rv6Eh141fG5z0S+hZ4HaxUgtnpqU+x6qsl/mW4g/7IGKzp/4nNEd0Ml5uZTaCeB5PsC4Dms27ZT+Ba0uHdyEuchLqtsI1XpmdoXKa8q19CBPvFbcHXZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634669; c=relaxed/simple;
	bh=kTOaPNhNYoTCD+Y3dzaBmVOZZ/YJX6h+UQxBHWF8uwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eHvEnkOQEjJzLXq95ZnRdL5ApN0U1PRzlIHOYrrINPlG2TarvrS2pb8jagljcLEYXRGrdfqLfQ0p4djFEtNOn5K2IZNEYbemFnhxVgsxm1Hz3NNz7z8IZjyp/xblvfwSDrlzDPH5BnBpH94/c061nVk9qYN4jYppK3i/zrR7suI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tghv5d7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tghv5d7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E76C4CEF1;
	Wed, 28 Jan 2026 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634669;
	bh=kTOaPNhNYoTCD+Y3dzaBmVOZZ/YJX6h+UQxBHWF8uwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tghv5d7qbpBH2YfYdnTJVPXf3r/2FR6zh6nBnTB7yt2FFZuPX7BqzGsZJtab3oz4b
	 +j1+WZs9OczDud985QmJJtF/9oFjRVjsa0hnfkpx5aFRLDDRlY3X5OkEyTo4bZszNV
	 MJon2hIt8zJPKUPqriJomJcZdgXU0j8/kO/mjrdSauhgBi+cIPi4yuonuCU15DKzkJ
	 01SfmkmnO0Xo0JmrBQpRdsysGGSqIpqU1RAFY2S2qxZFT0keX0Yyxvw29iSByCAuIg
	 21MNCeT9s8RCV5AVtRG/6C2eKgn3zeEwVwsyG8fS+dwC/BFfJrT1FF3HfGQRRMNlFz
	 YP6BwF91G/d+Q==
Date: Wed, 28 Jan 2026 15:11:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: dan.j.williams@intel.com
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex@shazbot.org,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Message-ID: <20260128211107.GA433824@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697a7a9913e11_309510010@dwillia2-mobl4.notmuch>

On Wed, Jan 28, 2026 at 01:07:37PM -0800, dan.j.williams@intel.com wrote:
> Ilpo Järvinen wrote:
> > On Wed, 28 Jan 2026, Bjorn Helgaas wrote:
> > > On Fri, Jan 16, 2026 at 10:41:50AM -0800, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> > > > prevent the warning:
> > > 
> > > I *think* this actually refers to pci_bus_trylock() and
> > > pci_slot_trylock() (not pci_bus_lock() and pci_slot_lock()), since
> > > that's what this patch changes?
> > > 
> > > It's unfortunate that pci_bus_trylock() and pci_slot_trylock() are so
> > > similar but separate.  If there were combined, this kind of issue
> > > where one is fixed but the other isn't wouldn't happen.
> > > 
> > > But what about pci_bus_lock() and pci_slot_lock()?  They are also
> > > almost identical, but pci_bus_lock() locks bus->self while
> > > pci_slot_lock() does not.  Should it?
> > >
> > > All these almost-but-not-quite identical paths make my head hurt ;)
> > 
> > My series does attempt to consolidation them (check the pending patches 
> > from me).
> > 
> > (It doesn't consider this fix patch though but the other one is taken 
> > into account, the series was build on top of it).
> 
> Lore link?

I think it's
https://lore.kernel.org/all/20260116125742.1890-1-ilpo.jarvinen@linux.intel.com/
