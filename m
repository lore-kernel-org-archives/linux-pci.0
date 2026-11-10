Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322062;
	b=ESvor4djjV4PJsTHyYyzcKs4TDnwBiSCac97Ns4TE6nG6Xi3thag8Wp+WcQDh+xlKp+t
	 r1rYopQidP+ToH8S3BKTGDIxWxrh4s4SXbbxPGQhFRDe0uTWTAsz7j2NmK+2OqeNow3ER
	 Bv+7xKtpkLeGAewf65/qxV2PDIloFMNw9NbzJz4GEY/BmaPqhhzrw0Ftjf7PgkyeWm9yH
	 NgSvY1N92Sie0kpn1UJPbt/0YiBImt/S45Gxd/kCuqZ3BGOyZVg1sQVLmfQe4wAPrbVYo
	 cEBO8P0JWlq6gc6WOdWasgfBahOIpFqqy1PbSqCZMJmmHAP+EWYjGsVn+Vumhe7uyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
	b=RBhfc+IJe6SK3roJprxNRJEgbxbPsnMbHXpEPzBl2tby6lF7nvbsBLFtXvqrsljoH1Hm
	 TmZ+ZKPC6TLiw1B2xsGJaSyI9FungsDmVjvfC/KQ3PNoBfGm3aVOl9paDopGHCVjC043U
	 6FWAmBCmfptmlHjOxGE4C1AbFOi+cYb5TRe+FKjrThDIK53cS6TRHI9I29mc5h0Zac+OK
	 MbzimRZviIlQ3t3607cWbGksr2dw2VJXtfXqg1VnNNDNjuoQi/ZbCcmp77aURD83GEN4d
	 t0LR4l/arHmWS1k6ijA1VI+iVIIAjYBvu//PkPaw5aqgOVvfqRwwBMCWogHDEdUKv5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="f0p/9ton";
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AF60A261A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 14:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406AF60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=f0p/9ton
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2f4cc314eso947096137.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794322061; x=1794926861; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=f0p/9tono6w5KMbcB2YOWm+TL1bShXXnItauTtZcZIA3ZauQXIbiJ6XJ3s2djH87ip
         I++QPXZ24umXJMRImSi8/Qtd6+iFrcnT1HCa/uiivkfR0qrd/97rzFC1hadvLbEESsaB
         etu/IGSL3ldDcWfkSkPBixVVJFSZv3iv/bSMW1Rio9VCub4uYaphZ0lH5RCS/fOG3ABi
         /O6QwjFsFbHtDlsKHFz0JeXBwhyg7Z7sLtN8pt+pKSeElAl0i1sTmRS4FRBJVDtQlrzt
         EhBrv7K/eUdt9HAfk01RcYnkVOJY9hzzR0qNueqX0ulGGRpYW+6IC8NOTlwyCaBHLrkt
         cfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322061; x=1794926861;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=rF0v3M4YTOdgw17RqCEKuIMypgiABvNAI4bCIEX1EC9qnPLj2T1/tLT8UYcEo+2zI7
         EO/wh10pLkbS4rYi16q4475vqTXFevoU9JYZH5TgO4yTq1txrlvgSPfUwhEAUmnHBZWz
         thUTIYANT7eapxsvvL050Mh7BHQmSeDZsEfEG/4SoHrw6h8w7iE8fD+6An/B/fXwul6C
         GT5oCzWfuw+Nafyqa+CSpYAT1Ql+UpdGd9dGZN16A8koooc0DEnT9Bo2jt//y9NGm2WG
         ZWUR/eUPPus+yeWXa96fQSJThfmRYPQRB8i3S+q8LPjYuf11zFzwXl8cVdxUuxzkdpkm
         KC5w==
X-Forwarded-Encrypted: i=1; AL+hErHX5qFb0JP3eEvayhEpI0+OqYj0sbWwD22gcQ/R7P2OoHjGQOszuJorEXfE4zIVAIiCT9S7NDjPNe4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CKUajdCGlh7a5yLLSNkq95CW6z9+QF1FChPO9bR5rqh1xOVz8
	ZUbfTWIzGB4RdcsarHA8oLY4iIQx1ABrihVBt1C6alaQdkJj9n7fYUkfFC7he8KBxwh4mxPwfWl
	2T2OT
