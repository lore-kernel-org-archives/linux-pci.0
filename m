Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632E4B7159;
	Thu,  3 Sep 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446096; cv=none; b=klukgqqumRQgOauYz7s7BKMvw0kpCVDnevszEFib4g9nvF6JKrllQ7VeU3YQxJa2RkI7aYPjABJpRGdD/EGgBEz1yTGOFTITkFtDn5neb6/vOvnoUmIaTkU+lVbIiJTdtq5hZAB2LOmWNQ/A0U4cV9cfH4x/ctEYQtfbDxcBdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446096; c=relaxed/simple;
	bh=tDu/OtNZfCpMs4IBjznZKW3+fHoAfYxOyVLxIv/hZ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIfbVXRkZ69vJeeafpcFevscX3RTDcqZtwOYAChO66V9qvHCdojLRtT2ijD7OikxsBK2ljlyWOkUbFFk/CXl1Xi5Ofl7agTt5PD6NU0FnINmB91Mf6CPcxjce5eZ3X41u7xSzq0wt7QzDG0Xgn6Sb/I8t4uX5Wq5gn9Bo7Iclk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HnTiJpUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pK7J5HTP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HnTiJpUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pK7J5HTP"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3A457A0168;
	Thu,  3 Sep 2026 10:34:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 03 Sep 2026 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788446086;
	 x=1788532486; bh=jkPsgxrdUo/yI6IB9i0aykXCCeynVlJ7JFdE1XJ72+c=; b=
	HnTiJpUYevWNkaLIrG+apwXsZ9v1WNLXd41czaF06cTbTvkQ4l/MM3iwTShvaI6A
	EdV640PgNHpdb49Ppcu2lEr/qcDfT4kG7IZfgMR3QV2ZrMiEOlpf195DylnoXaY7
	rprOJtW+PTtRkPMc8ZqZ3y6QYngEjJ/4Gag901QlpAggefj/0okdfFnnPp498JJa
	hsnjDisSWTDwTdor8uFAZTUc4EwtvjiK/qrFSNiAC4yZYxFjZH0bfRhCsM3pq/Rl
	CohdpyfMKzXvXpS/MtKnz1z14twThjjAWtki/lpiTaVrDN/i9L4ce55ybU5nANsV
	k3j3L6EXPV3cn4i19P+7xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788446086; x=
	1788532486; bh=jkPsgxrdUo/yI6IB9i0aykXCCeynVlJ7JFdE1XJ72+c=; b=p
	K7J5HTPNntg9ZOQVH58ws0eGw7QCmM4s4YiFs8sv5Ag1b+PWBggAcXrWlKqmE24d
	upp0ZK8toHLqKeYowoYb+1Nf6YFUCqHTVizsm/xdsBUi5jk8hCc8/gVjzjoQm3zZ
	LkVqtVVuXX5uhNi9ORq0OifzwVf9MqDqgXE4IC8LJXTheQo164hzMPSeiUsdakpQ
	5KlSsMf49PiM5mXN23dHIcT41gPeAlNgF9eZjyKtAQbcwGZkMXKp1FlJTMfsgr2/
	aY54XkFY9K0s+FkPHEtuBoqoQVFt/iAEsRHFBxlog5RRTW7rZtLxKx1+cI4FqpZO
	ZJFilpZM3JZdcrnm+XWIg==
X-ME-Sender: <xms:hoWZaqQqEjtDFXr7DHOAVVKk3Y-GLgQka0n6Y9tRI6M99CnLFcAnOw>
    <xme:hoWZagfu6o41hKGSR91n5qWQre4kphGsRT3aKMtp3K9BTTLW2_qodTfSuDNQqJ17j
    Ou25s6kSQ1VZ2rZpPqnfM7btAH-PQkkUvBpuvcfLwQlKZMgspYVfWPu>
X-ME-Received: <xmr:hoWZamB3CrQoiEYSMJ2FYWbo6mPjI2-weRB7QdNAtqArA4emH7jIF_KOikdryA>
X-ME-Proxy-Cause: dmFkZTGNs518BxHDjPsgODu7+rk8I8310115ahjA8Kf4xaZ1ZHDYQiHqdF9WRv7QrQyFTw
    G5mjS4FW50fFbqhYW+rQL8tAodunoQC3QxcKnRn0aAK9lsfj1Rw+O5ulcTq520uCW4C0fd
    pzrsIBTcLX6ROQXiceR3bUHa65RBXuR29MEbIfyA0pAdz23WPTbfWAXTzV7A8IAT6T7M9E
    lzsp3BdmCJ90j3o532WN6drKvceQ4eXfilhFI3gI526q+v/Z3zW1uo77wtNbM5mxZrG/DL
    8P30sFLIrFfbrPYoC4fdhmpx1oVNdOaUFcbNAVTGZEl+FxLl0jN2PvHvfDsBRvJ6GZMoNP
    CzoC09WoIBGDYlAuRFxeyOZyJS097kOdwgYhDD4VVVOzF9HZ8GSwlGxZctSW5lelz3Abku
    ONYso1NM5yRilmrC5Wm6k6ZIQGNLIDEynt8qDmGLNJgdIErFEC4i38cmfz31thAwWVkuYN
    FJvJEoSx1xsquPOZD+mQ9zJmjYkVlGTSkA68GHc4Gc4CB35ndsvDX/z2v+q31VXG6wKmhH
    QK7O4nRp0jleGA1Fue+1LLx3EoB++eLto+tQwCqA/3ef9ItUp9wI8DTY+ZhIKj4pJesfcC
    vFlLaL7oBHMeDVCwEcjgsqwf4LYs50Bmu2MEWsGeVLX03ofSPL3P/l47tOLQ
X-ME-Proxy: <xmx:hoWZaqlzgq7XPpL_RCwjNkiL2MupML6roZNBJUE4kGXrKWgn1TuULA>
    <xmx:hoWZapdwGyNN9u5zZ0KyLinCo8M2BLQtmGoEewoLU0MjSVPGtoUFVQ>
    <xmx:hoWZamSVc-W7DXA1WZ-_d7Fi_BRKtiOABQOwcgNpwrJET1YTM9nsfw>
    <xmx:hoWZaosxK47ctAUHuVx5leHwRT3tGMpUZiWvM1OrYx60oQXMesoVKg>
    <xmx:hoWZalXLrNYfpecMI_Ors2VZka169KTHxV6JZ6hqrzmPf7pGPQLHh37X>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 10:34:45 -0400 (EDT)
Date: Thu, 3 Sep 2026 08:34:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <20260903083443.400dfdc9@shazbot.org>
In-Reply-To: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
References: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 09:30:49 +0530
Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> 
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. Reading past the mapped MMIO region is undefined behavior and
> can return invalid data.

"Undefined behavior" still seems an overstatement.  The code violates
the API contract, it should be fixed, but it's effectively harmless
afaict.
 
> Fix this by increasing the mapping size to include NVME_REG_CSTS.
> 
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before
> FLR") Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
> Changes in v2:
> - Changed the commit message to avoid overstating the risk as pointed
>   out by Alex Williamson, to be more accurate about the actual
> behavior.
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..ed03892cc960 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev
> *dev, bool probe) if (probe)
>  		return 0;
>  
> -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
>  	if (!bar)
>  		return -ENOTTY;
>  

The cfg variable is no longer related to the mapping size now, it
happens to be the same size, but this should be sizeof(u32) to avoid
confusion.  Thanks,

Alex
