Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D64397923
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570739; cv=none; b=X7Q66BV/KXuUHDiMAK5CyAdYU69LEnHkmHBVF+4lQ46d+bgfM7dn8tVjxF3zRd0oN1yWQLFT5YenZVLHB/4krRKNrrXcw4h5T/kDmy8ii5vU5PzV/u+wFwCBKWcm82B6geCIGmwtVz5BAcYh5ZB8zUlFqqsWx2Z5B+F6KgiMNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570739; c=relaxed/simple;
	bh=Ll2jJmxtsLgo7IRAD2PHMqXHyOAN/VbyEsmOlIL8gfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XW5itL2bFu2TZ6geVh1PPYmnrTTo4+FoM7tVSiGi1Rkg1hJAHC0zQS3QJh1FdmXyVclwqZfkEVSTJRF8OtuDzbTuoEVA/bx2cSkyv0zKF2u8g5ZolIBYZ5DtKj0KGLb78C/eStA8Mvf9WpUfU3crOUK3xu8bXefiJApxf+tbEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaffPDYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaffPDYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC78C1F000E9;
	Mon, 24 Aug 2026 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570738;
	bh=Ll2jJmxtsLgo7IRAD2PHMqXHyOAN/VbyEsmOlIL8gfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaffPDYG6O/pkAuaO6E6Reibdd9NqFKniHuLzL6BoAzBNVKjygdqTIERD3+WQgqJd
	 pxkkPXfCkTXpYJgmqvUCQof2eG7QslsVqb8Vz4GheaLLbuCQUel1GuzzD2UIUIdvYu
	 2CAkv4zRChtCU4wm9lYWMZ+dUEvuXAD/edwz/kSjegrgiAVq4nfy1MwXLmsxuGfBWs
	 VoaCTGTRBt24iNYu7cpPQTDEKvy81zhRMyL98LwbN7+z/lLsRrtYHGQ2OlCNygASUP
	 0GMGmZUmmOaSk/G0mot9D6fr03by9GVsd6OdpmAxLtmobSzc3jYhROHN77m1aUg3uE
	 80eSQIW5LXQCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 8/8] rust: page: add `from_raw()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260824-unique-ref-v20-8-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-8-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:25:37 +0000
Message-Id: <20260824112537.CC78C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D8

