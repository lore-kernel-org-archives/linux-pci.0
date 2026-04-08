Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C33AE70A
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643956; cv=none; b=mLnrsMHpkuuCMVogGSEjv9Gnq7Unsuy3MZmortO0ljIHWY+grSz41qI+0Kx8WDGRYTbO2p62UOuLDs/NUzkZZPo3Sv6/0XPqp5hj0c+9VbWjixIdg7xk3s8UXttbGGK1SSRFcLNJTV+jxg3X0gGnit3oNJTStjQCNWUUC1cY0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643956; c=relaxed/simple;
	bh=DjXZLH+YRavlOM36p1F5GZ5znIshhUQXJ8ADiSSu5aA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dagjhlT0IJQijkdWrZ4bPsXkrxSBO8QyojYMIFCt7h8Cn1Bv7Xz+0rEvBRyKjn+iXDQBdUNFVPYKv6Xpkzt8yJ5lS+kDBg8HuKmxDAgpvlfnPnxTJIuHMVyeiqMpyBtAOD1OXEylJfe5Jvk0d1/B3kSF3/Ghf4nLBQtw/W48avU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=cyP45HfP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccb/eVcy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="cyP45HfP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccb/eVcy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F949EC0406;
	Wed,  8 Apr 2026 06:25:52 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 06:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775643952;
	 x=1775730352; bh=TBmWEmSnufmzhoU7PXORBzatT7QxLTPyMRlPxknMWOY=; b=
	cyP45HfPG+Wq0y+kAuCCjHH5S2AjNaVbyEwxcHsorj4XLfS3pqTw3c/w8MmNIqyL
	H5I57u7idej3X5lo9hWn7ylqGnqulGMV3z51YsRXajnqXGCml20317jc30XhwAlY
	78GLZ0ts5A587XhSU3x11VZFqwl1+Ki3RTG2RTWmzPmnbkzAOE8X0s072lRgtkww
	ZnGnr3DBpTdc7Y+xxaU5OAa0onbTSw3Pk7/qczJoSFca8HICKweHUo8i2+r+gfMV
	xhLilSbo8+zhlYRCOIA7uFfb3ytOKo7kdzy1HiYTsp8kis+/D80EXw0WbrZK1DSt
	aNu5zwB/Ef9I93FxZ6CekQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775643952; x=
	1775730352; bh=TBmWEmSnufmzhoU7PXORBzatT7QxLTPyMRlPxknMWOY=; b=c
	cb/eVcy8ayKMs9EDuWlnEfRFzBSVpO7uN5dWntAinBi98QBFjPnUuyc29S+c0s++
	lRLtrfOLF/feflp66ScNM0MEYLeQg9vR0ngM2xniX+XbeNoI1jOqmeGzZqkTCR2m
	rkmKQaPBko2AKefRMP2RJDjnXdclaXiRC/Q3ph8USlD8Bfd/pTgwI9Wog++F6jqR
	TrjBBWIoMxGVKNSrlbQqWvKI70gBeQPTp7ZGajBwQC9XJ8ClSKIK+EKEOAV+P0R6
	5PIpFS6rh8HKngl02+9/51+T85sD//LJij5QQvV9uDolBA6zDkeUXV6uyIu9IccX
	qv7XLeP51YyklTofxUi+A==
