Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682777;
	b=1MfpX6MzC5HgH08xJpJljiC3jYv5dNDVR5oBYvNykK1+j/jmvg20PAFMNa8yHdYojzy9
	 1CzJPWbz0htffp3ZqArjeKcd+8SV30whhHwFM9VGoZt3UIacZYXaOqeTMprTNMUHzSogi
	 2srR4OwWZgaadFss1Fi9Ud68RpSQhuV5c6QdZfGZ/v3fi4WiVr80xGwP9ox88xvIf6j27
	 xUIxARGL5M4H+y/aKRT5myqkrLde1Zz7ZKG0tUvNWo6mmte6fKXb057UUSMhcPs3C9xLs
	 AcvQBZaWodWqfRvCD3fvQFWeCh7MQBRkbFQS6zCL5xxvSrwxoLF1WBYSB2E8/FhyTtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MM4qKb+lwfz9u4oUIRD1UWE75e7K7Inr6v9zjgZVszM=;
	b=2LrwgGU3hiQB3fYp5y512uTgaeop/cmrVadh5IXsb2vhVfvE2XdS434W0hSjRQfeNm7E
	 Qyg9zttzuOnlkZeNsh4GFCrPhEulcWlENM2AWHu4QuQE5CuQ0EI6t4e1tG6cluSYpibih
	 YFKyBC8Ol2pOmsRsN1drrbsAxY9bxfiK83Bs4XJHoMhAA3jaaTYg3rj8ex0yy41M6zrT9
	 zQqf6F50M+bWot5QzBXYlfZdsg45Qv91JGKuQGMiYB9R6nXZ87Xyyo0/KF552TkgjMb8C
	 f1vtxIQZ8CVBb2V62qWMAhmOH7eeGCHLBej65918matOgv4UziTVUx9a+wruedcTkdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk4dAdwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53290606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk4dAdwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB691F01825;
	Thu, 22 Oct 2026 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682777;
	bh=MM4qKb+lwfz9u4oUIRD1UWE75e7K7Inr6v9zjgZVszM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk4dAdwQOmG4GJ5soumV+3aXqQ4zjQy/aTibAR1YCe8Ti6GQyEGmtYXU2GrR8HZtL
	 K5kXY6ghFdf4se8DjUqgticmj7nKarDCJK9VcZCppplvv4DUFxXI2RA1Vud3A2axVW
	 SqVtGPofa1tz5eq0RuIQyKpVNblcQxOR2ehV2uAS3G2aXw4oYEmOu3v5pyTchoseqY
	 0F3Hp7NGiGtt0V5z60qG9h0UIITgDEeLzMqPvlcAnQq+8MXUTbNpolBUjqUIF/4BPJ
	 RpuuWFxyHfBu5dyVc+uBrCZAeZiDZfkMAjm6Vd/obOjG4cXxxDRUXBmdRtNtu6smI/
	 uWJdqUyUBrIpw==
Message-ID: <sashiko-outbox-181695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] liveupdate: Rename handler compatible to
 name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com
In-Reply-To: <20261021152527.375070-2-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> File handler and File-Lifecycle-Bound (FLB) identifiers name the
> registered handler or FLB rather than a monolithic compatibility version.
> Rename compatible to name across LUO headers, structures, and consumers:
> - struct liveupdate_file_handler and struct luo_file_ser name field
> - LIVEUPDATE_HNDL_NAME_LENGTH (in include/uapi/linux/liveupdate.h) and
>   MEMFD_LUO_FH_NAME
> - struct liveupdate_flb name field, LIVEUPDATE_FLB_NAME_LENGTH,
>   PCI_LUO_FLB_NAME, and LIVEUPDATE_TEST_FLB_NAME
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D1

