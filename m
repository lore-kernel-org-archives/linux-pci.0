Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2663AAF6E
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031342; cv=none; b=Zq7Cw50LrtORMf4T30GxsKDR96jdOkC3kQ7URFR1Mt/G4QBuf4g5F00pOLC/EBKpSRh4/xQMfmoKKDmnqv+hwh2cegOIRGvxeVwjIC+4j92iO+k/0ifzhntGJTF3eLTQQIEgurf3NOg9OaGYOUOO2Fg2ZxavLx4+X8ju2A4qKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031342; c=relaxed/simple;
	bh=1Baq5mHMTA+/ottL2WThUSBqVslSUW91OpUWvqqRnX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDkzqSOMm1b4ZWcN9TVlNldhL9cd0EYN3X0+l04BUIoIzTV3B21F9h3JNt2mEIi20KK6xRvXMReceHvgmDRgAPtmhufXvvDlp3kwFhotYBLWHaCZdoulidcNntH/nOW6pK41huuJtCL53FxX23ZVUkdLYP6WsGEhLWbBZkNecF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEiCSHan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEiCSHan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8FB1F00893;
	Thu, 10 Sep 2026 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031341;
	bh=K3F5RPI7/4eWgoEf8qym76NP2+0waJEFemnp8bspcpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEiCSHan3exsBq74a/OFH1REnfs+8NiO/R9lYvHWDOq4Cb3nYP6DIxSsxMe3hQPo4
	 /8dmCdwdaFDmbsatE7oLQNea7lF+43oSBC3agiTygFCfnPxxz3XOk8eORo4vP//jpi
	 NWCnQwAAuHL1BVBStmAhi2oBkn2WS5gMQdhPeyNyyCm9TqWHEPHFiobaZvTgN209MX
	 016EaxnombVt9SWBux+VRdYn0h0YoX2JAmFPRryD5HeYgHEWp3bLE8f4KBniF2ucja
	 IswSb2YVx2DDwxoaYH3ISgt0o8+1oTd9siXtC9hRZ4L98m2+9F3hSxzJiwHwZ39JXr
	 FrwFPiCFbaLAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 6/9] rust: Add `OwnableRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260910-unique-ref-v21-6-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-6-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:09:00 +0000
Message-Id: <20260910090901.5D8FB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
>=20
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D6

