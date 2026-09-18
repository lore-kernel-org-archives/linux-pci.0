Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45D49F123;
	Fri, 18 Sep 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762543; cv=none; b=bF1UvCj78EywH4mIBullegsXf3l9v7iJqAxaWbnpD1Ez6MbNFSM3zTrUcQrWqnXjIwo+B6TJcYtJaayF8zPHnL9qpqcprT1CjO9kD3CJLjqrSO8GKBRsv/mAilBj40bnrLJ16VlwPxAdbub2Bcosp7Wl/DTCi8FpdoPrdIDuEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762543; c=relaxed/simple;
	bh=OAEsOLRukFLus0d8Tfr9V8PlCCQdG3TdiUlAGwmhXjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=epAw9ilMFd/PqdF/aWArW2MB4SskrNVoOafxhLYz5BgiFfjYeQlClR8khjykF1w0wf6lpdMxHvkGinwDJW5PIgWL5rgU1L3z4TJFijWF90PFrvyNOoUC262ncS2gW6z/nGvvIuYtqKm9gobwUB9PoQi2y+/cF3MgmN0tcz2JDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K//zyog2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K//zyog2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B171F000FF;
	Fri, 18 Sep 2026 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762542;
	bh=OAEsOLRukFLus0d8Tfr9V8PlCCQdG3TdiUlAGwmhXjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K//zyog2V0U5XIgFvmnnIv4886FNdZhDLQofPIKBTWXzdsJ0WqbwVY1MECT0yYu4i
	 4ZqWxbUzkgZhfArlZn0Ohx4LFYwze/+QQeCZfTSuZe8bXffQM+TkOo1vajLxH7QWKH
	 pCzk0jC946j9ZqV6KNZOaQ2HQrhA6m3AyVuiamOMb/3xqlTrQVp290o5zWsY95idWy
	 G4mybv/5QF7JoFrCjTh9fQg/QiTBsGdTVOxOAnuaP9GraJEAjOSmEDR2ncBnMgtL/M
	 +ED9/D/rGVUXvb46t+ZZKpA1vQI9jjyYFR8T2zFltuShDIyWw8pfajQO7Jxf92LGze
	 zIJGv2d2yxv/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-mm@kvack.org, "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: "Alex Williamson" <alex@shazbot.org>, kexec@lists.infradead.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David
 Rientjes" <rientjes@google.com>, linux-pci@vger.kernel.org, "Lukas Wunner" <lukas@wunner.de>, "Parav
 Pandit" <parav@nvidia.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "William Tu" <witu@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Chris Li" <chrisl@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
In-Reply-To: <20260918200640.887030-9-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:15:40 +0000
Message-Id: <20260918201540.64B171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save the ACS Control register in pci_save_state() and write it back
> in pci_restore_state(), instead of recomputing the ACS controls from
> scratch with pci_enable_acs().
>=20
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>=20
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS Control register there as
> well, otherwise a subsequent reset would revert ACS back to the
> configuration left behind by firmware.
>=20
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>=20
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D8

