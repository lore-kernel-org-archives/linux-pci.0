Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC326ED3C;
	Sat,  5 Sep 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568864; cv=none; b=figgfxZT0sJXXDRtWemMZSaYLSpadfIoJ4YDoR477axfdi1Yy6A3ZUhV4DBokvlSeNs7f69SfiCHczAeu0/m1hGwgJen4FI8JaYEUPsGkt0WJFjaTPwxjTOjsXeC+ieWOVz9qlBwci4t+5Ql3kLP2aZpYR2pp2fze3qjLkmtnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568864; c=relaxed/simple;
	bh=i1PQkZzDbDZ86Fo2e/cOeQmuYEvYACmQhy/2qhCmb+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nT7XEjOrdjdwAePnEKhBrrg5S9paAyFZrp33noqwzRFgUbF4dYdyv0eChlHK6EjIcboYbDpjCzb7tJU9eolTa3iFZLRWjdkfjJZAyO7iBQz0h8rvbV56GFOXIa3s7u2/c7LwPXKNJP2AbzgyfxZcjAL6d3h4CYi5OnhMrYJ97Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+sbqsos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+sbqsos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDEC1F00A3D;
	Sat,  5 Sep 2026 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788568862;
	bh=Cf7L/9rZsJFtzg7jjzjMop2JQwP8+qkeIufnq/s05L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+sbqsosqNgadropp9I14zQVRmZKhAnrapFWXJrLZ8l8lmU2FVCehkDcnwtLpK9z8
	 kpGxDu4nBCFKMjjpUm6CH15imrHkyooKMHhiDkNLQcYjAD8jDWa+qmZiNhq9GxTZIE
	 Ele+y8v2JeNeJVc3bcBUjoeG5d+xYUg0so/X/PLmdoXWs8X6v7JIq87hUXhfDGVg7M
	 eSWLhb/yjTYr5Z64RjHVdamr31qj0Ym9yc5eVpoBfg6SKRCE08sLfqUEQvBQ+x51eT
	 rxymZ47bcAR3quh45JLIY3Fp/CIsQQ13D1WnFtet+ruVRBgq4Ie7GPZQM72VFu3VoF
	 w5hE/Z7jNP37g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] Kconfig: fix typos in core makefiles and purge
 defective DVB debug (v5)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, linux-pci@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260905003005.118245-1-breno3011alves@gmail.com>
References: <20260905003005.118245-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:41:02 +0000
Message-Id: <20260905004102.8FDEC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Automated review from Sashiko AI revealed that re-enabling the legacy
> DVB_ULE_DEBUG code via CONFIG_DVB_ULE_DEBUG exposes severe race conditions
> on global state variables, leading to out-of-bounds memory corruption.
> Additionally, the debug block suffers from undeclared identifiers (TS_SZ).
>=20
> Following the core kernel principle of eliminating dangerous, unmaintained
> code, this patch completely extirpates the defective DVB_ULE_DEBUG block
> from dvb_net.c and purges its corresponding configuration symbol from
> the Kconfig tree.
>=20
> This version retains the verified MediaTek bugfixes and ghost purges:
>   - Fixes MediaTek interconnect typo mapping mt8196.o to MT8196.
>   - Fixes MediaTek regulator typo mapping mt6316-regulator to MT6316.
>   - Cleans up the dangling comment in drivers/leds/Kconfig.
>   - Purges verified legacy ghost weight.
>=20
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905003005.1182=
45-1-breno3011alves@gmail.com?part=3D1

