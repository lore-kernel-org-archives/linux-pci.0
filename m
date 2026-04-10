Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FF3A1E70
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821339; cv=none; b=mNWndLUgs6Z2dnnCOk41NP6d2ENM+DMMe1YGHREsexG6ggXcd2Rmj/hoBobroLjvW+P94btllIrkd5pQSnD6Jhz+OPE66rDve77KD636s11Izh8XshG3ddU2Ev8w8ZqXJkHtxgCTUjXw4WrEXoHYFSg0XaJyXQvSUJ1JTdN3+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821339; c=relaxed/simple;
	bh=KiQsl3mYZOaTw3T9wPek1MeLx/BPuQ1fIxWrwmSTLYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SfMiyeq/ECxyIoEFZNzstrTrU8CpU8hYm9Fn+tEmRdlJ4sCRbvo/a3sYqBZH5HrouH2t4lEM8DBglcDCChL0KOYhLDmaWy9Fl3H9vKNjPmb2uALnMk9/ItiZ2Nh6IUlB+vHKHpjVaoMJ4SKQlZj9bRaav3fyBRXXzTmgjpvG6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=BsU0kJ/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUM6pbA+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="BsU0kJ/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUM6pbA+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D2837A0090;
	Fri, 10 Apr 2026 07:42:16 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 07:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775821336;
	 x=1775907736; bh=jWEfUWKOXBVLg5ia1I7z0sS2pAmRBbpGUqXdeMEloKU=; b=
	BsU0kJ/nQ23jIugFg+JZEck9X0YaKTunjhhaRQoYPhk1q6GALTNzYLfJli4NWjMw
	/hXfeZaLL1W3RdCvukDDNPsyhlmaH5pgqta4otTi7x3yjM33eiaAZunMat23eULK
	uvPh/NP2+Smb1gsc/PLeUpKvqlOyZtUdO+ZTlPE1+A91FNCJvLLRD4zwfKp9i6Pr
	5zEIOiDlL9RMDK31U0SF0WYeyznTVsipmHN/KZwJLyRblAsEb8Un6C543iUsvS04
	ZAlIbqCC23hUgTcBhfK5XmA7MtU1sybPCI0+748VsK2irMVc0mTsJkbVVomw8E4w
	BgJTCLXIIm1WVOsEHtbU7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775821336; x=
	1775907736; bh=jWEfUWKOXBVLg5ia1I7z0sS2pAmRBbpGUqXdeMEloKU=; b=I
	UM6pbA+yJ5cv1nkyhTWJhkI+O3EVWPt+W/ijqRkbuP5SxYXnyhftlXOXrG2Uuoig
	Qr4qWq9A2EdcHM/u0ohIpCSyQ0WcUMKUu2bhXbc/jrKp0tef/Rwkic8g1vJlTH2w
	FuTYIXQuB7btJU2tPYAOtONeQ2jNDUR58hFo7Ml0+q6Zdx23flZD6WlN4+HBHy2t
	3/LOB8pPARLkU0fN06xrC49WX+WQwstm2qaUzDKV6wzirECq3ZhpCBpllaFV82EC
	dt6TiM/izkcz1TzWWkfUzBxq8wrqUwfjSniwL7nwPH1pzMVodRa5+2xujx7HrNt0
	2bpqlQouHJs6caBFWKEdA==
X-ME-Sender: <xms:F-LYaTiJDugYGwghLt_gcmtscA2yZ5Ki8WakhHJZhrOe345msKPxnA>
    <xme:F-LYaa2Qp8i0W9DTktznjA0BT0jvbgKoqENkHGcOgTceip_YIbSXpnYeIvpY_6CID
    fSyD-0Q2TO79vRD7TUeLPVRpJ4u1TEgcptXsJHEB-cZZJMmlb5LjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:F-LYaZV2dOIxaZXhH2z7Trtf4nTdoR13ODSGvroe82uF8L51QmkDpQ>
    <xmx:F-LYadSc7YxGXdlZUQgYoNCRimc7PuTuL_sutSY9tnZ3OwRsyxKv9Q>
    <xmx:F-LYafOYRTBwM_86h-aCdG9RwRKAwnq5DbCxQLBZ-bFkQYFThO6yKg>
    <xmx:F-LYaTTh_bLQ2xtuYpvYr0dLDRQO2f0TXY_kB4VxlYGJ3Lba04zpuA>
    <xmx:GOLYaTkLiye0zM64vvYXY7GGes8ObmhMmpq0lLUJkjWnw7po586PVkkO>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47777216008A; Fri, 10 Apr 2026 07:42:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Fri, 10 Apr 2026 11:41:55 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Message-Id: <7bcf3ae7-14b4-4300-9e62-579bc2546032@app.fastmail.com>
In-Reply-To: <19d6f7e4-25e1-c5a4-fa42-73bbba4741ab@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
 <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com>
 <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
 <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
 <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com>
 <6be0aaae-2ade-46cb-b7fc-f03cee21d260@app.fastmail.com>
 <19d6f7e4-25e1-c5a4-fa42-73bbba4741ab@linux.intel.com>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Apr 2026, at 10:43, Ilpo J=C3=A4rvinen wrote:
> On Wed, 8 Apr 2026, Jonas H=C3=B6glund wrote:
>>=20
>> Sorry, I'm slightly unsure what I should be building and testing here.
>> Is it fine to check out the pci/resource branch as it is and test tha=
t,
>> or should I make sure to pick the patches from that branch atop e.g.
>> 7.0-rc6?
>
> The latter is better because pci/resources is based at 7.0-rc1 and sin=
ce=20
> then, there have been two fixes that went through -rc series (I'm not =
sure=20
> if either is relevant for your usecase, probably not but to be on safe=20
> side it's better to include them as well).
>
> BUT, it's easier to just merge pci/resource on top of -rc6 so you don'=
t=20
> need to pick the patches by hand). I think the merge should go cleanly.
>

Hi,

I built 7.0-rc7 with these commits from pci/resource rebased atop it:

  8cb08166 (pci/resource) PCI: Fix alignment calculation for resource si=
ze larger than align
  9036bd0e PCI: Align head space better
  8bbe8cec PCI: Rename window_alignment() to pci_min_window_alignment()
  38ec53e1 parisc/PCI: Clean up align handling
  3fa40d30 MIPS: PCI: Remove unnecessary second application of align
  4dd6e1aa m68k/PCI: Remove unnecessary second application of align
  0734cb24 ARM/PCI: Remove unnecessary second application of align
  66475b5d resource: Rename 'tmp' variable to 'full_avail'
  f699bcc8 resource: Pass full extent of empty space to resource_alignf =
callback
  edfaa81d resource: Add __resource_contains_unbound() for internal cont=
ains checks
  1ee4716a PCI: Fix premature removal from realloc_head list during reso=
urce assignment
  dc4b4d04 PCI: Prevent shrinking bridge window from its required size
  92427ab4 PCI: Prevent assignment to unsupported bridge windows

Here's the dmesg and iomem map:
  https://up.firefly.nu/pub/amdgpu-egpu-7.0.0-rc7-pci-resource.dmesg.txt
  https://up.firefly.nu/pub/amdgpu-egpu-7.0.0-rc7-pci-resource.iomem.txt

The thunderbolt dock is connected at the 52-second mark, and "works" as
well as before (external GPU and monitors are functional from a user
perspective).  Looks to me like something is still up with the bridge
window/BAR handling... but I wouldn't know how much of that is down to
the pci subsystem vs how amdgpu uses it.


Jonas
