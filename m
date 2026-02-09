Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F681E4BE;
	Mon,  9 Feb 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653685; cv=none; b=h9bW+wnTQc4vUT2OFdQ8O7HitVsZhDGWpkM95/LI9L7aQojOx+QVyC+/28NYc38l+J8Wb0rru8m5KlrXJobvKIDUsbi1JczFCcKRtNPkaWGYx7wfglzboKYlAivdYw/gp9eE00wbmhGbvSD69SBckGuMvtT0lFnRsLnyqcD6iiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653685; c=relaxed/simple;
	bh=b2TPsmxdQMk2Ex4EeMombzToSZ/cZjYHlP9KEr//fjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oFUWEuP3LR4p9QwKB+IGM1m3YQm1xkzIXRXqnxEaHwJg2WbEkiD6SrhY2bSsi0aigASNW67plwnEyuRLKYhwm1Ict6Xl+UXqaG/f3cTlRWxNZI0N3Ag/LNTMigXh+ki+zRkQumEhw1YB/jG8Uyl22+fnBwv359Ka5hqa6Xzyl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAl4NaLO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAl4NaLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDAC116C6;
	Mon,  9 Feb 2026 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770653684;
	bh=b2TPsmxdQMk2Ex4EeMombzToSZ/cZjYHlP9KEr//fjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LAl4NaLOUKpkeXXJvP3vp3b+yWx7cuQSHIzRYm09Hra6pePXTT0Eotq6GVLk2B8Ir
	 +jmk46QnTCrk4FlPL6yovDzUtJ3I5c8HNVRQm6b4A/Tpu5rg4Wx5R99B0pgbHGLgE4
	 K8s41WoVG/0uIh7PIdIGlZ/fh7nsxtSEYlqsXgZvqJf6U12pZUBbmQdM7s76DZQEmg
	 lSGml/I4QqZOLhagBEjVAUm6JmojskhyFUgXxnxdb67pgyIv5x/JMYST0RXT8lG1XB
	 xjjqMFjy/7LdSrqJc0eaBJXAXlck8Lbd8v4/kSs94dRV91VuIaMW1M5XmgdSRMXKgk
	 ho+/z1i53fLvA==
Date: Mon, 9 Feb 2026 10:14:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH] PCI/IOV: Fix recursive locking deadlock on
 pci_rescan_remove_lock
Message-ID: <20260209161443.GA190606@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209075706.16367-2-ionut.nechita@windriver.com>

On Mon, Feb 09, 2026 at 09:57:07AM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> When a PCI device is hot-removed via sysfs (e.g., echo 1 > /sys/.../remove),
> pci_stop_and_remove_bus_device_locked() acquires pci_rescan_remove_lock and
> then recursively walks the bus hierarchy calling driver .remove() callbacks.
> 
> If the removed device is a PF with SR-IOV enabled (e.g., i40e, ice), the
> driver's .remove() calls pci_disable_sriov() -> sriov_disable() ->
> sriov_del_vfs() which also tries to acquire pci_rescan_remove_lock.
> Since this is a non-recursive mutex and the same thread already holds it,
> this results in a deadlock.
> 
> On PREEMPT_RT kernels, where mutexes are backed by rtmutex with deadlock
> detection, this immediately triggers:
> 
>   WARNING: CPU: 15 PID: 11730 at kernel/locking/rtmutex.c:1663
>   Call Trace:
>    mutex_lock+0x47/0x60
>    sriov_disable+0x2a/0x100
>    i40e_free_vfs+0x415/0x470 [i40e]
>    i40e_remove+0x38d/0x3e0 [i40e]
>    pci_device_remove+0x3b/0xb0
>    device_release_driver_internal+0x193/0x200
>    pci_stop_bus_device+0x81/0xb0
>    pci_stop_and_remove_bus_device_locked+0x16/0x30
>    remove_store+0x79/0x90
> 
> On non-RT kernels the same recursive acquisition silently hangs the calling
> process, eventually causing netdev watchdog TX timeout splats.
> 
> This affects all drivers that call pci_disable_sriov() from their .remove()
> callback (i40e, ice, and others).
> 
> Fix this by tracking the owner of pci_rescan_remove_lock and skipping the
> redundant acquisition in sriov_del_vfs() when the current thread already
> holds it.  The VF removal is still serialized correctly because the caller
> already holds the lock.

Ionut, can you confirm whether Niklas's patches resolve this deadlock?
The following patches are queued for v7.0:

  2fa119c0e5e5 ("Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"")
  a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")

They are included in next-20260205.  They're probably in earlier
linux-next kernels, too, but I guess linux-next doesn't keep older
tags anymore, so I don't know how to figure out exactly when they were
included.  I put them in my tree on Feb 1.

Bjorn
