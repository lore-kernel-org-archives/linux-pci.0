Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB8528441;
	Tue, 22 Sep 2026 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067341; cv=none; b=Z7DdgHWwdd7yBbYebbmsj6OZSOxqIk9AIMKECZ/T9V0qAbIPYMpUd92da6NnwkzLi63ZyFKn1wQW3+xfPcC0FXiTpKylPa+tGn828YkeoSE9q4LZGIPBznpQcB55Q3eo7jzhIRhStZDfSzW3I/00kfXAh7T23e957rsJv6xujdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067341; c=relaxed/simple;
	bh=wsyzxRC/v2lyvbSb6sTZb9PFpPIOqvPDHg/fhBvYS8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hxHb/WDDY++p6n+iZe9ez2GhD+dOmmL36oEr4M34ANTMj88wh4rVluH/eYkUNuxQ7e99TdgiyCYo9qBAjlTCwfkG2qyfvW8CF1kUd+ZaKbttamEpOyIE806vB1J5ZcMAqqekCchRE65cv7q0e6nC4eUdQmjCpuRRbHpdrutI2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUwpes1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUwpes1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39231F00893;
	Tue, 22 Sep 2026 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067340;
	bh=wsyzxRC/v2lyvbSb6sTZb9PFpPIOqvPDHg/fhBvYS8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUwpes1l6fCU6mOgJeRrHc+UMU0h4jefQkJG6v5ThyJf8//6Yo+UkAscN1ulkobXU
	 ctzyxP1McgWHA2XUEQ6JJgLsUSo6+qrmSe+8ReelTbLDdop9det/SIUz0AD2iUZCNP
	 o5OSdK7K883vu29mV3d7WVP3U+UQuUa8cI10KEHaApoyxiPueZguVRrfV9+4PtPLjg
	 DecGEyd8D+RG1p0PbXB9gAVjMITtcUZFsXUP3j/p18I9uYwNKbEMDNTNiipoJ+tFIt
	 2laAINWxBq/1B7twBQvO7bGoKg/JO/a7NS+KXszi4Y4jZK7x4f+58AMtyYElZ7NzTy
	 aqdLm7dNu3zxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/15] cxl: Share HDM decoder register unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-8-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:55:39 +0000
Message-Id: <20260922085539.C39231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor HDM register parsing into cxl_hdm_unpack_decoder(). Validate local
> values before publishing complete settings, including committed, locked,
> and target-or-skip state.
>=20
> Pass endpoint skip state to the DPA reservation helper instead of
> updating live endpoint state, preserving its ownership.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D7

