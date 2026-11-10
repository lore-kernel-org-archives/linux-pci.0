Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303487;
	b=a7X+sM1NWxdBdSY4t1CNBd8eS+yS5AwWBR+R0JqfTsLmJQEYc59votUfHVsfZb8sQkpd
	 zkxErsMo//YQR93Uhu/+qRFdf9b7+gdBkmPotLCvOaVLJjZMO9d9Gz0Uu+NThHdZITrRQ
	 HNXPZJeJUF1GuO3w9rGL1SsQgeHlGOa/MjY4bNUwP+09BC+RS4k9K/TX4sTdxxnJ80GHK
	 8HeHw53/lWH0M21TBOavMoNjewJNdfxcetjJBWpybmhePuEA3KYdr005dirYqFfS4jx8h
	 Y3KGrf0ybcUiQsgAIbe5vsKsYtzfDKjVi2odYYNNp5wbVlJoMmPgOYo4JX2RLSXAt1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mLmQNHZFrFTnBNz7JpEU7QMHVi+W8lb3qj30THHitEM=;
	b=pH9V4lsTqEPPQO6FKikOrrNnxDHEkSPTSP3GYCHzygXjEp2Y0clDjykwoDqv9qerZtRT
	 yUt/1ekMzyGT6UgWgAdcSo9WBOUHuGUVVIJGuV7VY8VN0vAJZ5LMKp/efy26f4kd7kzg+
	 rJ3KLymsMF4DHkDGcDrL0KAhfAyy03ldZ3sccW0AW4McrKYXOZbmej5di7NX7J8x/Nah0
	 59/2Rq51Vf1J0tWz1E7LKwGuylJ6rtejQ4wSybxrasuJ8seIqq9u8am9m3sR6aup49y12
	 EBNl/7hAaeT/md+0dugUmkSfMjpRcMG+ga2PXz7lvhpOYFHRCGAdakhs1Du4TFm2A1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtyazV7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B6606A326
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtyazV7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F171F0089F;
	Tue, 10 Nov 2026 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303486;
	bh=mLmQNHZFrFTnBNz7JpEU7QMHVi+W8lb3qj30THHitEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtyazV7TFMAJRKs62lMKR10h6NB6OhbS0wZQlDuqmJ2ypFbKnJtdqMyedy7AhUe7d
	 U9lI0zX9UbYyvUz0GWpSGy5HpdBZhPIYxBVfTrIaZb4KmJLDTY+gqgRooWJJ1SmmXq
	 HDpOooi7RLQSvZMGclbT2BGtauKup0JL8iRjSkYJ19pFY8d1eHVsl1ebTd3qSvfwKG
	 9TrqqNUf27WE3VYld8rWJIXPMNzyeyEzQypVHz2832DWnijCo07ZdPK04P6Yq9FRqo
	 59vWLJc2ELy8qKxAQBsaJbmDauxq7mEJkng/C7IgdV0n7qDRYPv74GmXsN3wbbkCUN
	 14sYQbSsIsrVQ==
Message-ID: <sashiko-outbox-206786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] LoongArch: efi: Provide sysfb_primary_display
 for screen_info users
Reply-To: sashiko-reviews@lists.linux.dev
To: wuqianhai@loongson.cn
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110090203.2631481-2-wuqianhai@loongson.cn>
References: <20261029033440.973077-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-2-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:38:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: wuqianhai <wuqianhai@loongson.cn>
>=20
> LoongArch defines and initializes sysfb_primary_display only when
> CONFIG_SYSFB or CONFIG_EFI_EARLYCON is enabled.  The PCI VGA arbiter and
> the framebuffer console need the firmware framebuffer information through
> screen_info whenever CONFIG_SCREEN_INFO is enabled, even if neither of
> those options is set.
>=20
> Drop the guards so sysfb_primary_display is always defined and
> initialized, and its EFI stub alias is always provided, mirroring x86.
> This avoids selecting SYSFB just to obtain the symbol.
>=20
> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D1

