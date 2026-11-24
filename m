Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546936;
	b=4SfDcWyeEzLUMsuog5MouGJrr0VmROZSS/LNWpkgMK6L7YWJOSDGNI5lB5JGa97djLWw
	 pSL1TwFH7EhhXoumv6+9RJLwFJJTVFu1Qtf7R0ghHowC4xYsLrZm4Hci2/OEQ0N8MQDDd
	 RqzwcPIm7uFOJNx1fSCVVT/dMbq9ECeuGny0RqPykzry0K8S75+zClCQNGFEoyQ60r8Ed
	 tq7Slt3jcw+iRGsWzAix3EvNxA7/IVYSwRZDiUbiHzqYYuP2ZxMiY8bYTSmP3LmvWgUhH
	 XfsmBE6+eFXoU0m51nFVxRufcpL2lyBwe329TIK6wCT6oNt3zBWclH3gmohCDXaZxOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
	b=m9ME3Xfq5UCIp692P+uYFd44+dSN8cDMEeBrnrt6hTFBorlfoJV1J6VkESrizixuY5zo
	 C8ChTEjJ/A1+1aKmIbqLcpAtw6Xwj3k1QuMQ8Sk+V45th47UTOLpN1NyhzD6cEkB0/84o
	 i4XFZT216+1ZEwEhqwTPF6FCK1nwHD98D+a20RVwYtmDth++BRySxhO180d3WaMoDkGfe
	 S8jo+2tOYNMw75JAx98zzZYBP8lL+3CRBNvrhPUbmd1WapHqLb+qyaEYIUnfudcHUN9vR
	 TGXBm5WUNjPwlF8FtQp9Wij2z8VCXJeWo9Gu6dbrIucQrwhY8IU3xt2SA3+z6ecBMzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB666606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB666606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso3432860b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546935; x=1796151735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=W49HLn5RkMaC5OffA1iNYwWj3QcXjho4bBBEYyHJ80sMc/UPULZx0is/eDJpC2N3ib
         U5411fK9H7EvaHNUiAzyNcMRaRfWUePxiO5nF6dXRnWQcakCLoOcwBez1qwCR6R1oIfe
         q4c7EtVSFXNeliYrDeUDxIDrBA9ZIJuyG39lD2tcmw1MBgaf0y6E9eqLCYzDMbFPT8aQ
         T2II96TRsePidFGcPlSyAkLQbRIPL4z8RKR0PPlfzSoiEzHTM2cY+rkptgAAFD2Cwvml
         DpAfsAN2AKGhtv05DtjXMcA4gmT2Ub8TyWWHMBLSJzr10iAYvLD8v6nEW2UiNe6xEGzX
         AF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546935; x=1796151735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=gRg47VT7f2krEgqRIuFlmK9VIGa6h+EBTlvm47ZpLcHD4ybbq5grl6uhQZYRPYrn3z
         Ib6KQJNXASQ5QNvliFzAL7u1BnHxSIUlz6njCT+nkahn8wZ4Hor9GGVx5nodXNghtm+r
         TbfBysa8VeC0QppRpAG7BWUodfJf1XfsXFnwQ93oS94y4QoEre8R5kJ+U4DbiQddM8HW
         rXL+f4hX8OkJeCYtqLFNy45ORbDz9BkLjrbwB5AkN+FH+TpT2A7xxtA9Q27XSsk34J5C
         HFF9axf0VHyncIRyUg12f4cmohLD/6qsVgdlCa9o9rHohv/W6aU2mjavLzqf44ywGJ81
         gshw==
X-Forwarded-Encrypted: i=1; AL+hErFksBq37lm6tQk+RqzeCDPGb5kKv0jjmxTQ1xrJ4Q5xkrLcOwwM5oPfDdoJ1OcPipuanSbYeuSryIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vUTUHL6jJTI7e2AIl4qK4wP+pmY0MRSzyy1OLX/08DjWujxu+
	zAkeE2qKCWowmzWvT0s1RH6DrHG1Suk6dG8rdX+U4bbcF7MzTQa72BNV8M8XOELwHg==
X-Gm-Gg: AZFdTZewiwZtlvD53CryRAc4WN89JnScwbgSQKHCZTnVU2IxFAoyK2UqDUhamArK+kS
	s0DUtBdz30ZRqTvIxvmHeUUcHiSnd+qdwStc4FUWOMlhRmNTe18KGwbF6mkKaXvZ9GjpUwU1zzY
	J2a/SpgmvpWcy+eBJYlbC3tBeSE7pXwDsCQ2DCmlHr2B27V3MdKKYS9O6kcbtMeng0GarF8TQZB
	Kfau+bKo/Jum3LHurO0JcRwYTJwseziubSdGh7lfK6/Nk8ss0lMaDpECX3EytvFA6jErctgJWHu
	1Y/pqj049xUknallMJv9ZMNRXZb+LMlBBefoGTzutzqh6nz9bZe2j/bkrk3yDdWg9fKPbF3iiRW
	1+WUhoD7NPzDbsu37ljhkmvLCOAF4munAmLooOGc+IQRUFM69bmK7zBTTGZmc54l4JT2M10Ag6h
	RzFNWOP/2yBkq7WwgnouzXuGSaTeENyTYos5wrHIC8gP+fNzzvy5avtkSh4cbdZE/RRV4QcYr6R
	yYiGGpGmWr6DU/vJkPVqIHdwv6675q5afCOdP1TJ7WqMZpwtcJa+dbV6WxG7vFS4WowUmw2TAhB
	5ZnDRPdyNtct4saDI/sCSGShrac8LCFzKI8vg7DYWMIa1UhlAvhLpdFfBFwvDPgj+A==
X-Received: by 2002:a05:6a20:a11f:b0:3e9:f2d:d556 with SMTP id adf61e73a8af0-4014ca44d17mr16159174637.55.1795546934090;
        Tue, 24 Nov 2026 11:02:14 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm2247135a12.26.2026.11.24.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:02:13 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:02:12 -0800
Message-Id: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
 <2vxz33sqz1xj.fsf@kernel.org>
In-Reply-To: <2vxz33sqz1xj.fsf@kernel.org>

On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
> I don't think it buys us any functionality. It just hides the problem in
> some lucky cases.

Following up on our offline discussion: I think it's worth keeping
support for optional features, both before and after the spec changes
land.

Before the spec lands, optional features are the only way to enable new
features at all. For example, the PCI follow-up series [1] preserves
BARs and bridge windows using an optional flag. It's purely additive: a
kernel that doesn't understand it keeps behaving the way it does today.
With optional features it can be enabled as soon as it lands, and Live
Update keeps working in both directions, including rollback. If every
feature is required, there is no way to enable it until the outgoing
kernel can learn what its target supports.

After the spec lands, optional features are still useful, and at worst
harmless:

 - Kernels that predate the spec mechanism can't provide a spec. As long
   as one of them is a possible target (e.g. for rollback), optional
   features are still the only features the outgoing kernel can use.

 - The outgoing kernel doesn't need to consult the spec for optional
   features at all (less complexity), since by definition the target can
   ignore them. It can always produce the same payload, and only
   required features need to be gated on what the target supports.

 - Nothing prevents an outgoing kernel that has a spec from choosing not
   to set optional bits its target doesn't understand, if we ever want
   that.

The cost of keeping them is negligible in the current design: the same
number of bits in the header, and one range check on the incoming side.

The one rule we need is that optional really means safe to ignore, e.g.
optional data must not reference preserved memory or carry restrictions
that the next kernel has to act on. Anything like that must be a
required feature.

[1] https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@goo=
gle.com/

