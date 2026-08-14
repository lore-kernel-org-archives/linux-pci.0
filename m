Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF313EFD30
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691694; cv=none; b=dd0lV13RUo72tn74i1hUM6+7VEpT+CX6hXaPRWkXSXtH6wuzl0XSxL+NQd4rvhhGnXCxcGTik2pUZVUGtPsiiMFjW27GfTBmFB8jBWsnWYPmM75AwFnqDdThf0JefyTTfHHVQwt6pYU+bIOh9gRjXsu2m1QrR6zdZBrjGYzVkMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691694; c=relaxed/simple;
	bh=A8ymbXJxu6QrxbooTzbkqWcSR87r+om9rR/AXCp8QiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7dg/9GIhow51RoHc53m7y9FHQTREefdFDggy8g8J70LRjeKvDN6dJD0KpmiSRIg85XeX9i6NEd4BuL9sSLavfmJA9V11WVxA0zRqv+/kb4TsU5c0/+yIWdDM6KcFesuXnyRXANKKFEjaQNjC+8/bGrGMxjucKmogwuugMiJ9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ0FAXgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ0FAXgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E602B1F000E9;
	Fri, 14 Aug 2026 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691690;
	bh=8u3IpaxSsnPpplgmItjzsxdmPZHyrh5kkXCzIGd1US4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ0FAXgllhUYMw2AIVs6CDrA6xur75BqtW8nBY302G7EDnRsZSOT8x22YD5hjv9ZD
	 mKg9OqHBhPl41PuM/Vc2TvEK7OkrhF7ElkLK/HqLlOte+gdfh9l6QJyTBT7tAxdJ8U
	 cEcBCDgCqtDt0nFqYkeOolu9J9eMHmIWqsS4jcIkbdqMtPIRsmdXzNccvtXNZBaarF
	 HgSyUQFVaLsdnKG7DBHP+Cu7PYyojGC+O9GYaWs0bA1JGZ2iO8NTwp3IItCetkpUE0
	 yIx4wo3R1tie79XzGUD8/4d9n4pKqWJ5EMG5NpXT14CYpMN18SsCt3ZWDfdxbqsA4o
	 pDftgEk4merVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Pass the device name length in UTF-16
 code units
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814070522.2327975-5-kwilczynski@kernel.org>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-5-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:14:45 +0000
Message-Id: <20260814071449.E602B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, dsm_label_utf16s_to_utf8s() passes the ACPI buffer
> length to utf16s_to_utf8s() unchanged.  The Device Name _DSM may
> return the device name as a buffer holding a UTF-16 string, and
> the ACPI length counts bytes while the converter counts wchar_t
> elements.  The converter therefore receives a count twice the
> number of code units the buffer holds, and that count is its only
> bound on the input.
>=20
> A NUL code unit ends the conversion early, so a name that carries
> one is converted correctly and the error stays hidden.  ACPICA
> zeroes the entire result allocation, and the padding placed after
> the buffer supplies that NUL for most lengths.  Lengths that leave
> no padding, or a single byte of it, do not, and the conversion
> then runs up to its own length in bytes past the end of the
> allocation.  The bytes beyond the allocation are decoded into the
> "label" attribute, which is world readable.
>=20
> Thus, divide the buffer length by the size of wchar_t so that the
> converter receives a count of code units.  The division truncates,
> so the converter is never told to read more bytes than the buffer
> holds, including for an odd length.
>=20
> Reaching the out of bounds read needs firmware that returns the
> name as a buffer and omits the terminator.
>=20
> Fixes: 6058989bad05 ("PCI: Export ACPI _DSM provided firmware instance nu=
mber and string name to sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814070522.2327=
975-1-kwilczynski@kernel.org?part=3D4

