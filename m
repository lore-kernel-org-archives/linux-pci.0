Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706275;
	b=2GVwzzLdyOj70EVOrO/e7WnWmdI5b8dybnetqkDsxLIdSH9A5S54OE50DGaiH3QXX6VT
	 26UdR765Qhg0iV9R73vQDO5EMZVtWguHd4TDQuFpR9+ouXvgTyFVbktYnZy8nxwGX67ir
	 iKFSKKMxu90tA5Sb9RnTmdQNxTMN1Adblg7kIbViPZFMrWa3YDTlgKOTokYDK+vsnWJ2r
	 VEPdMlT5KH/BNCd57AleH2cyZ+OWrei6WN54KocGLS/GBTeBpRiyjcPmnw6mwBY13F9cT
	 ks2VpvfIUgU5S3z0qu9sUaGwukskeAs4XB2oiOid7sCov3bazpY+7DR9LrbQ8KUjGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uGvDU/x4O0EaeT3yG1cX8VG0EuxZnyKi3/SSFPAmiBI=;
	b=ThJ8H8AVc/1fIBFIAfB8HTahi9m4M66B0BP3AeCTAcHhrLaLmSbhYyZ+SmMp9t8Hbg+6
	 4YZNdD4hIOBEEmYEL3fmLUMKbamERD8dwoMcqLLakOYRT+4CpbGPlzFTyZThb4wmnjRke
	 EY+rIh862W9dBpOSSnW7iKatHoaiQ4kWsNpU+VP0lhYR7FxMzH+H9e01x52gnnWDy1EeZ
	 r3og6962jYMi/tblFNRqhvo0kljsHcd3Tb1Le9kBugIvs0eIhMg6eonRPmIhpIXyVzo8Q
	 RGwyG3pbxk03N5UZwqUIJHqs66Ge5b9sycwO7/ccD0hc6UyUk8M0JxsytaKgCaAoZfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYF9IJ9B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78E606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYF9IJ9B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEFE1F000C1;
	Tue,  3 Nov 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706274;
	bh=uGvDU/x4O0EaeT3yG1cX8VG0EuxZnyKi3/SSFPAmiBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYF9IJ9B8QxGpUXJnU1ZEIgPEzTq+ZiB/Aj/wz2gsO2KGQeFZ/PoS1V8y/w6duTZT
	 NIFXIPCsiuKWw7FSD6uE6ezG1JYCvqMu7JTcaSuHgLaF5QQ4XEpWrTrlQGqFVAlcyK
	 vc4cQs3N7RuWHYx9IO7pyoiI180GglJZQ6AK2u8/59F97C3A4kxGKlmu+YdM8ni880
	 eAPNqu/DMQKjhhzt4sfOSjlesv9X4BkHS/OLOkSk56TQbBVH9BP3BgPOIMiXJ2pu/a
	 YmTG7jDvvbmP8sYkDeesmGzz+FDzAw8rjPfCi/3xRJxCMMaCpe3PteqNvU6ualNt+H
	 Fz+7w81RvM/Ig==
Message-ID: <sashiko-outbox-195175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ACPI: validate _HPX type 3 record lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kang Chen" <k.chen@smail.nju.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103114112.74527-1-k.chen@smail.nju.edu.cn>
References: <20261103114112.74527-1-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:44:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> program_type3_hpx_record() computes the expected record length as
> 3 + desc_count * 14 in 32 bits.  A firmware-provided desc_count of
> 0x80000000 makes this wrap to 3, so the package count check passes for
> a three-element record and the loop then walks far beyond the elements
> array, feeding out-of-bounds data into PCI config space writes.  The
> record is also indexed at fields[1] and fields[2] before its length has
> been checked.
>=20
> Reject records with fewer than three elements, verify that fields[1]
> and fields[2] are integers, and reject desc_count values for which the
> expected length would overflow.  Reject revision or descriptor count
> values that do not fit in 32 bits instead of silently truncating them.
> Use an unsigned loop index and advance the register pointer explicitly
> so the walk cannot overflow either.  In acpi_run_hpx(), reject records
> that do not have at least the two elements needed to read the type and
> revision.
>=20
> Fixes: f873c51a155a ("PCI/ACPI: Implement _HPX Type 3 Setting Record")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103114112.7452=
7-1-k.chen@smail.nju.edu.cn?part=3D1

