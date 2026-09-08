Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FF5237A3;
	Tue,  8 Sep 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894572; cv=none; b=b/s87a9+/1Q5A2hGy+fsAUiHCKxLipv7gUYXICS456F1EV2WsiwM9MjzNeHHQGsp9puO/BNL9BMIkXPhxklCnT2/WjO1hQDM6eMvQTDYw6Wv4EBb1qZ7Ulnebw9R/+2FfMClsPTwNlGZT5w21pma795Y2C7E6HVlpmNy/WnRVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894572; c=relaxed/simple;
	bh=C3JU6JVonnq1rHdi7RO0Tzn+6zPPT7l4IN4lb91M6f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rIKXMFcMA+o1L3GQloH2zOEpjnWT2EdryFvCc9MNOdfZo9cJBu8i7WPi4x8TmHEEa7BlWlQy0dyqbt3Tewww/Y6vAUfzSQSMBJ2KlT1uq/R11kGJr6BNfVzhNKoRtkVxut2HlL6mwN6zVk5sEPPCZ8jC240+YiLbeg3enyykffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ms8qI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ms8qI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926911F00A3A;
	Tue,  8 Sep 2026 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788894569;
	bh=poAew8xXlGpgtaNFHNzuptsS3IhNiYMVDi86tLqDY6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3ms8qI8GTSzyNO5Yh/JoAsdKbAWaEK18Az0kkYk/Hu0e1Ea3McEZHwWilBfZ0pph
	 sV8Um8HN5WYeaiu38+oOwU/6iHeUiwSDvJhr6S6UKJvBeGp/t0OduunFzigrJlICwt
	 FxPMXN+CsJPWqRXTFRd8gp7spNKLNFl5gUQGQ6XbM/VNPaStfx6cbNBUfZbikpiRHD
	 Fy8d1t822t6oeuFap2Uu9HYIWvGzS7057nAy/vb5vXDhX6c7I7T6BGtQAL5jgxr3vo
	 hWW8NpBmDiU/dn34hrmcnUFEO/Y0Tkz4r5y4TPohCHeqCeJP3evUa8/N7bYGXWq95K
	 dxwBVITl09HMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260908190600.226485-3-mario.limonciello@amd.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <20260908190600.226485-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:09:29 +0000
Message-Id: <20260908190929.926911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.
>=20
> The issue is actually a problem with BIOS configuaration of PCIe
> root ports, enabling a feature that causes problems with 64-bit
> DMA.  It is fixed by adjusting the kernel adjusting the
> configuration of those root ports.
>=20
> Cc: Arthur Husband <artmoty@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908190600.2264=
85-1-mario.limonciello@amd.com?part=3D2

