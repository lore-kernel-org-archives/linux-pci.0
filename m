Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA470EB9
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370754; cv=none; b=nzYURkoX7xPGLVjzH7Au4jwKVlpANY+df02rZWeDXSFk+GFqg4TATOm+YbB+QR8QxAIU2LCymul5DPKRc2sjEHX1cgYQd8tmO+kR6NdZV8pFUMZ8Hoxa4bi3WStQSWA/UuR0/XdaZYsflHXhx+c5kS7ihbJ3B9KK+wAZy3Z6ODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370754; c=relaxed/simple;
	bh=B4kanr1bAPnSbM9prDYxROIXGs57qZRtTvMnrTqMkDU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RSp7K7Axo/Jt2cXY1F70i358OSz1rMbk6FKerGhXdfwJU15h6FaBpONM/jpSdU2lpfT3kTZzCjjQO5vnze0UQXLkARD2HY5FtZfNG8Rz5HclXnFS+ngwRYCEjGboLWdcNPxRMXKQb8pJSqs839Y0z1sSOM1jOY3Kq+cGp0NBenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e38THgBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e38THgBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2A91F0089B;
	Wed,  7 Oct 2026 10:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370731;
	bh=B4kanr1bAPnSbM9prDYxROIXGs57qZRtTvMnrTqMkDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e38THgBChtpCP3F+t/MPfTMLXeOEQ/UCEjxBXg46iNVimWyyZBi1wzkzN1HzmnGoP
	 wT3kpNC93V9+YZANLbeizgL/CsWbNKMtbC1hh9J6Mb0MHvbw/zycIOmP2mekoaEU2J
	 a32oCqAupLZSZlJJ+f/vnmb0jkz5XP6HQ13LAhVk8vD/Kg6qmHhp9P0Zs6TrQx/0yU
	 zJkMivNVNKBVmxSpy/8RGT+kWQ/RfMGuq2apOh9sXNKjiYgkvSCZjrYTxZhmnA2Hl6
	 oJYV7OzBEo0hz+XcsX8YXTnSveyvE7u6OldrQ6ZIybjhunPrhZtqOPfLs1TqumDwqQ
	 t8v3GXYrVSzTg==
Message-ID: <sashiko-outbox-162898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra194: propagate REFCLK select GPIO errors
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261007104847.507776-2-phucduc.bui@gmail.com>
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
 <20261007104847.507776-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:58:50 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> devm_gpiod_get_optional() returns NULL when the optional GPIO is not
> present, but may return -EPROBE_DEFER or other errors.
>=20
> The current code treats GPIO lookup errors as if the GPIO were not
> present.
>=20
> Check the return value and propagate errors from the REFCLK select GPIO
> lookup.
>=20
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007104847.5077=
76-1-phucduc.bui@gmail.com?part=3D2

