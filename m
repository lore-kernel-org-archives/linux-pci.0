Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803668;
	b=UdDO2Q5+0bmOX4WOgoq8EyWW+tDDMeWT1CnYQey/T1kUlD236JLfvu8P1YQ4PRs8iKbF
	 mB+8Mny4Y4xiRM/OZGA8s12ewU08kejV7hqMnJ3NVVpYFOL18/0F6v8EaBwghjZwStyAa
	 zmU45kl4j5sZZIqb51QTusFDwP0dLaOOKePWaLW1Pxeipa9XzD8AYpljAlGeS9WfWIF3V
	 83FsLzNf0R1rQtR66advIsQjL3qpFYxsTnG84YOtDaRf+FTuS/FUsFyQ9rr6Ko7PNM2J5
	 HZaTv04Y5JtAn32mIZVvsCXWRzVDzyIgELOqukn5wtdwLVbMbOgkyaLiAf+P0JzYL0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
	b=OG/0LCXZikTud12Iukz/2j6ubJBQuOQdJn1pSYAF9+T6wYBeH4PJaLT6yRjpLtXYsse2
	 GSAHkouap7zNpMlvejuKPDfjAGH29FYI37YgF27KpkTI8nX10AR3tqXArQXrTDfMJ11Wm
	 6k5Ba/GarwEHEn+5mTnBoUGRN/FeAYP/46/bTDYqhLV4YMzBEfFe8M3Mdg4brZsYP4k9w
	 ezUmQNNifa1kXoP60K/2MIhwZR8keEtftJ1ECRwv11G4pRmiHnstVwN4keD7xv50AdOkj
	 yh4DZtlu0X4vEleXGo2H7zIJ2qOV85kClTSdfuWe3KbRSVQWPMRRgjDls6QD9FOMhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C4606A333
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19C4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-18818daa3e7so1356317c88.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803667; x=1795408467; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=Hf3+VtbDTfzgXLI/sO1VMbmiG3HjPWLPXQC9K/x0cUqbiQ8byVDXCgJVkDqWGH94aR
         b30c7OGKR5Ve2w8uFEu7hCMIH5aAu5hXb4FYyBCKKc8AKtr3mECcpxs948DTD0bMi/BB
         Zn5fcARDQKEQQ52hBvf9q416lDQQd52msqG+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803667; x=1795408467;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=J40p8t27SVXIl2eqk0LOeN56NiDlqNT8AokALoKFQDvATjNWLcS2nNcpgI1h/y7Q54
         Tdto+eu9rSsu3+9yALFSRvdRsLpIYifespmnSdFpSt9FGNDKpaKe8SWt+8u+HkF7c53b
         CqP4F8uhrVThDvX9VO3G121HE1zCtj3kdA4WOrYPJtWES/teE4b50f/KvOfcW5Vx+fFv
         mti2jqTZ5zU7mWqolDfwjAc+uTMgKtuRkfNWggaGl53jsexFhwZyPsAt1+bqzcbjWf+D
         kYm6g2dXZOQo97/ylRIT4OK8ItAANEiBJGzmJqRTxLUEI3Anz87D5x3I/iMjjojvncY+
         hX7w==
X-Forwarded-Encrypted: i=1; AL+hErFb2akt15IpndOklSZaBS8jvveYxZad30DWHKxihIl3hZA2TskYjYl933p6OB3Ws1fqvJEA08Am7DE=@vger.kernel.org
X-Gm-Message-State: APuU4Z94ZSz+8n55T6vO83cLbUnvXTakNnvLhrBXETRn/fzydr3QkRKr
	NysFTwRy6JaJDTccPnyjgphijsgUX0U0IfgFlpBDSATYSaU+SQtvKYz0O4D5KM52GlGI2XSYQsW
	ZeOHCeCSI9B4F
X-Gm-Gg: AYBFou2Lqm7IvqZ7VxT56ezOSTADGCLZND2cZbC2Enn2ycPNznfscjasBjq+YGv7Tjk
	LNVEZTfyusmqZR35B92VuMaf6PSwfEpEKj5KRiFNvJloQvkyWs6wCDy6IRlKCF1coamWimuoHSq
	J+396L/Cj96wEycfYEiNHZvisep7XTYSw4HfUeRH9LWr5ROAHioYQrqWkVlqFF+UtL1PYx9h2s3
	jUl3s920J3tFSpDtbj+r8diuf8iCvyHi/0hXXs1ghG+76cPWmPQf+8IrFJRKCj8UUmR98bkbyT+
	8zgfu0mE0DL14ZibqrYNwXYEwozd4sAKrF1S50YegitjVyBW7tiozxzVSIXBIzLewjUU3RpSvwW
	+b/lt/nQJABc7pxOaJYRH92dV8xbPeu7uZp9eMt10FoaVYkeP+56g4lrfg9KpJpVrhjre/t+beA
	lWFGNvDMoD6ukb+cFSk1oV3Ad00VZosUj2NUf5yMF9WsjD59bU+eKFBN0oC49QIIokn+lICvULb
	69C5iiBsxBmQrSHn00KVoSMtkaRVfCpZ2ZSHH5JvKv9HFOfi5x3jt+fdV7fzstwf4KhjR23NjR6
	G2k8BnJ4rNZdDV0YZE4EYLLulBTU6cIye28w89wkLkHO5oU5R9rAzhy/6kXtWZNG3QlEymCreoP
	hAcsk1CdvSLBY0C4E0L3FKL067GmRBskNBDS5MJIE1tVb2OsO1bqVeYZBI7e6N4WActfq8cT8CI
	nXPnkfD9YvMV6Yag6APR4IOkLmPuRhWz/Cr5yUyAuOJbCfxFkV4Q4hyHUbzK394hMB
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr11110443c88.10.1794803667022;
        Sun, 15 Nov 2026 20:34:27 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm38362148c88.9.2026.11.15.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:26 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:21 -0800
From: Chris Down <chris@chrisdown.name>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
	compatibility
In-Reply-To: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
	<9huz5wy4tufo.fsf@tarunix.c.googlers.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203421.38c206b35f5b12e6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

tarunsahu@google.com writes:
>Techinically this is just for readability.
>
>WDYT?

It doesn't help readability in the generated docs, though. kernel-doc
splits the parameter list on the comma inside the macro, so
kho_preserve_vmalloc() comes out as

     int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))

and the struct memfd_luo_ser and struct luo_session_ser definitions in the
ABI docs end up with a member like

     DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;

I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
pointer can then say which payload follows it with a comment.

Chris
