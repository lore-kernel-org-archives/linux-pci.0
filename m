Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377796;
	b=R0KZ7fSZx4d11W1w5hx8OwsIQbBkuBH8wtNMJF1+dqh5btacGtIg3xXioxFsl+kwJk1j
	 +n+EDEvFkWlOW3vC1/IP8Mzo0Wpm0D/15Z3lhxO1kVa+9YjQ/3mxGDfXnt0Tk9QmLD4Xz
	 kC7wVktTDUTdtbC46Xkjeh7IXcqKxBINgO1xbpiVq0Grbv3XL08soVJKogucsoWzG6fdR
	 rURktfNPi5cYm0PQ8L4CrzqAJ4hdZiCrbpVhMX1AaYkAPbJfjN/gCnxvIhbkGlK8z/rMz
	 o0uB3qCDUpZwNXZjtt+SOrcZWYwAEud1Czh5Qrmt2ICw5MbDS2j2DkGRveUmtDdGHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377796;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XpUjgykRN0vFDha3zJ8L+z/s5zYun/eYAgoPua1NoMA=;
	b=gnz94qNt9Cp6xZ4ijB6+o/pupEghMsvoAkZLOCL4/mea3S9efqpX83KdtHmyUdxGKPFN
	 bLKD9Kv1ptAqEWrj4NWwR6mWzTdNCU2D+K3JZkFKB+fxVeVGowNMOyAalsUouZPm22Uwf
	 dnMlXgZYV2bUcf1OnaDLk1uByNwLUuap/fJMSePpFHpVSS67CSzcgnzCP5t+r6CIThQyd
	 W7mBoJcQqBoNyQy2jvG3nepi1SBIg6vG1ags2+JmeV2dxq6LQQ5Mgkp53zuaReAywxZzf
	 q4ZPIfm4HMneomuCkSWwZVgRKGnUKfwpb1CvSbqS1D1AZ/YfWmyT0zCjUUET1AamgFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRWyLjuc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B1606A332
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRWyLjuc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D372B1F00A0B;
	Wed, 11 Nov 2026 06:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377796;
	bh=XpUjgykRN0vFDha3zJ8L+z/s5zYun/eYAgoPua1NoMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRWyLjuc4FqV1ZiNtvfr7F6uvGFhyVzqgThcTe1+qsr8fb9XeRBjhQMREF09XUmd9
	 NO+GYZidhttYb6TPwGnmncqvDO+xfoInFX1T9wXihWIZ+yux5utnpLx/A1FAqjDlyB
	 OGBO4uNIeNIW/tyifSYQzJMCT0CH2tQZ2vr8HObe/BcEELWg9hhmTA/ycvXwiyoTk7
	 q5eWxl3V4b7EEhUeYCy9ZJ4JOWIzi4T5/MHmr2Oivl7C/TAeecu3zX16Le3yoCubyh
	 7ga0WzRSvV+/Bl/TZ2f5jeT/23MKETwOH/qFG0U80sLuLpIa3mPULZ7pjtenMWbEPg
	 Vm2dT4qMunoWQ==
Message-ID: <sashiko-outbox-208408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Serialized structures in KHO and Live Update Orchestrator currently rely
> on whole-structure compatibility strings or monolithic version fields to
> validate handed-over state across kexec. Any change to a serialized
> structure, even an optional additive field, requires bumping the
> compatibility string or version number and breaks live update between
> adjacent kernels.
>=20
> Introduce a generic feature header (struct kho_ser_hdr) for serialized
> binary structures in include/linux/kho/abi/feature.h. Each subsystem
> groups the fields of its serialized structure under feature indices,
> starting with index 0 for base fields. When a subsystem adds a new
> capability, it appends new fields to the end of its payload structure
> under a new feature index. Retired fields are kept in place so existing
> field offsets never shift; if the type or format of a field needs to
> change, the existing field and feature are kept intact until retired and
> [ ... ]
> layout while deserialization helpers follow the incoming header.
>=20
> Suggested-by: David Matlack <dmatlack@google.com>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D5