X-Gm-Gg: AYBFou24IuWQa78IiRyXwUgCWp7UHYHS6KRddG9UkKkCGl3WvoWxYxGUE1QkXEAFa/x
	9cHdXiww+5szQD8bvt0pT1hB8GgUfm1fQBLu2xw+52dzeoyc+9jm8jCLSiiJIPh33Qi1x4AlwNK
	/H/NdD22WeYdpaCCe3zaqMZ25zZULm7o84ZlKDew/23uIm7g7uhsv6RJwiM1JPGtUboVOtNK+eI
	/iWVhz7XOTHVuOcTOuH9KirXvPTwSquHaB1M28Poo0Ra2EZiIduAikn8+FzNIQzlxmpM6DssvlH
	tJchCEK7O26ZlOjS5pFyh8w48V/T2hQinnEeIVdWlIrx1/Pb5vjLiytm4Wh0y/iWorronnwXRk1
	5mLhWpQZsPM1jo799pDzsbQ1TdVG8yG7S+zPZBeMLie4mUoq9VXQZerojrKfjvrJ1kMIMa5jYUk
	2HVsIQ+v7TvZHRYKdeBYT6osfu7kWQ52txnzY9qec5tFkQG8OLB8AECke34owb22m2UGRPYYirt
	/Eflp9XEp3aSzlnRVu22gnt8JLmPE65BIOiw9D5BYllyYcoxMSrMq6p0WEVdFovKD2GmQAP53vN
	NjqysL7SS/vqyBTl2XATsX+CCnltlUV19U7Ipogj4xFBLAlAZJC6hEwDuYrEQ4yfgI7gG35Y4Wc
	B400cKUbGJ1/yd2aIHGsgrUXGJeW7iH1fUXNDFEL5r1/FkdU=
X-Received: by 2002:a67:e706:0:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d301c2b6b9mr1064638137.18.1794322061210;
        Tue, 10 Nov 2026 06:47:41 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2003b37csm1895903241.6.2026.11.10.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:47:40 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser
 via serialized pointer
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-5-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-5-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 09:47:35 -0500
Message-Id: <179432205559.2329176.7688399969919556416.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=qYrWWLSjrMyi3btEEyRhgD14ybrNmyQeqN8ETOUOvP4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8y6LmPCnN2SrnZCSda58BBnTZsMnjk7g+kA/g
 6Wo/AVJiseJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMuiwAKCRC7dyhM23N6
 3qrED/9liUyRUpQr+Sv1ioZ2pUvLcetyB+2JoLxaB/0UYYNHqDXpwWtEHhSP3eAYwEET2WAzSzb
 cINjQ0UdR20OJBBxpWT+3R6jrxl6smFx5lA1+CtzCdBONdl5NiW3+NITRy2Ip//vGFZKdNjWFk/
 5Y0ii3L7iz6hVXT9R9y6mqGOo2TBCSa84xWnOGrVJ8ijAnCqgOeAMhmqVN+rkl/dWCvzMcCFZZP
 AYRuSxmCQaOa9GxsOttPL5pX10r/UbwioXQZu/aJ6RcG+ql2liIZFv1+3mcSyInleN3SlnUZOVi
 inOQM3Yp2D1a6ekPH7F6Uzb45X4qnnJ8DSfO2LkVSWgmzzpsKuXUePJ8Pe0a7FfO9mUYj5Fp9wg
 IxfJUyigWzzPN0aOcgePZcZBT4fLUlw+zQV3UGnfTiTzevMagmFWU2+B/s0Zt7u6TidXvFQsMFI
 6ZlD5aySuQGLYM3+UdGdp96SY6FEGgvqmSCG63zPbq7Y2WqSBl153diBep17zLt4CJ8n3Fd+YrU
 E2rPF9GR7k6MT1Qc2tSSvCCk+cTjcDt4Fm3op7Z6LrxP3BQDFa0Fh2afBgG5mCHbK8fSxd2uggj
 NuHbXeBNgQpe1vKYQQd97AUSoFlymseer2cfqgpdkxtIZwGdPAYPchrVuPHKx6mZDNkSz6VZZ49
 k5DwAzPXt9kz4Og==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Tue, 10 Nov 2026 05:01:47 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> struct luo_session_ser currently embeds struct luo_file_set_ser directly
> by value. Embedding struct luo_file_set_ser couples the session layout's
> size and field offsets to struct luo_file_set_ser, preventing either
> structure from appending fields independently across kexec.
> 
> Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
> struct luo_file_set_ser instead of embedding it by value. Reserve space
> for both structures in each session block-set entry, placing struct
> luo_file_set_ser immediately after struct luo_session_ser, and bump
> LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha

