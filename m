Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669855;
	b=ST3aRLrNKWr52ozsdmRdVJeSdAor59U9OUpErCKduCFpz9rN6x8CjI7SKi7eJSCQxbFg
	 BM/rGgDDunTWAXMXnW1isNL+TnROr7pdWg9pLnID2PpTKRyFC2BEIXmr3YMy8cTvKLJqg
	 RlTW4gl0LzvduX5U6fYNpvrzEeuMu/hbZKtJhTKOXRGPR1xd3RPRSDzle5HGB8PbDnEBR
	 I6s4eldUOo/OfWAnQKXGkyYW7NQjqZrCEdhlyvFT2zDsBv5Fxt+RyUG6sO9+NAG0El5h/
	 edE8aEaBiO89ePo8ttcgf6kA5BRFrw5lROkvmT89YIuvz9c2vy4P+D5jpf3yFaWm3sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KwRR/qdKj0RPOi4XP9w/7R54SH4I3Pv7ur7JhNPAfOs=;
	b=rqnaaOca4zlMqXD1wyAZY85EAZ6NCg+E1/T2QWGJiHIHKEV1uSVUa6wRIsjH/2qI6y6+
	 XGN8t2Gpkm+53YbYxJos8J//rUbbP8QAcjBDgomg+DQWbBRNFaX9kkbtRkBvX5eF59T8Z
	 EO+fO2+2ScBh/v0ZMJpigQn9dmJiZ/asJDeE2ulXlmHrTCJfCFu4KmEh8DSkzP72E6duY
	 Yed2TrMV9LPqT2Ab8u7h1QRA6Y/06WpewTbfweHLKl034h+FPGrDs116nS7ok0+4YCITC
	 Ei4vojNwV3KbLXAo3XuJKr9SLayDjYfIGdHUoGykjgHumIKiHMKQ2kKffTlvMIYpMTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=mOhYEDIw;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506B606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9506B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=mOhYEDIw
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A122C3F6B1
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795669852;
	bh=KwRR/qdKj0RPOi4XP9w/7R54SH4I3Pv7ur7JhNPAfOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=mOhYEDIwImlIKgJz5rNGt8r8aXheufLG5vzBhhqhezaDKqapSpAirHtd4eliaqGJN
	 muL62SpV6JxDz6j5HDqnYDe9GC/mgTSe4maIj00rk9hlH3hsAkkzhj040GIBHWbisO
	 l9c1GXACJqg2SxlYUYb8B9qFyI4OC0lvssjtaIkDTceVG4MQAp7rO3LBUbX/e8jwoc
	 uYbDsOQTDdPWBiJXHkJTJvU+mD1duHtEWa1ijb0pITBUa3Egv77AWxgAIRRs+wn6aN
	 DgjpH3WQULINi6kN0zfzs6RXyoSgnyaidX/LIrd7T0eWttf7JaXcFTfbee6PqVR00c
	 31FyDlqxt/X7iK631JBD/hAZEEKm6/LW85hbz+e4Z1wVMXEYMyqmRPrv7o92cON22w
	 mzhllaQe/YlPwd9aOqi7UH9OoDWx3pIohIGbayNlonvHyGst9Sh+qXoI8JASA5Qh8m
	 53I952pj+6wWiPh01FLF4J189+GhyQDkM68LgBEd7ZLRRunMjWUzqgpux4xkaLJ/lh
	 Qt5Pb2VfD6du8RjfGqEVbxE7IqeAtigp7bz0b0qR6pKbVfStEftZ8iEpudZIuD91gg
	 ZATwejSIb3z+k5aKrORCyM36+m3wdRsMU2aM4yIiW/gytMKPzbohCu1u7OhnOZccBC
	 x6j07IdjEXLzbRGxZ5mex1To=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b46af583b5so878943a91.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669851; x=1796274651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwRR/qdKj0RPOi4XP9w/7R54SH4I3Pv7ur7JhNPAfOs=;
        b=aPTyWkEmlvJAT1FsxqJSmrhA0CHxrplSbwGdC+W7pmcHwDpVvmfFSCWIPLZ85dL4J3
         PmTi5Tr226MkdApXKLNzE/qFG6k/D+jj2/RiHxjSu40L6P89ZtUkSbW3D2jv/Y58FEVJ
         uyGIXEKt5wsHHADpGbVieqH26hB2avwajtKMWr+s+sMh/GJuD5HvdYjlLlMCAGIUoDzp
         2OsbfA4ElK3PClKq3/30+Xugnk7wf9IMzSCLDCEBaJ0AHTPDasQLGOywcyhsrnv6DWbT
         r8ozkmHvV4vek//i2aW7SbRrkkmABo/ZoRQpDJ/wLY+qHB0hg6xMt20pkYI/zAlq3K1r
         GFFQ==
X-Forwarded-Encrypted: i=1; AL+hErFm5D0LbbIK50AyMhIIaALSwbygDz46WU+jv25wZhMIHW0yaFUdKPiJmGVM6nRR83oNkgzUS90I/dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VT6sWZek9lLyn6pYGrOQ+v03N3PXTvUIkEySw5S+ASAyBAcex
	HNoZDJvlb3qYU7xi4d8St3EDE0iW740a2KMnBP5uCCacX48v5y+W6TmZVyJNEhrxOCKwdzv4hzm
	G/MGfxLzhzkO0inUgr8eW2he7X7lpykQpruaPVsgHUnMYp6USNqiBpTksiJ+7ella/Bs+YAW0X7
	QbcSvNoNcLdA==
X-Gm-Gg: AZFdTZd2PU/1rJXcp6PYFYlv7SHFcvpKzxo//exMvAu7480izmMtl5wIN3jIMgG5ZrJ
	kCmrVunT03FhaBPOTU5aXLPsM/tZl/+3A3NzLUkgpb+bPw8P4G3DUdWtUieK5V+XLIQLAxA2D82
	7aCXwZr4wGDMgaqLm0pQN2BiR7xG8MeuGMvjRgnKeYb6MRtkX3PE+wMejPW3lnnKJZC1vS/gd2h
	Uj/KMN5IlhdJbQ/6hUCbyshjN29oiYLaXBLR5eTkzXxU0HtrPjVdcHdo8fcycvBGlkRpxf/F6A6
	CERx+eqZn2xzP7M4/XjnJRJ8dDlUv+aWgXMn7I1nSjGyMSM6X04nLUmYyP2wGybC0LH9k1oBLpW
	jF1kpNOCZwJ6gIPJSZQhaoq+gnFGN4dFt+SJD/l0cMPDEtaR72PUxDEync5M93QSRc3jEwH7jIG
	4tYS4iPKFMVTcwIqxiC1EokNcQXgbcLjW4shQkpVF0JVg/0J8gm3IIT0/JE9HtT64aYDReH4M1l
	hi1wEBJZcAHiT+kouOkUnoK17FZ/oaH46l4PhsBwIQd2hYEd3lSO5Phjrr8Xslalsku7LS3AH9y
X-Received: by 2002:a17:90b:2701:b0:3b3:ab75:c947 with SMTP id 98e67ed59e1d1-3b41c7b60aamr29189702a91.1.1795669850789;
        Wed, 25 Nov 2026 21:10:50 -0800 (PST)
X-Received: by 2002:a17:90b:2701:b0:3b3:ab75:c947 with SMTP id 98e67ed59e1d1-3b41c7b60aamr29189673a91.1.1795669850346;
        Wed, 25 Nov 2026 21:10:50 -0800 (PST)
Received: from localhost (2001-b011-2008-6747-b767-84f5-eef8-b9ca.dynamic-ip6.hinet.net. [2001:b011:2008:6747:b767:84f5:eef8:b9ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm33393876a91.4.2026.11.25.21.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:10:49 -0800 (PST)
Date: Thu, 26 Nov 2026 13:10:48 +0800
From: ChunAn Wu <an.wu@canonical.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Keep ANFE masked on PLDA PCIe-to-PCI bridge
Message-ID: <awe/WDFqt6Ni0z8P@an-XPS-15-9520>
References: <20261125020013.639193-1-an.wu@canonical.com>
 <awbKkqYgV3O3ay4g@wunner.de>
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
In-Reply-To: <awbKkqYgV3O3ay4g@wunner.de>

Hi Lukas

Thank you for your review

> > On a Dell server, a BMC VGA sits behind a PLDA PCIe-to-PCI
> > bridge.  When enumeration reads an absent device on the bridge's secondary
> > bus, the bridge returns a UR completion and, with ANFE unmasked, also
> > signals the error.  Platform firmware reports it as a fatal error even
> > though the hardware severity is non-fatal.
> 
> So is bit 20 in the Uncorrectable Error Severity register of the PLDA
> bridge clear, i.e. set to 0?

Yes.  aer_uncor_severity is 0x000ef031
 
> Are you using a kernel which contains commit 79c168e2aa95 ("PCI/AER: Skip
> error recovery on false alarms")?

Yes, the kernel I have tested contains the commit, but still got failed result.
 
> Is this reported through Firmware First error reporting?  Could you provide
> dmesg output?

Yes.  The firmware reports it through GHES; the OS also owns AER per
_OSC.  Relevant excerpt (timestamps trimmed, device addresses kept):

  GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
  pci 0001:c1:00.0: [1556:be00] type 01 class 0x060400 PCIe to PCI/PCI-X bridge
  {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 7
  {1}[Hardware Error]:  Error 0, type: fatal
  {1}[Hardware Error]:  fru_text: PCIe UR
  {1}[Hardware Error]:   port_type: 7, PCIe to PCI/PCI-X bridge
  {1}[Hardware Error]:   device_id: 0001:c1:00.0
  {1}[Hardware Error]:   aer_cor_status: 0x00002000, aer_cor_mask: 0x000011c1
  {1}[Hardware Error]:   aer_uncor_status: 0x00100000, aer_uncor_mask: 0x00010000
  {1}[Hardware Error]:   aer_uncor_severity: 0x000ef031
  pci 0001:c1:00.0:   [20] UnsupReq          | Receiver    | Transaction Layer (First)
  pci 0001:c2:00.0: AER: can't recover (no error_detected callback)
  pci 0001:c0:05.2: AER: Root Port link has been reset (0)
  pci 0001:c0:05.2: AER: device recovery failed

> > Set no_aer_anfe for this bridge with an early fixup, as done for the Apple
> > T2 Secure Enclave in commit 7209846a169f ("PCI/AER: Keep ANFE masked on
> > Apple T2 Secure Enclave"), so that pci_aer_init() leaves ANFE masked.
> 
> The issue appears to be confined to this particular Dell server, which
> suggests that a DMI quirk may be appropriate, instead of disabling ANFE
> wholesale.  The same PLDA bridge probably works fine on other systems.
> 
> On the other hand, if the bridge generates the UR errors for every access
> to an inaccessible device on its secondary side, this might become quite
> noisy and then indeed silencing the errors might be the right call.
>

Counters from the failing kernel           
Only one UR was counted, as fatal, because the firmware-first record was   
labelled fatal.  The Root Port is reset right after, so I can't tell   
whether the bridge raises more errors for later absent devices.   
Since this comes from the platform firmware and I only have this one   
system, I agree a DMI quirk is the better scope.  I'll send a v2.
 
BR
    An
