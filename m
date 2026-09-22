Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C3391822;
	Tue, 22 Sep 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043408; cv=none; b=XemW3C11XWU9NTXgsheu1mpdJqV0l+6gkxEAvAaxw6G73q7I2tLkkM4KV8LXlsDQ5KfWb3SsHvckf91Ny90bb0tY3YVlS2Djxu1Jx1LoCDaLI+pwA6mySTmQdflM1F8KkUxO0AXmXJ3q7KIS8u1Nykezr0oV/pC0FaGWO7PFzfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043408; c=relaxed/simple;
	bh=PUd6Aikm5rBUoW04teTOIzspzrtqwHW74ijiyeJejxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN/6ooAoDLO+Mmo2dXy2pcBoa42XoGCe6sGUGFU6OJBS7z31qxv31DLME/Rjg2wWxYW4jbjJY8vG/TmZkDxubEx/TzDQou6FDx4/7y9B93d5ZkARCcIcX/FU4mcZs3SqixUzCahsgDhF48uIQCBl9N173x+KIDut61Zvu7akr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JZ+rmHN+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/KObVqI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JZ+rmHN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/KObVqI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 949421D00061;
	Mon, 21 Sep 2026 22:16:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 22:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043402;
	 x=1790129802; bh=TjQc6e55aDuKQY1afXLkKUqIDRWNh5WQIFwfdlQKmvU=; b=
	JZ+rmHN+V9PK4R1DFg79/aWnOcUzlBvSh7L+NxLTWtar2mOkJMLUqKNaqKi0x/mu
	F5BSZV9oosAnL924S0KXE4DjRLkA0DvSH7JefF5HKYZgdExaE0HKaUI/GLCDtfav
	reSM3fh13dPvTFzPfneI77hZ0ouSm2kAmOXU2V6SlQjn3tIcHB/O3Q91TfuPNMdn
	Ht1FoHpXqyALSWapyYLcEdGNjSNVGVXANLvlJ2z2JyBq/eofoYZ+os3/EeatGj1b
	0dU0i72O9u41vPOJEPPucvuwAzAfnEl9j9Cn85SeRepPnPkhqzRhwwe7VNHjhCAx
	xvdolc8w2XaSITdEWbY8sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043402; x=
	1790129802; bh=TjQc6e55aDuKQY1afXLkKUqIDRWNh5WQIFwfdlQKmvU=; b=E
	/KObVqInDIw98+ZBDiGvy8OuGw3QT7PfYepaYjRxrSdNWZxpdvS6MCXHHsiVHEs3
	vN2x89x6WlHuJWnPUrTbKyGFD3p2Q0VYQ+ap44RrConGDh55V4vZppagXH/jVrAS
	F3b+tga1rC3etEXQF819KahaFquzv7eJJRFpAI2NjK802WXc4DVpiooVHOxUYi5W
	0Ji3Kv5C1ITdQlm4ZodjzqM63Gkg1t83ATVSakFxZPS2xtsmqss/VptoYL5objWZ
	L5ArCmm4xFuj9aXhuZ2Pgt3oSHMEb1BeK1D4GFSjrJ3HlcVLLi9SbEFeUFquVNNA
	k9fV8X3kGlTNT3RSfOXTQ==
X-ME-Sender: <xms:CuWxamFUMfvp0JwMC7Xky-gqJCEvLAH55a06-jWrPK00x8Ek6fKm9Q>
    <xme:CuWxak_O23qbGit3yvhY6VJMuOZ35M-CknY0MAo4t3wq3ZDi-UBTih5XTz4kaVI5v
    QTknffeawAa2bWk571oteYLTa5PCojL12tNcEoSbFKyMp2b2TIHsg>