X-ME-Sender: <xms:Ly3Wae0TkoccPeM9dR3P2Jb2mj7OzRYQlYJRCF2wnxcAzqHLY1Ewcw>
    <xme:Ly3Wab49JLfW-sRW1meC1UXRjuP93lNn8eBtenCnb-LL51Gw1yl5BkMBLL-5nYLqj
    TFzF2D_AF3VdM5BFgSq8JfJo8X-7zZiM2unw7iaPt309VSQyYJ__2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomheplfhonhgrshcu
    jfpnghhluhhnugcuoehfihhrvghflhihsehfihhrvghflhihrdhnuheqnecuggftrfgrth
    htvghrnhepieethfetheduvedufeejtdeghfejteeludffkeevtefggeevgeevvdejheet
    feffnecuffhomhgrihhnpehfihhrvghflhihrdhnuhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfihhrvghflhihsehfihhrvghflhihrdhn
    uhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    hhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihho
    nhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtohepihhlphhordhjrghrvhhinh
    gvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihho
    nhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqphgtih
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ly3WaSL-yzFgr6GsG8lrhswTdEBnTKlMKkYiSLlqnhf5DB8_e3rcRA>
    <xmx:Ly3Wad0B9zQoxmgp0dOFoALQe9VmQYXM9ZBIUuU3Ic4gjdoGhcMGiw>
    <xmx:Ly3WacizVx9rcR0622mMIMVMjdu8COQMg4tknmFvafr82S6URmAB7w>
    <xmx:Ly3WaeWrKjRkeNYTYb6GdCvtYyKO9JyWQIXMcS9j2G8N8eyrbkrxsg>
    <xmx:MC3WaYpXC_bKF6lihi6jkuDZQrExkl9r-5GneXd12NljdzEM7fbNShry>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A950F216008A; Wed,  8 Apr 2026 06:25:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Wed, 08 Apr 2026 10:25:30 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Message-Id: <6be0aaae-2ade-46cb-b7fc-f03cee21d260@app.fastmail.com>
In-Reply-To: <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
 <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
 <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
 <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
 <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 7 Apr 2026, at 07:26, Ilpo J=C3=A4rvinen wrote:
>>=20
>> Here are dmesg logs (with the appropriate dyndbg cmdline flag) for bo=
th
>> cases, in case it's useful:
>>=20
>> https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
>> https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt
>>=20
>>=20
>> That's good enough on my end, knowing the issue is addressed already
>> upstream and slated for 7.1.  I'm happy to test anything else if it'd
>> be useful (for eventual backports or so), but otherwise I think I'll
>> just pick thoes patches from the pci/resource tree for now.
>
> Hi,
>
> Thanks. It certainly looks the commit dc4b4d04e1ca ("PCI: Prevent=20
> shrinking bridge window from its required size") I referred to above m=
ight=20
> indeed help here (For Thorsten's convinience: as mentioned above, it i=
s=20
> currently in the pci/resource branch slated for 7.1).
>
> With the extra debug enabled, "shrunken by" lines appear in the log wh=
ich=20
> indicates the hotplug memory distribution algorithm goes to mess with =
the=20
> calculated bridge window sizes in between resource sizing and resource=20
> assignment and my fix aims to prevent that from happening.
>

Sorry, I'm slightly unsure what I should be building and testing here.
Is it fine to check out the pci/resource branch as it is and test that,
or should I make sure to pick the patches from that branch atop e.g.
7.0-rc6?

> If that fix does not help or does not fully solve the issue, please do=20
> take a new log with that patch included into the kernel (preferrably w=
ith=20
> all the fixes that are currently in the pci/resource branch so we don'=
t=20
> hit yet another issue that already has a fix). If you need to take mor=
e=20
> logs, please include also /proc/iomem dump (as figuring the iomem layo=
ut=20
> from dmesg is pretty tedious and error prone).
>

Will include /pro/iomem with future dumps.


> Also if you see this line, it's worth to posting the log (even if thin=
gs=20
> would appear as working):
>
> amdgpu 0000:3e:00.0: Not enough PCI address space for a large BAR.
>
> ...I'll see if I can somehow improve that as well (not a guarantee but=20
> it's still worth taking a look, it appears also in the case you labele=
d=20
> "good").
>

Ok. Yeah, "good" was a bit of a misnomer, was simply meant as short for
"docks successfully" (as far as the visual feedback as a user goes).


I'll get to building and testing after confirmation what I should build.

Thanks,
Jonas
