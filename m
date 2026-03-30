Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D93624A7
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885846; cv=none; b=I8NTBLy95ERVJfeRKS2DMbdJ4MH71bpuKQ1LqmXo4Yrs1Aa0tYfGyvTiN8OpgVsILSiVbL1Aw97EurMT3589U5FoFTfxlIfBbVijezHJ8RsOWQd8QiS8zfMGwE4qWKKy8yXBUxBM7gcdXM4gCV0s2x8r6ccHgd0biVE1S6+hDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885846; c=relaxed/simple;
	bh=JtxRP2j2N+58SGzPaGO6Q8Ko9w+XFrlyWP+288OmYpM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=db+acuVmMTu9BLALBZc7YGnvonUBXDV2sIH51orSuqqioWzkAXNAKcQ188J/JYpyrb2cRQ5Kxg8SGO4zmj9aVV1roJMUcgUERhiDhUlKxR9ikrtXoFUuzA6XTzlM+rO1qM2MrWpogYWnUGc2a9cpxKBPe0tEQNybDnmmNyTf48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=tLCtxdfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dwO1+RYR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="tLCtxdfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwO1+RYR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF7C0140028B;
	Mon, 30 Mar 2026 11:50:43 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774885843;
	 x=1774972243; bh=ZgfvtYoa1J6ggX26EnbC6/X5KpnEj00DN3p5r/JKlmw=; b=
	tLCtxdfQHaYgD15Uq9S6tQOSyag376Z7TFYgEfTfyGqLvi2akJ7bkava71W/cR+f
	VYUGKhH25IO0JypQcS+11cOP6gIdIWd7mQQP02klgR07tCSZEmMHQ1GDlY9kpLc+
	5/PvRbfjnVX3ZNmYdLPzEc+w4lRG01n3nG2SWb5h5Tm3xtQvxw+kiVJxbQoKt03q
	I5Is4JTBapJP2xtCkOIrF66Oa9rXf4IQMd7nXUE0rehqu0IV+ij5078Zfsu9tMFF
	IrU7/+/BpAkB8OPXAaKjs+iBvluimg2z3uBtGtuDZIqyI66+TcyaQEV/2LobIDOj
	Adof3NmwqFsbDlD3BbDeBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774885843; x=
	1774972243; bh=ZgfvtYoa1J6ggX26EnbC6/X5KpnEj00DN3p5r/JKlmw=; b=d
	wO1+RYRXVfOIirK/VTsWHPvUkbZ/OnlsZqYNi2QPbkPRrywyfvsxNmtpO6wJC0CH
	v6nDVvRbCjRUa8K/JaIfdh30cflNWo8mUvuRucuBlE5wAS7K6TTKh5apDqY+AhEF
	g/kxtk7a8u1tyEqOeQR6vRG06Kf2ZMq7GHMSYWiNMG6gCTauhgl1Am5npHLn/ucw
	V3Q132dSpwCrEAFJOn9neDdKCGwf39jwPaij8Av7LSuiDcsLp1rc7bpUVZx2OQcm
	PEg6gIt8N8QgWbUkb1zuOn0ttnHM9MOggu/d+ddxd1pruBHZY58E0NlPaqOBd2yS
	ZWDX8lKLP6+POmOk0hNSw==
X-ME-Sender: <xms:05vKaW2fx0FdO_Zdj3DoiYvZQiKZUp8He-b-03sYmaC5R0GfMJ4paA>
    <xme:05vKaT6jRbXpxdWiCVDtgyb95TY-8JwKhdPrLk58T28EiOgHgM1vEH9gblSRysu1k
    SitiZwub1OvErYtdSn0_d5Qd49oKgjvwZ7N4S7EZ-FhEdL09GVlUdS7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpeflohhnrghs
    ucfjnphglhhunhguuceofhhirhgvfhhlhiesfhhirhgvfhhlhidrnhhuqeenucggtffrrg
    htthgvrhhnpeefledvheevfedvvdffleduieegteegveehjefgtedvveduteehtdejheev
    vedtheenucffohhmrghinhepfhhirhgvfhhlhidrnhhupdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfihhrvghf
    lhihsehfihhrvghflhihrdhnuhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtoh
    epihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpth
    htoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:05vKaaLtLvGOucW-wJSIfqVRafXhvv2cUns3yuB6lUpI8DSOL86bMQ>
    <xmx:05vKaV37Q1_tVKoE_u9FCgaxyZvbUJR3rH3hvvIFzjwgUzs9vyOmmg>
    <xmx:05vKaUjvRkx0YV3Zp-VgKFj06_QbQsEMmcbqB-gf2aV1QDUgAsOOZQ>
    <xmx:05vKaWUBfB_WSngsIz6_6c74g9ZyoiMK00d2t0goYwXyGYOVcHPUzw>
    <xmx:05vKaQqdUpDrklWve0B6YefhtYbk_chJefdIy3z00QsuVaXeynBR11En>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A97F216008B; Mon, 30 Mar 2026 11:50:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Mon, 30 Mar 2026 15:50:22 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Thorsten Leemhuis" <regressions@leemhuis.info>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Message-Id: <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
In-Reply-To: <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
 <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026, at 14:33, Ilpo J=C3=A4rvinen wrote:
> I'm skeptical it's exactly the same issue even if the end result is th=
e=20
> same.
>
> The resource fitting algorithm has been in a state of constant flux du=
e to=20
> various fixes and improvements into it over all the recent two years.
> Unfortunately, fixing one thing (or even moving towards fixing an issu=
e)=20
> may break another thing due to how different resource interact.

Ok, yeah, I don't envy having to deal with that.  You're probably right
it's more BAR-related, I mostly keyed in on the very similar symptom.


> That "PCI: Improve head free space usage" series is certainly fixing t=
wo=20
> known corner case with the commit 3958bf16e2fe ("PCI: Stop over-estima=
ting=20
> bridge window size") but with only heavily filtered logs, I'm unable t=
o=20
> confirm if it applies to this case as well.

Sorry for not providing full logs from the get-go; I couldn't think of
suitable location.  Here's a full dmesg for reference of the crash
manifesting on 7.0.0-rc5:

https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc5.dmesg.txt


> From the limited logs, I suspect this is primarily a BAR resize rollba=
ck=20
> failure which leaves the resources into a state worse than they were p=
rior=20
> to the resize. The commit 337b1b566db0 ("PCI: Fix restoring BARs on BA=
R=20
> resize rollback path") attempts to rectify that. The entire series is =
here=20
> (not all of it went to stable):

> https://lore.kernel.org/all/20251113162628.5946-1-ilpo.jarvinen@linux.=
intel.com/T/#m9b0e316c94f7abc0686e58f902d05ff35aeac3ac
>
> The fixes to that series are here:
>
> 5528fd38f230 ("PCI: Fix Resizable BAR restore order")
> 08d9eae76b85 ("PCI: Fix BAR resize rollback path overwriting ret")

Unless I misread something, they should both be included in the recently
tagged 7.0.0-rc6--I'll try building it and see if the issue is resolved.

I'll reply once I've tested 7.0.0-rc6.


> (I'm sorry how complex this all is.)

All good.

Thanks,
Jonas
