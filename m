Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289265;
	b=G96zHK7a88+RwWHnWZojr2AJkv0tN2npkWtunKltVyzomEfxgfa4NZUf/YX5s/fw9Y9x
	 GOYFFjT8dIc+a4ydMktsEV2xFdwG0+iqWkcwxgSyXRgPkpj6aAagC/lQF4q3OdtpZZVYB
	 6RuBgZ+rAyC11PB58JniL/L6zfluqYEMHvOv9APJeCRj0Rnk43wWSEwsZbyXbIYP0ToV1
	 JAAKEPhD5iG+/UHTZmt54SRXSMiLXOgC3yHI7V2jFVjm3Ti3QB55juPPe3UL0gaBRRZ+Y
	 bCGVXmclF5Slx1HqFcpsA1ldXiPzxavWbJd/HaBrkjqQuP8LEHg9en647RkzAvSbnVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vgCxxpKWaNvCgEd4UezWZ6+M1pZBUWmyKFRgCDWQ168=;
	b=fnBivd/WvI1uIq0T7koiZoBnmyQr+aiveH0uiy46VNx0XP3ww+9tGFrR2nx/vaRz/ZK5
	 LUdDaV2sDDEnzaRzikiuccVePdl8PVzdHLa3rQprt0oOnIN59yD79wr1KuGIyPnDiuwK2
	 BP+bFpgcyusSpdCSKh9H7flzK0rjCuqXCu/R6PUzkwqN3u8iZCMzwgEkGRxgnDehFLm8m
	 TlUZNmKgQUQNOGPFK56qq1gCZ2p28yMD9/E3g0kwGfAShdUjESZ2neUmRbS0sFAvj/VkF
	 zb9J4Pz4/HnV6rv1aLZ+naUpgxWEjkpKrEt6C6yb8MYe44l9c56EnMOINrmf5ME5hPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNwYprx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2A606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNwYprx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731CE1F008A4;
	Tue, 10 Nov 2026 05:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289264;
	bh=vgCxxpKWaNvCgEd4UezWZ6+M1pZBUWmyKFRgCDWQ168=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FNwYprx74LgvGSRRUyYy+Bbi70n/PTkUqWXS26t9m700ZHtwVw+PCFTnj+TXsyR64
	 CfZysW5MMSPBREeH71DcjxeGeU7ROcfuECpUTLbJNTGm26CbjXJKKmATEZjNZi0/et
	 AGcZYbxeDevSlVa9RxP+AfTlNgdkCU2UOikmcQHSCXlKRJj0n/4+wErY7Lj61HC9oA
	 7NCgjVn9R5rp5nLrTgJ6Ovt0FRo28BW8oGbORCqlAsasPxgPofoqYZg7fBI64L+s/J
	 Vw8JOL/CMfI4LaUnyopytHeakLCiL0ufvBabUK94X+O0MSoOO1qVG14yu9m1zZt0Xv
	 spkIp0Ie60Mmg==
Message-ID: <sashiko-outbox-206326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ACPI: Check the found handle in
 acpi_get_rc_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110053423.2517-1-lirongqing@baidu.com>
References: <20261110053423.2517-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:41:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI/ACPI: missing Fixes trailer for acpi_get_rc_resources() fix
--

commit 2dd263c8741dc2f24a59dc48d0def98c31872ce2
Author: Li RongQing <lirongqing@baidu.com>

> PCI/ACPI: Check the found handle in acpi_get_rc_resources()
>
> acpi_get_devices() returns AE_OK even when the namespace walk finishes
> without a match, in which case the return_value argument is not written.
> The caller passes an uninitialized acpi_handle and hands it to
> acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.
>
> Initialize the handle and reject a missing match.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

[Severity: Low]
Since this fixes an uninitialized handle dereference in
acpi_get_rc_resources() when acpi_get_devices() completes without a
match, please add a Fixes tag:

  Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64=
 platform")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053423.2517=
-1-lirongqing@baidu.com?part=3D1
