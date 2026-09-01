Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E912C026C;
	Tue,  1 Sep 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256516; cv=none; b=r52TLryZSJ2CSz2nUDF1/6aTZ99j+2EZtygtd18LKXLJlPKep8ygOO3klY9Rwulk+tIWM3QavjaFPKGFSuFMHB7jH0fikxCHlOAHRkmdo++aRTYkHs2mKltKC3rK1VkSxQLQxr+/nFRL3vF6iXEBDUpzpVwYO1T7uqkfB0SZ3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256516; c=relaxed/simple;
	bh=gDveHzA/NWIuLFBTMiyBvJzqv+Et0tKN7ArZZnBmDbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HODqVlg0gfb8iZGjpzqqpLFKAY6KvVsPICjC2uJlmRIuFOCLOUPOPJ13+Fd5I8QMSkqL2NzNhk7YXL3eLoxgUbM74PAmFQm86s8m7iuiB/louwHxnVzqmaE08KlJKnHNcpcgvfHE+aeBDEVAxnX7bMDNBD6IQpbZPCEy78adO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYBYmIoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYBYmIoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E4E1F000E9;
	Tue,  1 Sep 2026 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256514;
	bh=gDveHzA/NWIuLFBTMiyBvJzqv+Et0tKN7ArZZnBmDbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYBYmIoOR+6L6Git57AYun8P71xYTeYQvaLODBqGq8SMinaoXP0u6XAZWbKQ8UJXm
	 GWZoOBhpRnvBbMHzdmjYETO62smwM2rkDZKOZoneJ1/Tiu7m8sDPeg3oimayYwsChN
	 EhTuvY1Np4QI2+6z7YBimRsoYOHDSPekHlh7v5qqd7gxRkSieGV46zKFzy5D3Pu3Np
	 XYuSK4sXMGFAL5gAWTvvny/Xd5YdBtGyg6B92CtBhgnQBq1Nlc0zP5/0+BVgZWv65M
	 Cu4E+XVb5KcLlQYJP0yy4S2zktlazc93J2uAlnPWv9d+IWK+nk1pMkAavhibxve5L7
	 fJLpU63ArhU+w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 17/19] vfio/pci: Add generic PCI error resume
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-18-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-18-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:55:14 +0000
Message-Id: <20260901095514.99E4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a resume() handler for vfio-pci-core. It ends the recovery
> transaction and makes the device usable again.
>=20
> INTX_DISABLE is taken from the INTx state rather than from the saved word.
> The handler can have masked the line after the word was saved, and
> restoring the saved bit would unmask a line it still believes is masked.
> The replay is what unmasks it.
>=20
> Restore the command word saved by error_detected(), unless the device was
> reset, in which case slot_reset() already restored the whole config space
> and the saved value is stale. Then unblock access, un-revoke exported
> DMA-BUFs if the guest still has memory decode enabled, clear IN_PROGRESS
> and replay the INTx state recorded during the event.
>=20
> If the command write fails, keep access blocked and publish FAILED.
> IN_PROGRESS is cleared and FAILED set in a single store, so a lock-free
> reader never sees the intermediate state, which would read as a
> successful completion.
>=20
> Pay any deferred ROM decode disable first, before the in-progress check.
> A failed transaction has already cleared that flag, and the disable would
> be lost. The helper skips a closed device on its own.
>=20
> Until a later patch starts a recovery transaction, only the deferred ROM
> disable runs here. The rest returns early.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D17

