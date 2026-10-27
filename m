Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131208;
	b=MZPycKDyiSAOmzig0iEeAJjbs9qmwR7b1ewh2aBJsjOf+XIScF/crsZUUx/mKd8rmZC+
	 KaZOX/eFUyGgyf8gjopFohxSc2osyayUxuxiPS5WoS78BhdBeT6w4xllwnsqNj4uIpguT
	 7TzMtRJyZNoELS5Eac5h9aA3ycXy81n3PvRF1oI4O/k6JhlPkWogekbEkcAhKS+IYKUk/
	 VXTkCYZdDq7D8xh/USVNPcWvSY9e+wMqcuilAQEPCOsNaGHg04tRLf5nqoaggxD3Vho81
	 9r3kioGbnNcRjNkxQQcTQwVmW6kV6tw3isMaJgL6wrQiks3HsK6cQqnlyM4hJL7bTjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Kg7+rUKI4CbuvgrwXyYRmdPj7E9QQjVX9EWVuyrXkfE=;
	b=cO3irnGl5wXzQa5niXkU95N6/mph0DkgYWa4cIljEBY+Fs8aTTZmRxrkRN9jh+eAeFL+
	 Z1TIPCU3eReFJnXe481eUZ5WeUSXSxrP0a2THqlFYdRqf8iKmChDRxUtodL+te1gjatD+
	 3ItC2brjroV/gtWgQWXbDXNiBi1+6xjjS9Q7KxNOF/pXDRuMzE7nnrZjbjQNxpPRS8w7m
	 AvgoHKpvt2gUA370a23cQRjvO7vurUlHgkKrG8effhvmxX0cz9WbcO/C6o/2ubXNrjfqv
	 SbuAT8ZlWnO9yvps9klf9FnLswCevORi5nNAMwAKJB5vWrXp26ZRZbC4LEBtEQ3k1Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGYlTApd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB72606A31E
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGYlTApd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581191F01825;
	Tue, 27 Oct 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793131207;
	bh=Kg7+rUKI4CbuvgrwXyYRmdPj7E9QQjVX9EWVuyrXkfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BGYlTApd2J316D5acqGHqnR/Jcc0JuENTsP/vgVcBkbE/CDv1xHZmFx0A6DsSE9jS
	 QVGIAc9O7d9UPMTpu7+dJ+8cgR+BBfgpxLA9kwjCRtxIvcBCe+iVuld4dj/LOPrem0
	 0mTwycCmcw6QFP0+I+qKF8T3UFo4iZgdGoWU6O0AQHILYwgPgx450CgpzbIGlS5rUC
	 EHtRu5Tbf1CgEtL/0+hp8fSIG5Myx9Ijhsym/fAkjrA4BN0zXbPFiFmzfToiTvXlTn
	 hBAwFr3f87UaPRC9stAPROGpeCwJv/QDxvqNGwovgtHeV8P6IJBtdQtB13cCfLn9AO
	 dak1J4/L88kcA==
Date: Tue, 27 Oct 2026 15:00:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukasz Laguna <lukasz.laguna@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	michal.winiarski@intel.com, djbw@kernel.org, brett.creeley@amd.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vipin Sharma <vipinsh@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
Message-ID: <20261027200006.GA474913@bhelgaas>
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
In-Reply-To: <20261027160446.858300-5-lukasz.laguna@intel.com>

[+cc others interested in VF reset]

On Tue, Oct 27, 2026 at 05:04:37PM +0100, Lukasz Laguna wrote:
> From: Michał Winiarski <michal.winiarski@intel.com>
> 
> While the kernel representation of VF device (think struct device) is
> preserved across PF FLR, and the PF IOV state (among other PCI CFG
> state) is saved and restored across reset, the actual VF state is lost,
> as from PCI perspective, VF didn't exist in the time between PF FLR and
> PF IOV state restore.
> 
> Save / restore all subordinate VFs config state, and notify their
> drivers using .reset_prepare() / .reset_done() to make sure that both
> architected and unarchitected state can be preserved across FLR.
> 
> VFs are disabled only after the PF driver's .reset_prepare() and their
> state is restored before PF driver's .reset_done(), so they can still
> communicate with the PF while it handles the reset.
> 
> This also fixes VFs handling during bus and slot reset. Previously, VFs
> were handled like any other device found while walking bus->devices.
> Since that walk is top-down, the .reset_prepare() was triggered on PF
> before it was triggered on the VFs. Moreover, the walk recurses only
> through dev->subordinate, so it never reaches VFs on an SR-IOV virtual
> bus, as such a bus has no bridge. Those VFs were reset without being
> locked, without driver notification and without config space
> save/restore. Now, the bus walk skips VFs and they are locked, saved
> and restored together with their PF.
> 
> As part of this, pci_reset_function_locked() now requires PF callers to
> hold the device locks for all enabled VFs as well.
> 
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> Co-developed-by: Lukasz Laguna <lukasz.laguna@intel.com>
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>


> @@ -5340,6 +5402,10 @@ void pci_init_reset_methods(struct pci_dev *dev)
>   * from __pci_reset_function_locked() in that it saves and restores device state
>   * over the reset and takes the PCI device lock.
>   *
> + * If @dev is a PF with VFs enabled, the VFs are locked as well, their drivers
> + * are notified via reset_prepare() and reset_done(), and their state is saved
> + * and restored over the reset.
> + *
>   * Returns 0 if the device function was successfully reset or negative if the
>   * device doesn't support resetting a single function.
>   */
> @@ -5360,11 +5426,13 @@ int pci_reset_function(struct pci_dev *dev)
>  		pci_dev_lock(bridge);
>  
>  	pci_dev_lock(dev);
> +	pci_dev_lock_vfs(dev);
>  	pci_dev_save_and_disable(dev);
>  
>  	rc = __pci_reset_function_locked(dev);

Today we can call pci_reset_function() on a VF, can't we?  I assume it
will do an FLR on just that VF?  It looks like this expects to only be
called on a PF.  Or maybe pci_dev_lock_vfs() is a no-op if called on a
VF, although that isn't obvious to me from the implementation?

>  	pci_dev_restore(dev);
> +	pci_dev_unlock_vfs(dev);
>  	pci_dev_unlock(dev);
