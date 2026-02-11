Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC83570B8;
	Wed, 11 Feb 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802658; cv=none; b=dC0RY6FSl+xwU6r8jh5be887ImzDZPfvpTzwg/3dWeVKEv6YpOw+NlTZnSatCfywXribEGAcvCA+uakC9fUgyeiskYn7uuGFckVPsVcRBLEiiXuRFai0tgqi9vMjNCM1z2l2XVqgq09TBZNpVcPP9d60XkQQYMycXO4g73NLrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802658; c=relaxed/simple;
	bh=FV5xuPguYBYFURjVpVz87uE2/rAaXpG91I7lexbciV8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lNLt/kGznDrNCfQ8cNDSIJgWoPMys+itCN9ceGH6JfP2LpDWCTY4EP30GUL0PPZCnb0aYpRhOcevW6ybADMuoL/n419fMmgVR9QhkeDt+YhIG5CTcTERvWhBzXPqB0JOqdmTgXXmbN6IwC4+Hf0RbEWYnyh4xIWOmGE3Mn8x1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SHuonGCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wrDgsdvq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SHuonGCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wrDgsdvq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D67E7A012E;
	Wed, 11 Feb 2026 04:37:35 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770802655;
	 x=1770889055; bh=X+qq6VIT9X4UgpzRymu7NiKF1AW5uRoHTQ60MV6HtpU=; b=
	SHuonGCV/XoCGvt1et9ewvyhSUXZTWeh8UJlgfv3oCa/RN/PJdxaxjPthvo6wFxL
	8ygds3x7T+YxQWW5xft5h/liW1p2XrcQd0uQL5JSi6BTEih0NFIB1OplG01PX4B2
	Jf0W6zKucsfl8sTR6Sy1lCqvk/reCcKVk1iwO12BB2caQCvTCWI5MXeAT6PfFZ32
	oUU1shlQBdkMy2qpl+B6FIwTnaLdCMVEIayxLzPdlzjuCgJllDVZvjcy1RFuFSAL
	WT6BHALxDdJrC6LQa/vXFsoJs+SdTS3jE1+LnMo/yVpm7C39aPdG1AOn43fV3QGA
	9yPQHwhkrIYaC9KSb/WYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770802655; x=
	1770889055; bh=X+qq6VIT9X4UgpzRymu7NiKF1AW5uRoHTQ60MV6HtpU=; b=w
	rDgsdvqtJgHP7XP7z61/1r2EFlB3cbAmdVaFHtmy8VnqdLWWpBZXhUEUW6DOt0LR
	jxyOyHByyzskkBjKIochzFIvm4uihK+KCOnHiMN/HmABDTSsDisWArcWQS134fD8
	s2fnD6+TFEnuFmB1U6eeBuRYue8/do4ggVHJoDOd5vApgTOe2DmJEURlw9M3c8AH
	Ai8TlJTsnh+QqxCQfJi2aM8d5opycdtVg0usFVLk6Jm3nONs08+Nkg/mO3vZhQw3
	zML+SjoCiw+P5PALjT39aPAhVKj7RKb5dtd/KZd9oOKe/W2DRtBV0i3JRC0kn+OU
	OAyaWcLYsiAsDV9mVJaAQ==
X-ME-Sender: <xms:302MaYI7Zm4YoR5PEJ7BFFJuU80vpbAFaaBj2Yao7MMb-WM2tbf-jw>
    <xme:302MaS_2ZE6S-_VcmUjitvE2HzEZY05_hZNfddEFPzX2l2ghoy2fgNK3IAgW7gMEv
    BOOtNBpuJPNO-Hec3mNbKE7Z_XRrovH7Og6KSATtBNSVwYwfwtkyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhishhhohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkfihilhgt
    iiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghniheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:302Maa1V1kWnd3V8PkSXAHpZc8WL9YS3p4B-iVljXdxOfUx7yLyqQw>
    <xmx:302MaTFguicXgrBjLpmJ8TTE-apGviD416A4KLIum_FhMzbR3gO3OA>
    <xmx:302MadtjsxvSR408VT4fCO8Hzr1yNtIvoqbvLe3baHx0ohYmU_9smg>
    <xmx:302MaepWbrG5blPoVk2M49z8XdG2l37ag4bil2z-qhVkuFCSD4mXBg>
    <xmx:302MaVailoP-Y-bjfJCtm2cXO_BBrxqRnBo1qPO0Kj1WVDKZVYhw0E7z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11820700065; Wed, 11 Feb 2026 04:37:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-gRaPN3nuPV
Date: Wed, 11 Feb 2026 10:37:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Manivannan Sadhasivam" <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Damien Le Moal" <dlemoal@kernel.org>,
 "Frank Li" <Frank.Li@nxp.com>, "Kishon Vijay Abraham I" <kishon@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8db96e1b-2559-4966-87d9-171854c6ce19@app.fastmail.com>
In-Reply-To: <aYxGR-x3lGt7H1dp@ryzen>
References: <20260211070812.4087119-1-arnd@kernel.org>
 <aYxGR-x3lGt7H1dp@ryzen>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 11, 2026, at 10:05, Niklas Cassel wrote:
> On Wed, Feb 11, 2026 at 08:07:40AM +0100, Arnd Bergmann wrote:
>
> However, I remember that you Arnd was one of the main reasons why Kishon
> decided to use configfs to configure a PCI endpoint controller and to
> bind a PCI endpoint function driver with a PCI endpoint controller.
>
> I don't know of any other way than configfs to bind a PCI endpoint function
> driver with a PCI endpoint controller.
>
> To me, it seems a bit silly to be able to build PCI_ENDPOINT without
> configfs. What should a user do with a library that they cannot bind to
> a PCI endpoint controller?
>
> Why shouldn't we just do something like:
>
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index 8dad291be8b8..d6f898094509 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -8,6 +8,7 @@ menu "PCI Endpoint"
>  config PCI_ENDPOINT
>  	bool "PCI Endpoint Support"
>  	depends on HAVE_PCI
> +	select PCI_ENDPOINT_CONFIGFS
>  	help
>  	   Enable this configuration option to support configurable PCI
>  	   endpoint. This should be enabled if the platform has a PCI


I think at that point we would instead drop PCI_ENDPOINT_CONFIGFS
as a Kconfig option, since it is never user selectable. Otherwise
this is probably a sensible solution as well.

     Arnd
