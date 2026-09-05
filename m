Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFB48D884;
	Sat,  5 Sep 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611833; cv=none; b=fp+YTLROb63/2WAhC6bXsYK1zgaE3I8lavea//WxXUFRnlekQkJRr5TfwSufeSe0wtQrvnynqb+wvESVIhNuugk0HVQs2RLJlndvU3DsKGk0Q94BnwB9of/vfBTz39F0M7SdCL1AbqsPa8NYDE018E1MXMdAdr4QQAtpJoIHDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611833; c=relaxed/simple;
	bh=kn3uNj73w/JaqeekccN1juh26QDEmNB8QINsN4BvTDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRvzKC8Lz3WT2+oOiNe1WpK7Y4fEb+aT7DZLjqP3oJSgrKWS5JNrSW5usRR0FOzHgSFvtsuBCMV66ahRUgT/fotj7KdVgLiva0kHYzJ2CBw5T3tgxpggXlnqpNuhnVkiovBmxmZ+kHNvOzdAdiCSmJE5XB1HKJG3oPflKxXhQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0NhTmUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0NhTmUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769A11F00A3D;
	Sat,  5 Sep 2026 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788611831;
	bh=kn3uNj73w/JaqeekccN1juh26QDEmNB8QINsN4BvTDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0NhTmUUl0fcj89phd0v9z9jk1PhrDNowVxCsaK1V3n1OtXn1zRF79cXLrTZRc8PE
	 KSlX1WDoaBCcPx27zzn5VjiKxKJPS9vp+5iV0gfmPAjC3+Wswe85Om49qXPK/I6ikM
	 zKMJ5BlYYkQQaGWl2qT4cat7Cf0Q2Hrjwr6DLz0HQor1dm7wnlgtU6s43e/lDAN2/i
	 /Gboe2c/ZiyGnkvkXING02VEQEq38z1ZaOCdscNLft/G8PZaJe0VCpd9b8atbdUFs6
	 qfYkRpiLoP9X2oBETDRKBvjK5RTS+H4J07CsmNEE8sihkLm0NbPczguIWR5ACrsgJn
	 UGj/XEhKOq0kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] regulator: mtk-spmi: fix Makefile typo for
 mt6316
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-clk@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905123450.5620-2-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
 <20260905123450.5620-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:37:11 +0000
Message-Id: <20260905123711.769A11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix a Makefile typo that incorrectly placed the mt6316-regulator object
> under the old CONFIG_REGULATOR_MT6315 configuration flag.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905123450.5620=
-1-breno3011alves@gmail.com?part=3D2

