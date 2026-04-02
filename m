Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCE3A4F3B
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148989; cv=none; b=isxY5W/2ZAA+Mgb7J2utTstN+qTBDh7QGE7mQD25ZILIH75CuZNVZrfVITsb4WnQ/ZLeXy8WKq/Mri2m5Yruhp6kU5iJIFDbLAkPO5KBaZ/gAspqeKZ1OvW2XwyyLPK3cLYZWSp7RXM2Fgkd1Hbs+f0FajrehcYDRlQ+gYiN+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148989; c=relaxed/simple;
	bh=9uOf4g1KrKKkukUwtxV1LdVcZ60y/Gtl6Uuhc4W/NBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lOrYjyfviT3qK/ot30VnChuxAVS1u+3nkF11NeIBkWrbcFxNA6DKEFBpry0AUI1dK7iNcuOfjfqPmkzf4eY0bGoylAN/QqeSrLoCJOYJbxvsHpe9bD0mC+TTITn7A7zJQt52rPy5d5JKd1N6hYBzzg5WsfhwNioJ+k/NgDQzOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=BMhlZNV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlwdLY9y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="BMhlZNV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlwdLY9y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C4B501D00177;
	Thu,  2 Apr 2026 12:56:21 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Thu, 02 Apr 2026 12:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775148981;
	 x=1775235381; bh=Bjw63Ft5vjZ9JKJGfe+wNu/ADyLXxDI8B8fkms/aiVI=; b=
	BMhlZNV6tWN0ru2v2xruuuD9J00ZAZ9gasCyI5Z02HBLYVQ6bXwlPsyj3QPp7C9S
	q2yJFSruLCgNQv7Gdsg5q0LiL8Sg0mtV8L1EXaPieQwos/PI7naTH/ckec/CtADU
	C9fFo1KZgYRcD+qs+w1XFYvGEevC7LvLk+0NSt6UQfsKmKekQIzlm8vgw3i3Orcf
	0Lk4hEX7r8q/I7sYRXMX6U8oTrl5+dhG+enCrDR3RYGQNN484d/rQ62E4ML5KzS0
	39ae+vuS2bT3UuI5zDdsN0Iqm6xbFnWSG+YlrXeUUPkWX+rZIJY9fDZPNuQLcvGx
	DezERHPgMfoV9RbedMU4rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775148981; x=
	1775235381; bh=Bjw63Ft5vjZ9JKJGfe+wNu/ADyLXxDI8B8fkms/aiVI=; b=G
	lwdLY9ylSsWXZZq4WVI4afUsaPlpQlh0FKcC5Fim6nwISWRCjM/tD6wdJjrxK5QD
	OeMc142Vy12h9IQn2dxDWoe6ZhOyZonVXCwXa9ZfA8GKU9enAFeVWMYFhqp/sM2a
	FphR5IiP2cOlWF8zpmlPCGqQrwQBDr/d0urKCQNqjdp2Zpc8Zy2xEJjE0ocwW5BP
	2NUEBQEwzQvpIOJUjioloQf9FPvN9lFpuVQh+7EORsHiMkYZbtYiX0VtFUSkk3oB
	sU/2Eh/alX2khw/RbRLLPYvUlv8y8uWn5bivh+XCSyQDfZrAo3sRCC9O0GVlbJVD
	FfN/I4fddxDcszdyDI8aw==
X-ME-Sender: <xms:tZ_OaS_1lJgRxsnf9Xc1CAdPhf54V0Kqb6qrYgqA9UXXgZCdswzoVw>
    <xme:tZ_Oadhyl3DURYem7Ly4XGeKdjy6VI1QJMkNioMtAQCLzbVkV_e3qre7ZWUjR8pea
    gS253gUazFLKmOCm9fd0rWSAi2NcMj_WU84AJjpYcLKtoAsHafh1-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpeflohhnrghsucfj
    nphglhhunhguuceofhhirhgvfhhlhiesfhhirhgvfhhlhidrnhhuqeenucggtffrrghtth
    gvrhhnpeeitefhteehudevudefjedtgefhjeetleduffekveetgfegveegvedvjeehteef
    ffenucffohhmrghinhepfhhirhgvfhhlhidrnhhunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhirhgvfhhlhiesfhhirhgvfhhlhidrnhhu
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegshh
    gvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgvghhrvghsshhiohhn
    sheslhgvvghmhhhuihhsrdhinhhfohdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgvghhrvghsshhiohhn
    sheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhptghise
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tZ_OaVSmSmX7yvxH6kUM58taHlDA7XDeFVRBocJB-E-ulrMxwrJDeA>
    <xmx:tZ_OaSeLGVdyhUGF1BQuGp_Ch86nXGH48j-8k2akFSet1m5mC0EI1g>
    <xmx:tZ_OaUqknGs72BIuJVxM8k64V4LyEO2bxNOWeB1PkJGK2MYNEybccA>
    <xmx:tZ_OaT_fcRFtKdhGq7FuxEF0BlryYqXB9Uj_e0FpWkDkqAyHRlKfkA>
    <xmx:tZ_OaSQxUHL7kEdxPYrrNCGfpKdCPGLimK2gsEEmUiuK0OeVu60m7bue>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 678B021600A4; Thu,  2 Apr 2026 12:56:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Thu, 02 Apr 2026 16:56:01 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Message-Id: <d50a8eb1-3a16-47c7-bfea-0a3def606c6f@app.fastmail.com>
In-Reply-To: <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
 <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
 <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
 <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Apr 2026, at 16:51, Jonas H=C3=B6glund wrote:
> Here are dmesg logs (with the appropriate dyndbg cmdline flag) for both
> cases, in case it's useful:
>
> https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
> https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt

Actually, now that I look closer at the good-case dmesg (just after
sending the email, typical), I guess I'm not sure how happy the driver
and dock really are.  Well, I'll let you weigh in since you're more
intimately familiar with the subsystem and expected debug messages.

Thanks
