Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741236;
	b=k9um7ARrBAFBLEcchgMWJh79fUjLfz4L8Q+1KzU6fYt9U9SphhWWOsHWdci6AmM7MBqs
	 8Eo4vpmejrfnfp8v36jq0dk+NjV6fANnHx6cxSLSen4LzQQYcRZ1xg1uOhq/5ql2h5mGG
	 HK5Bqvl1FXass9IkEe9lEDj8FrRNRhw0EVxvx6MAkgBBJtDYEezG8PDnEswbLyf9YiMoS
	 P2gbtpWDwxokXDTDcTP/Oc1AnuFjzautJ4JU2fW/6t7OOg4i7iROHUm0sA65v1zH5ua6o
	 K1TiuB0Zam/z0qxdwpH3QTVi6emmnYgnhfyOieA2sxTR4AtiaY1HY8rPt8Oj4zTaImw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BHgAD77McZFx/B4bq23WC5CGoQlhvziBJyi+FjM+Fvo=;
	b=jJUaRTNDScZaLqFJ9o3cjXX/csjuzaXLReKAYGlNd5XT/LiMaMf3Xmy2M7sjIE6inzle
	 EcFgAJW1iTTUNGuxtRdJ6KRHXLpACoYVgCbsla4gHMWzfozvOY3b5ye746N0YVN+rsutt
	 e01TdYx3j6jE/V7vK3o1Rq+9w6S77mQYMcpSHiImqV8dw3CtbAu19lGrUoqn+4Es0XZZe
	 J8FxEUeP2ciSGmBxHuTn4WcAJ9kuHKNcQebDKAHqKo9yM8TiIztUA2bz1+gSZGsahf1aL
	 TuEicTrtVkZUGdMGLqLYnxmNiUo03upwyNaGjNIPOQcACCV2i1tIQoSfmv3epaPEBGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fd/v4hQo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20ED606A31B;
	Tue,  3 Nov 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fd/v4hQo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6D31F000C1;
	Tue,  3 Nov 2026 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741235;
	bh=BHgAD77McZFx/B4bq23WC5CGoQlhvziBJyi+FjM+Fvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Fd/v4hQopj33OgHD1IiG/KaaXnv39zOA/dtzlRYaLlr3y0PHu2YOKO/W6/IbMf5R5
	 aFRDkW9KonqsnY5UpPWFhxMVBwfm9TxxcN9nZilsu5RBaVluNiJ5HQ15R0dvsTzz35
	 LgUY+q9IiwMz9Gz3FjNYpzSwiepEiXK5at7AiEbIiN+YOZC/A4poxjs3VpNdVbU6qU
	 LvnfQfh496o2xePAYFBAJiINFLpKfybQ4pQTXgZWtfQ10QvLI/ZSo3qY8cPQmpNA9p
	 taT+F8tAGOlwj/EgTDksIhrBSwJR1kFyzhCkpVPvDMxwo94iRExmkdEH0tpCzMRofN
	 3k11i/L4mGjgA==
Date: Tue, 3 Nov 2026 15:27:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Alistair Francis <alistair@alistair23.me>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	Alexey Kardashevskiy <aik@amd.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI/DOE: Speed up mailbox polling
Message-ID: <20261103212714.GA1139635@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103163101.1696520-1-mclapinski@google.com>

[+cc DOE and MSI/MSI-X folks]

On Tue, Nov 03, 2026 at 04:30:59PM +0000, Michal Clapinski wrote:
> The DOE code waits for mailbox responses by sleeping
> PCI_DOE_POLL_INTERVAL (7 ms at HZ=1000, 4 ms at HZ=250) between status
> reads. Every DOE-capable endpoint goes through several such exchanges
> during enumeration: an abort when the mailbox is created and one
> discovery exchange per supported feature. Each pays at least one
> interval, even though devices typically respond within about a hundred
> microseconds.
> 
> Patch 1 fixes PCI_DOE_POLL_INTERVAL being 0 when HZ < 128, which makes
> the polling loops spin for up to a second instead of sleeping.
> 
> Patch 2 replaces the fixed sleep with an exponential backoff that
> busy-waits briefly while high resolution timers are not yet enabled, as
> is the case during enumeration at boot. Time spent in pci_device_add()
> for an NVIDIA B200 GPU drops from 45.9 ms to 6.4 ms.
> 
> Changes in v2:
> - New patch 1, fixing busy-polling when HZ < 128.
> - Patch 2: share the fast poll with pci_doe_abort() by moving it into
>   pci_doe_wait().
> - Patch 2: replace the fixed ~2 ms fast-polling window with an
>   exponential backoff that busy-waits for its first ~255 us, but only
>   until high resolution timers are enabled.
> 
> Michal Clapinski (2):
>   PCI/DOE: Don't busy-poll the mailbox when HZ < 128
>   PCI/DOE: Poll briefly for a response before sleeping
> 
>  drivers/pci/doe.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 5 deletions(-)

v1 at https://lore.kernel.org/linux-pci/20261012114213.1757207-1-mclapinski@google.com/

I wish we had a way to use interrupts instead of polling, but it
doesn't seem like we have a way to share MSI/MSI-X vectors between
PCI core code like this and the eventual driver.  Added Thomas in case
he has any brilliant ideas about that.
