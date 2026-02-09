Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F62FB630;
	Mon,  9 Feb 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625562; cv=none; b=KAycNK4vW2mVc8yW1bSh/rkqbisxJKofdmmyqtG/UPR3Lv6XD/hmvpbEbj5aaTE567nG1Dibswm1C+WfkFEkkwbASbyIM7PznV9zGIydHJYjyREH/qVYRrs5C/7toL+dTQW3oDzCvZ/KqyFtujIr4m/LMIf7oqznl0nkp43aN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625562; c=relaxed/simple;
	bh=zLhVThzPljwLTRTajnvMpCYxbz+PvWhTCUKb61G9nT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkgZ+pVntkoAIeSBImMSiMR6vkLCk4vBrhiX3OpK2cU5qJw818UbqiMJEVN/9EBIV/gHsZSHAjkZzZtDrW8xV7rfYsb33W3FdA5zI2dvXXLXKfdRbrCI28z4CKTNDvsehVdItK4V+29Tj7PutKnRL0IPwwnDEJQGJbGfUqHFKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yd/+S2iz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6NMjjoS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yd/+S2iz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6NMjjoS"
Date: Mon, 9 Feb 2026 09:25:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770625555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQru1QVwwBxQ1QprNeKO9onFJ7snzRA+BrEtytM1vXU=;
	b=Yd/+S2izGJNl7zQ20/n9byKRVsMciTEbxnKCN9ZfJ7whSRs4M23BWEYadjrRXaOtIJ86Ki
	d8m+LkXBFee5EGr3wTZ8WC1az8a+q8LqVZbg7xHOuJB9bnbhp3GnBccNjq6QUaP7dbpx26
	6+gbZ2V40PX2p+i7w6xn8yg+rwmyyPAUn0fXTLoAX58fYIT5pIjnECsLOQ7ouQAsR5ozKT
	0V/Z7jO0gSdEqlpwOWB8+4v1N5LoOKDyru+K4oIwhqHvxnqD5ar1/tnlXPj3OykxxpxRNl
	Bg3AX0V80cNwKmx7Tb4o/V1uOYJBmgN+yrSoR08MN/pg154LS6vNmx/WjUVrMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770625555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQru1QVwwBxQ1QprNeKO9onFJ7snzRA+BrEtytM1vXU=;
	b=U6NMjjoSauuHtRHZIjGGCMDZiRhnsEtu5EehGOt3tOtUs5OQPGUG1ZEpO0wvgixka3ucrw
	6zXVFiV/s9Ku3pDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH] PCI/IOV: Fix recursive locking deadlock on
 pci_rescan_remove_lock
Message-ID: <20260209082553.1pnF4lr0@linutronix.de>
References: <20260209075706.16367-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209075706.16367-2-ionut.nechita@windriver.com>

On 2026-02-09 09:57:07 [+0200], Ionut Nechita (Wind River) wrote:
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

This looks like the result of commit 05703271c3cdc ("PCI/IOV: Add PCI
rescan-remove locking when enabling/disabling SR-IOV").

> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Sebastian
