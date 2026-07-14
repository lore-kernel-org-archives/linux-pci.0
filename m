Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED39EAC7;
	Tue, 14 Jul 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035114; cv=none; b=hLkvRO//jP4sITZ1jKvnYMIFH05OJQPDLEFyeN5DE6aAAzHAG2Hy8ByIoGJywCaWP4Rd41q29aryocgzRuxXM6sPYj/aMTMCgyYopJ/FVP6y/fArTEtBRFhrVcA/Ljr/ES3ph41vjWK6H8JCnrN1J10hqSlNI/fCi6BHsTjdZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035114; c=relaxed/simple;
	bh=mhK6MFWwW4f+MEPfrdZ05ewjPvCsmOfXSIu21lHRl8k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jD7ME3kgsDVkMa+dovVlsTHZJxddGV7Mu/KAuVtzX3FLQ07mffUYzz8m3Wx5LV6/PdLdtptU0QkA0ReiAD7pXkZHrm8P57wxyy8fzk4SoIVr+LBIN8vragBomkNJpgRU1OUhDfXXpdqUVJ2PJzpz9aFOWdvqLLt82Z9inS6RpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YimZB6JV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YimZB6JV"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h00HS2tQMzKw4Z;
	Tue, 14 Jul 2026 15:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784035108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpwqSNruxdEe6Tj6+x/b0+t0/YgQGS7L4fW77qV7xuo=;
	b=YimZB6JVxxClVkukBv8d0EGG0tg4ASzL4WYGXIInUVeEu4ob3M/rQ+OqY3ggBP1wM6R2Lf
	Hvi/a/LJfy0mjwUOjW/IqoJy0YBy8op2VOdNfgCg0UQoFIQNPHh5cJNauMq8MzGRgW9iX9
	7H006OqG4fbmU53qW9SitP6AYRtK6DOky5vsAkwgbQsykD+elhQOvroD4PCGqbXzZ24Xlo
	2QYTzsqoHcbWzt7wLDRMcuEgNJEF3SMv7Q0Lqdvr/cK1CWMdIEM+jiMe4Z1RRJAm7SkWaN
	SkKN2lzquz8grEBTSXQJ8YgNR8fIoK4yzNcrK4mPK41WerKIUIJC4rJpL9I7Ww==
Message-ID: <47bf010a-622d-4978-834f-de3e483b2990@mailbox.org>
Date: Tue, 14 Jul 2026 15:18:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
 linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260713175400.GA1258926@bhelgaas>
 <2013cac8-d887-4a09-b1c5-6dc9606f16f0@mailbox.org>
 <CAMuHMdVvWE7YZgKvreSn_vJLOVD4eMmn3TCGOyqSXksqjBCwvg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdVvWE7YZgKvreSn_vJLOVD4eMmn3TCGOyqSXksqjBCwvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4790a4a28d19f015309
X-MBO-RS-META: mbz4dnndw38hnzbsotnhrof5d7tigzxn

On 7/14/26 9:54 AM, Geert Uytterhoeven wrote:

Hello Geert,

>>>> So in the end, it is either this patch or limit the build to
>>>> arm/arm64 . At least this patch still allows building this driver
>>>> with more compilers on the various build bots, so I would opt for
>>>> this patch here.
>>>
>>> I like the build coverage, but duplicating the #define doesn't really
>>> seem good to me.  It makes readability worse because cscope/tags now
>>> sees two definitions without an obvious reason.
>>
>> I can rename the macro, or ... sigh ... I can reduce the driver to build
> 
> That would obfuscate the code?
> 
>> only on ARM/ARM64. Which one do you prefer ?
> 
> Just add the dependency for compile-testing, just like
> PCIE_IPROC_PLATFORM does.

I will send a V2 shortly.