X-ME-Received: <xmr:CuWxanhj_kz0qr1yR-e_FoltHGelCelSFmt7C_A5H-NRvr6T8xrYxHB3NMZwHA>
X-ME-Proxy-Cause: dmFkZTFq4XdQYKBFcgQxzxj5s/+a0Bb1zYvMW6R9nZBkBjq3xEQn0OpvbpfR9Z5F6C9ib3
    5cM7Ngc5p6Fxg1RGkUzWtscOfcG+beGsHDoqPoJeeGvROusMzcPRgJqdNxOiFy97z7HUjK
    lW3M4TnfSXr4yigy+w/5DXukgCNL1dPVG1yVjL+np5m/HdbsZrB67SvR1q9ElLJ0WaZu9I
    j9aqa5VH0BFThS96ALwZcg5XllLdm3vp6GbMy/c694A7qUFd43jPGn0x+7NKObzopjdZNw
    T4rtlx+MSImwyNWqquFRIwclR6oeHfT5L1h/IbHmIrZeMrxynlhTErqVwB1fKqFBg7c6rE
    iQMiofPOwGp34oOhv0Lkp2N7J9btNzoGtyd1OXy7eOeSKEColytGNe4FcKs537yILjGWYN
    kqMUWWEe47z1mg2dqzcx58diKCGD1CNH+1CiUkLmue+J3sroq2hHYnkxdgART2pUGf9mYc
    B83oYcMRp82nQ2LyH3EKYmRC1oSMGIUjiPMTBswLuEXKhJ6wP8CNTyVM5fNUDVrTvCqXJz
    p/yMAiJNaa25Le+kC07y5qL+FHiXIX1jSbgWoiDvL3Q4FoRPZ6Dj+leqjZ+sTYDwA262Bg
    sRLsAysQd58NxBYKleQ8DaXJ4nQdtFo9U+JbQqWyoPElAn2gm3iYMzPTqVKA
X-ME-Proxy: <xmx:CuWxaoT2deovv8dg1HPbeC5wk5l66vX1YbvN_xhk8Ys3LiW-o2KkuA>
    <xmx:CuWxakBGTJO4iZMPn2AU5eOPPtOx9XAQoX0NGU8CQYT8lNsECortQA>
    <xmx:CuWxai_qJmUPyNgbuyHtCVYdGov-mV1yC5b12CuPyXVH_Cpt7LA86Q>
    <xmx:CuWxau06KrjaE3encua19gQeph88H0vuZVzxb2orALJnh-EzAg1W-w>
    <xmx:CuWxarTZozOisuqLr--i6KIFQOQI76y95M5ztdR9Uu8wNBmNTU4U3pI2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:35 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:14:24 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Message-ID: <20260921201424.23fdd140@shazbot.org>
In-Reply-To: <20260916183540.3813685-17-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-17-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:29 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> At bind, build the CXL memory device for the passed-through Type-2
> accelerator so it joins the CXL topology and its HDM region resolves to a
> host physical range. A Type-2 device has no mailbox, so there is no
> media-ready register to poll: set media ready directly once the component
> registers validate (mirroring drivers/net/ethernet/sfc/efx_cxl.c)
> 
> As per current vfio-cxl support, reject a device with:
> - more than one HDM decoder
> - interleaving enabled
> - whose reset the host cannot service
> 
> The CXL-core allocations are grouped with devres so a failed bind unwinds
> them: init failure falls back to plain vfio-pci with the device still
> bound, so devm would otherwise hold them until unbind.
> 
> A low-power transition would reset the CXL Type-2 function and lose
> its CXL.mem contents, so keep it in D0 while it is assigned.

Is it the configuration or the mem contents?  Isn't it the user's
problem if they put the device in low power state and lose their own
data?  If it's our problem, what are we protecting?  It's not clear to
me how we can save and restore the HDM state around reset, but can't
allow low power.

This also undercuts your patch 12 justification for the open/close
hooks under the rationale that we cannot sample the hardware while it
might be in a low power state.

If we do block the low power features (less desirable), it should also
be at the probe and dispatch level (-ENOTTY) rather than failing the
SET operation with -EINVAL while reporting the feature available via
PROBE.  Thanks,

Alex
