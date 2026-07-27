Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B014900E;
	Mon, 27 Jul 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176492; cv=none; b=ZMiE6Dmzfj9kOVpVCd6hUEIdW5oceDN2gss+JN3rEmqKCRs6Xbi/G4Xg9Qqb30r+pc/5xU4TYkhMRCfTmMQr9eVmc0xeRnTNzBKq40TuVBsEEmcBZi5Nh1ilGWHMXBpJXOD1vUhULn8JoXmHqmSPiJVU8HH9YOtRmMV7I6RundA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176492; c=relaxed/simple;
	bh=0CW0cgH0D4K9wwVT35wNjW8fjY+Z2HkZM5AHn0mNP2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WonEwUTH7Jz9CIvR0CFVAEBHNosiAP8jXXZpxuhEAb/N3nERfEBwGvGZlFJagQ5B2ePG8qBpTr4+73lClSvMxY5RCcU3y18eIUZLcas0TjELCDABsJ7CpZE/sWLg8JyNNcEP12tl6EQ1g/Zblnafrn3Om0owZhj05rJxaG+RtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMafiBv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMafiBv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C431F000E9;
	Mon, 27 Jul 2026 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176491;
	bh=0CW0cgH0D4K9wwVT35wNjW8fjY+Z2HkZM5AHn0mNP2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMafiBv7mgwhcisjJcXq8x7jtVwOxO+3hEwkZJd7a6tF53LkXojQ5QyjbUj1trMpz
	 UiYqOQhkQCAwYBeaSvDRhgr2cr8HqsUdua8z8RDDjoYz/M2NJGy64bdoPJqc8Ci9sB
	 w4n1j6cEal1s+ZRhlJb5UsWhzpZsaukir8WfcAzrKrkhPmE25fRyvkn++q86+jRLuV
	 aPyOiqBRiKKz2n1i3MH6pR4vSfF4gAS8R098/UK1UnYgQbXv+HEs33AO4KBKEoyMYm
	 xRyOlr8yXzfeqZRC2N5VwouRF8vlzQwd0vJUyhNM/fqRVLFZzhbXA912V7qf6Bj9+s
	 9lkFVk3LAbE4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/6] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260727174837.6645-3-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:21:30 +0000
Message-Id: <20260727182131.16C431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> switchtec_dma_alloc_chan_resources() returns directly on any later
> failure, without ever freeing the descriptor rings and coherent DMA
> memory it just allocated. The dmaengine core does not call
> device_free_chan_resources() when device_alloc_chan_resources() fails,
> so the driver has to unwind its own partial state.
>=20
> The device-removed check also runs after ring_active and
> comp_ring_active have already been set true, so a failure there left
> the channel marked active despite alloc_chan_resources() reporting
> failure.
>=20
> Add an error-unwind path that disables the channel and frees the
> descriptor rings on every failure after allocation. ring_active and
> comp_ring_active are cleared under the same locks
> switchtec_dma_free_chan_resources() already uses, since the completion
> tasklet checks comp_ring_active under complete_lock before touching
> the completion ring, and a stale IRQ can still be in flight when this
> unwind path runs.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.=
kernel.org/T/#u
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initia=
lization and cleanup")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D2

