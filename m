Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9A3DA7FC;
	Mon,  2 Mar 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460955; cv=none; b=RjiPaCAx3ueP+HXkJHi1ghHRJZc9swtrF8fvlZ491MzmVLnn5V7vp9+Xud1J5bhnYBzkt7teBEUS981M6eEFJP9vLqb23DIQ2jCggWcoNi4hqkQ6QwAzLfy1sEL4utojZFYnV+Fi0Zb6peaJXniIGjf0vD+QwcmEXbwcWq1nmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460955; c=relaxed/simple;
	bh=pQQsCniROcPjC6d+VRj/iFcR4pZ8qZujZDbz/KpKee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvCATGaYuNi2yAGzuo+kF1GEuJ8oyo6bbEWtZbO7lVxH2y2IH6dtZO32QY8RRvHEgzrbCpYrZH2fW//Y/pRVaktmMiEf113Sjj4B8gwolMI/n7HmbHkML2gL+hmExS/vZTUNlEXgthAiR7ix0hzqL5roAPpITPD+hxJJPFib5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsg2aane; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsg2aane"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C88C2BC86;
	Mon,  2 Mar 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460955;
	bh=pQQsCniROcPjC6d+VRj/iFcR4pZ8qZujZDbz/KpKee8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bsg2aaneh+3q8BefK6Jsi2wEgucNOHaYa8a06q2komNGlfraeKdCFTjY+IHZSo/Gn
	 AdsxiOeZPty9MnwabnEgDyKkeSU+Tt0sJy+g7UXQIn+xnf24OLUYqYfK+/EnvHce/U
	 kHA7O4/K6bNIGKwnng0Qi6TcryMAUGYJWpzVR+ROmFACA18mQEdloQa3KxU08yh987
	 ZL7/cCUu8TnPWXcn0Pd747kq8wS46+zta2YC/1BUW2CZMzrZf1IqfY7GmWwrbdB076
	 BaWzT9j8ddwvEqeiWxYDzxTiwUK6db6a7ExqTO5SuxuihZwk1kbRIrz7k8NYRy79DN
	 LyUnIVPoNqSSQ==
Date: Mon, 2 Mar 2026 19:45:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com, 
	alifm@linux.ibm.com, julianr@linux.ibm.com, dtatulea@nvidia.com, 
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <cq3z34gmevzczk6gpvqfz5whevsjdodq4ls2j2jhxqx2apgngu@sowonwmqy6ol>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
 <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
 <20260228163955.GH13050@p1gen4-pw042f0m>
 <vogl77sk53qas4nnqb4jrmduofxhuhpcgipdkab5meuswd3hhr@l6rfqqndskfv>
 <20260302101105.GA1971507@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302101105.GA1971507@p1gen4-pw042f0m>

On Mon, Mar 02, 2026 at 11:11:05AM +0100, Benjamin Block wrote:
> On Mon, Mar 02, 2026 at 11:43:04AM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Feb 28, 2026 at 05:39:55PM +0100, Benjamin Block wrote:
> > > On Sat, Feb 28, 2026 at 08:43:33PM +0530, Manivannan Sadhasivam wrote:
> > > > On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> > > > > From: Ionut Nechita <ionut.nechita@windriver.com>
> > > > > Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> > > > > pci_lock_rescan_remove_reentrant() helper. This function checks if the
> > > > > current task already holds the lock:
> > > > >  - If the lock is not held: acquires it and returns true, providing
> > > > >    full serialization against concurrent hotplug events (including
> > > > >    platform-generated events on s390).
> > > > >  - If the lock is already held by the current task (reentrant call from
> > > > >    remove_store or sriov_numvfs_store paths): returns false without
> > > > >    re-acquiring, avoiding deadlock while the caller already provides
> > > > >    the necessary serialization.
> > > > >  - If the lock is held by another task (concurrent hotplug): blocks
> > > > >    until the lock is released, then acquires it, providing complete
> > > > >    serialization. This is the key improvement over a trylock approach.
> > > > 
> > > > Just curious. Why can't you use mutex_trylock() here?
> > > 
> > > One problem with mutex_trylock() is we don't know whether we ourself or
> > > someone else is holding the lock when it fails, we just know someone holds it;
> > > and we can't wait for someone else to release it when there is a chance we
> > > hold it ourself already. That was the problem with
> > > 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> > > before it was reverted.
> > 
> > Okay, thanks for the info. I also failed to notice the mention of 'trylock' in
> > the cover letter.
> > 
> > But I think, instead of caching the owner task struct locally, you can make use
> > of mutex_get_owner() to extact the embedded owner task struct.
> 
> True. Didn't know/see that one, yet. We'd have to treat the return value as
> `struct task_struct *` to compare it, but I see debug_show_blocker() already
> does that effectively (when I saw the function returns ulong, I thought it was
> meant to be treated as transparent value).

Yeah, I don't know the reasoning behind it. But atleast it avoids caching the
task struct pointer locally.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
