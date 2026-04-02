Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6C3CBE89
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148709; cv=none; b=f9eKK8f5BfreVNsbYonNgUc87Cj8onJZEp3jgJi1EfrnpjhQFIy0MFn5w8mZdFn9Qb+BLFRiRG2G5X8batRt7Bcxf3NHwgjDe3IVk8UBGh1z0wZ8deTeudQcq0oLpOklV0ZDPyhJvl0oCMYCNAERBuDicxNSVpJioajfiXykEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148709; c=relaxed/simple;
	bh=w4MnztjoIzaFoBzYmfwjuTLVfV12VLRPbuLHQQGUG4Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Li6VIJ7qkFQ7zRFqwaoLkc+RqvB+dwWTSMFXXiH7deD7RzhC1zWQ9tfdxn4LqBVv8EtAdSzYDA+Em1sdbP/Yuc5XqGeDNXvCyGwHIdKEZBcRVuWUyyltx8MfGSVCDaWQ1JZqQotLXc4554BEwuO44gD4X4CsLi0OelC1fejgJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=ZI8lGMJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ohgx22/w; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="ZI8lGMJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ohgx22/w"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F29761D0005E;
	Thu,  2 Apr 2026 12:51:41 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Thu, 02 Apr 2026 12:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775148701;
	 x=1775235101; bh=VatEIaM91TIfMEkMVx8bZLCwgYoThhMDFQTClOYx0NY=; b=
	ZI8lGMJAwQrTPadszyTHUHr3VOE00qq/Tn4pd2ct5UjcN+eMZXx109uIS4Md86TY
	PWauBP4yYMVAQ/XAI/w8Z2BIw75uNqrvkvfh2y5O2M6sSx92uR4WRjJvcq+Iw7A/
	Njndct/HDjKdvR51Io/ePshl6VkcnrTQKA/Q08Wnexi1154gIEjWH2R5Go9ILvnf
	Lq1ULv5micXYzKiyGhqmCBvwTP9VfTuUUbA5JckYYCb0buuFdymf5aJveD5QKM4P
	mPFXDqECE2IrvVemHrfiyFVvErMDV/Z4djZLJSY5ZqqZyltwOh6bZpyHTK3BMz7L
	bFUbBTjYVJJVcuLkZFO4uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775148701; x=
	1775235101; bh=VatEIaM91TIfMEkMVx8bZLCwgYoThhMDFQTClOYx0NY=; b=O
	hgx22/wsPllK4JXJjdzVkHmUnI5PHe87DNcugNrHrSU1u8udJOgE7jB5NlmvvAGm
	URx6B3vItnS1tez7b7iYniDW1WcQNjO9NGWKTmk4MVRfzkbn5CCG0goZZagMR58G
	1ABEmcOOAa6LfLpwkCtH49RaSFuYil167BfWuvVCazVqQh43W/esEdnUdnIAGNbS
	og185IUAqrb97eloqPMtw8s9OZVURdMwBM1zrKmh8T3QOlj24A/nTrwBE4K19dUD
	B9/anI4VUqGruZ5SUI9d9fGzKvMPdWE9e2uSqykLVBjkGqdrs0H/re6vukZ9nopw
	m9rfMma8GKbcHPyRv3AnA==
X-ME-Sender: <xms:nJ7OaRp0flrzE17SdQfh1hq2OtZMGJgFzKs3buZFr2va3pt2K6IDpg>
    <xme:nJ7OaeeerZM0PE-i2WlazrCKD6XvBX43mZZ9yMyBT_CljovcpoMHgk1zrpSdmqwbS
    yPWr6o4aHOF5EXyBfOTC7AHM7btOQ5Q6kXZlR6c0-TJ9Wwu58CP7s8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpeflohhnrghsucfj
    nphglhhunhguuceofhhirhgvfhhlhiesfhhirhgvfhhlhidrnhhuqeenucggtffrrghtth
    gvrhhnpeetfeffjedtjedtvedtffejvdfgkefghfefgfejfedtvdfhjeetudeuvdffvdek
    teenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfihhrvghflhihrdhnuhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfihhrvghflhih
    sehfihhrvghflhihrdhnuhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtohepih
    hlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthho
    pehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nJ7OaWero6YGluKyyk3mvPhdZ1BZtBsRoERnz1Sza15qfhyA5V05FQ>
    <xmx:nJ7OaT7GE0yjV_zwRCNj9wc1QCxRPrzf2GeB2m9YeMTQPWyXBVYjBw>
    <xmx:nJ7OaRV3cvbCTP_a6En_9DTHvmy1hbI6p3pfcI8suld7ixE4K00Hag>
    <xmx:nJ7Oaa4BA6dnxyhp75qkqhxt6iPoqcXdejgAzcXhKi3cj42XUnwb-w>
    <xmx:nZ7OafNl4YprRfzlmTdQGsnPmWYM_m_wdDOTSA_sPZCyQog1pOOzLcLQ>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 97F3B21600A5; Thu,  2 Apr 2026 12:51:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Thu, 02 Apr 2026 16:51:20 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Message-Id: <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
In-Reply-To: <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
 <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
 <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026, at 16:32, Ilpo J=C3=A4rvinen wrote:
> On Mon, 30 Mar 2026, Jonas H=C3=B6glund wrote:
>>=20
>> Unless I misread something, they should both be included in the recen=
tly
>> tagged 7.0.0-rc6--I'll try building it and see if the issue is resolv=
ed.
>>=20
>> I'll reply once I've tested 7.0.0-rc6.
>
> Hi again,
>
> Now that I look more into the logs that probably won't help. For some=20
> reason, it seems that resize is not even attempted and the errno is=20
> -EINVAL which is a bit unexpected.
>
> I'm starting to wonder that the problem fixed by this patch once again=
 is=20
> showing its ugly head (it's currently in pci/resource branch, so it wo=
n't=20
> appear until 7.1-rc1):
>
> https://lore.kernel.org/linux-pci/20260326200427.GA1340256@bhelgaas/

Seems your hunch was right--I've now gotten around to testing with
7.0-rc6 as well as the pci/resource branch.  The problem persists in the
former whereas it seems docking succeeds in the latter.


> I still don't understand why pbus_select_window() would return NULL in=20
> this case but it looks the most likely candidate where -EINVAL could c=
ome=20
> from (I still don't understand what cleared resource's flags if that's=
 the=20
> case but it still seems the best explanation).
>
> Please take logs from this point on with dyndbg=3D"file drivers/pci/*.=
c +p"=20
> on the kernel's command line so there's little bit of extra info (and=20
> check you are building with CONFIG_DYNAMIC_DEBUG).

Here are dmesg logs (with the appropriate dyndbg cmdline flag) for both
cases, in case it's useful:

https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt


That's good enough on my end, knowing the issue is addressed already
upstream and slated for 7.1.  I'm happy to test anything else if it'd
be useful (for eventual backports or so), but otherwise I think I'll
just pick thoes patches from the pci/resource tree for now.


Thanks,
Jonas
