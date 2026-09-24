Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDB4A2E00
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273803; cv=none; b=Y5V59m8TfjEeot5L2g9K3Une1krEPYrNGk78YQxaEPwZkhxkBGvoUDAchqFCWqTJ1k5ZWn55rzGbiUlOA01zYduMR9SG7uRwYQl1BRZbVIL6nysmuu3AmcPUGxYiM7qD7kywi1bfQRamqSaadqZq3o2M3k+qKRggXZez90Bufjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273803; c=relaxed/simple;
	bh=qALEgF3PMLUZLEeVRNOgPnt50AvSaoasQ5A/nXs+hb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHB1pKOmwCvjOgF12eLze9LawdJdytLTxV3g28IAGPK0iR+WQ3MdQ/c6S6cNT/oR703GLeGSY6CqTnPA6vy85f9tpVbmLFRbwaKGrAYQfzCLnUOxKdZKbhf8hllgQCk1NjGBF+chHQ4QZ5B45HGHAcnKIBt7sCA891fW8SX8d3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpx0uxLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpx0uxLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948C21F000FF;
	Thu, 24 Sep 2026 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273801;
	bh=qALEgF3PMLUZLEeVRNOgPnt50AvSaoasQ5A/nXs+hb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpx0uxLvkeve/nlv9DC+WhvcO8ONUVGQg9uJ3mtbAYeE7mOUdnJPz1Gp68CCO5eEP
	 VouTwEYQr8NyKl4bnyoDDf9Cp16jOXLcBdBaqWbZGq0v/GNWjXJOjD1uQH0o9Tj/aH
	 a1spncwGI5jtognI7vXy1bwtFspEjM4vTcGMhulOoAfevuPoRIwBldwjrifqu569Gs
	 2WReSynOXooDb+d/P1eyIYGrSlrB/+nXCIYbcpwDwFOS/7V4dXTcSXUiZ2zZow3ieg
	 ekc4RXzt4ymTpFUyiPhW2LcYE2h+mMG28AnlhWV1/xYvzMbjtsnIgAvObckZSfg8kY
	 25vE8M2tDTVfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] PCI/ASPM: Save LTR state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-7-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:16:41 +0000
Message-Id: <20260924181641.948C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the LTR maximum latency registers through the per-device
> saved capability store instead of a private pci_cap_saved_state buffer.
>=20
> Reserve the DWORD by its configuration space offset during device setup,
> and keep accessing the registers a DWORD at a time because some devices
> only support DWORD access to them.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D6

