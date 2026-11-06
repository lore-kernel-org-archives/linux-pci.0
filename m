Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793928820;
	b=lBlNMM1eZV2Srx8was1W9XOExa+E3VCpEKmkIiWApxXEn9Yu4FkZMXctewhhB059ZF2q
	 /ONQ47pKFxcsxyaDCHqFITZQs49FuPvmoTuNCDblrp2YEZExwigq5cHtAj95+0cUYoMLx
	 k/BBgvZzPaW3EhHmOiA1iXp5VS6Kq88pCRrhbgLztPK/w/ExcTfqCxfmYX69DFhRG/unn
	 zh6DDi0AQFCjRnA4W8MaDSkc70/qsx3nMVK/f/vMHx01qhdrAsxK+0YBhHRIxhEfWd9Kn
	 Euu4YXIYl29HCzvrwMiEX7s78bnpv+nD+Z+uxzXiqH9c+7k1vyNbF1P9/5qBZVMD+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CdnjZns0js8EXeyV/PVj+lyLC44xJNnQLVnomUyHRI0=;
	b=Z8UOBB8O0qU4rGKbGlQboXtpuU6r8fKTBaHr7LmRV4EWM6mygrAvU8hrFu4dT5APBLeH
	 ctWA0/CMfY/Ty6qcC8aDhYzCG540KgtU6p4iAqsLZOzemP4p0BkEggPl3vCEVnHd8eJiX
	 Bu4FDYTlG+MH8ukbVc9B2/PA73KphdicfBXate/sOn3UYI6iZAw6T05tmGU3hk6sEtVQR
	 zcR12qOqIm37Qmh7U6jQx8TgaPph02s5gNhcqwbp5EYwj/Y9HBbAa+7hhi8sLmRZAcpdb
	 8BwOMUsvQm0ImuffYF2QASRDFbYzOtnhMACUYE0xl+dZZGlfltRZ8H/Rl1LCNqZoYhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GC4CHbvU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCF606A31B
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GC4CHbvU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A6B1F0089F;
	Fri,  6 Nov 2026 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793928819;
	bh=CdnjZns0js8EXeyV/PVj+lyLC44xJNnQLVnomUyHRI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GC4CHbvUSpr/BPtixI7q7LvMSKNlEBduPBqrkg5bcnwzAGD2NRPHYRWbeIwrPzSdD
	 42dF2VLyXawZh50xQ5DpH0p9Z8rHrUdZ/LOP3MCEqY2dCThpygpv05LdsPndss0YEI
	 HFV/zUjqOmN8Fu6XdjMELp1U5EKZT/DAVIbmYd7Imka3/pAHqtZcBHm/PK1c0fQiCY
	 hVsQ6cQFzbY9q/nHzJhs5vgbdw3kRhqCpAWo5INRMBlcOt5W2be+F5ZgBX4Bmy0NlY
	 zbLILjyCTNoqT6UCprOdDmRJRKY/cBA7XtfGzXDuv70/tUQXJVQu7MHnCdfm71m+j9
	 uHNN8pV6MYLSg==
Message-ID: <sashiko-outbox-200520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: octep: Size the interrupt name buffer for the
 full format range
Reply-To: sashiko-reviews@lists.linux.dev
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106012126.3385789-1-xujiahao@cmss.chinamobile.com>
References: <20261106012126.3385789-1-xujiahao@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 01:33:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> octep_hp_request_irq() formats the interrupt name with "octep_hp_%d"
> into a 16-byte array.  The prefix is 9 bytes and a full-range %d
> argument can add up to 11 more, so the worst case needs 21 bytes
> including the terminator and 0-day reports:
>=20
>   drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output m=
ay be truncated writing between 1 and 10 bytes into a region of size 7 [-Wf=
ormat-truncation=3D]
>   note: 'snprintf' output between 11 and 20 bytes into a destination of s=
ize 16
>=20
> The values passed today are OCTEP_HP_INTR_ENA (0) and OCTEP_HP_INTR_DIS (=
1),
> so no truncation actually happens, but the buffer carries no margin over =
the
> format's worst case.  Give it the room so the warning stops coming back f=
rom
> builds that cannot narrow the argument.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@i=
ntel.com/
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106012126.3385=
789-1-xujiahao@cmss.chinamobile.com?part=3D1

