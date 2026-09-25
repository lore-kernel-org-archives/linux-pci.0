Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E982264A9
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352385; cv=none; b=DDlhvV4KmSRSpYI35tZSGgRWXzClvOokYhnG+zHlI0cl882WhD82S7+Z+JOhpsrR/yBPEwU9M145zn+v8un6DKjvX1euZy6FV8rpbd8FDjcTmmO2KRLiQ2AirxgxSaZUuBZpK100ES6E6XTUaQDaKrZn4lswSxapvljpjomyO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352385; c=relaxed/simple;
	bh=nSWopQp9dDnv8jJ/tmPHqgcGOgEasht38NP7xR6vSr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7RxBsBpL6nEipA+SbDwC5oI92YIygpQjOxBp/MVFWDw3Rcq6GKsgydkouSMh9IO+TTd0PkzJRUMiqw0WLdVvNV4bmEeZtL6phH0173V7XaDOCbgX7Vgkx+Ja3JUCjkUoBg/kduekCxinjRhmv7SZmIc87bJKJgSMjwniARRDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGqIp5Hb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGqIp5Hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BB51F00893;
	Fri, 25 Sep 2026 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352383;
	bh=nSWopQp9dDnv8jJ/tmPHqgcGOgEasht38NP7xR6vSr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGqIp5HbYYR02daOK9LaQsJHjNJRgZXfa1gDdxmn93hKLNE2SUHCggXsq3bz9+fXg
	 o0N/3SS5S1stUpjkT/Knwz3WdLqYU50zAzObxvnwHECdEra4ozLBosnx5q0UnT4eVY
	 1Kt9ozNcN5CtURoF6q3RJawUinfY5OopF6HfcD/nOuu52YwjdX10DxRWzA7Xtv372E
	 Uq90F2S2HLy5xAwTZW2F47vQpVAq2zFkEj3uqNXARBwAeH4yxla9VV1V29RlCKB8hL
	 ODZObBTF7j1LuO+PvPZPdAMMmkA9o9d+bxxWx0ZE4JD7hDRqGBsHlKuhNv1weD60kf
	 02y++4g0t8DWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ACPI: PCI: link: clear driver_data before free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260925155846.2381956-1-yaojiale02@163.com>
References: <20260925155846.2381956-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 16:06:22 +0000
Message-Id: <20260925160623.54BB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> acpi_pci_link_remove() frees the link object without clearing the ACPI
> device's driver_data pointer. The ACPI device survives hot-removal and
> can later be retrieved by acpi_fetch_acpi_dev(), leaving callers with a
> dangling pointer.
>=20
> Clear driver_data before freeing the link.
>=20
> Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of=
 wrong type")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155846.2381=
956-1-yaojiale02@163.com?part=3D1

