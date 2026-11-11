Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379721;
	b=bK24HdRUVtEJSM48EwoLp9vFcgiU2SLmIkPnR3gsGvMx24vdCGnv25kSHd8j/YrSBqTL
	 ty+0SzyCZHairGbuGGc12AELAMWFlvnWul/hcNK4T/FcT5wFLHFJs1pURGjvxF1vca1BX
	 WUNUPZlOqNmWQWdD/ctnT0XMjCI6HgdlEEUeA8fJ/obIUonAJVSSS90YjUjd8OhhmVRB+
	 Y99imwklun9RiaOfA3Sy2cNBh9WITvvR8cXRwrnJDO9SaHv13jDN07g9XaHBB2/3G97s7
	 groVT7Dld92DsoiH4m3GckMrzTvmPBClSCU0g7LF52ctKk0aj/wFIzQnb88VkgSfHBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0LYdhZt3vdhRnU7A+opZAv9XS0sXtQ5zbCgxOw9TyAI=;
	b=q41X+fdYcIe6YaFfhnuszpBGptE0oWGhaYfPg4cnXqgKai4gsgkwASu9X47Yy1o78vFA
	 LwTk3UqjzQ/0iLhJ8nYgnuXJhNxMquDzF37STD9qrSilQnJaYEeZLWOr9A7+qLwsSx7k9
	 Jw/p2HF118gPLBTelCm9qm7AkwIgMkh1voTJQbwFy2x5nWGmevLN+J9Vdun8ZOfm/A8Wg
	 VWALRbNyB+WZ6E3rb0X3NGQFweXF4AH4JCdQaeLyU7qv63fTp+SERkAsURA6NZtEBPzrs
	 PdJVVv/lOVuuWzPExQgh6y/N3N8LHnWdw2oEkdzaho/++26wYVn+PA33uf2TsqxCT5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN+0kHm7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934C606A335
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN+0kHm7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0261F00A07;
	Wed, 11 Nov 2026 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379720;
	bh=0LYdhZt3vdhRnU7A+opZAv9XS0sXtQ5zbCgxOw9TyAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JN+0kHm7MXOBCjSUsNShIqn+XVJJK/ozNQg0/RJOyCz/m/Y79muwlXnWQu3JX5c8r
	 9xR71aLtYZx66CbADcKYfZnv8Nr+2BGMf54UU+ShOy/d6iqcl1/GRZG11GHsLseJdi
	 50PiB7dYGWzYuN8N4ybZFz8nMrW2o6w/QCecG7hKN/UYrWP2TseY2/xS61xuff8QEK
	 +VbhPaaB85bEOdqo/O2TTj3VUA7mq9pP6Kv4cg+PmWM9Hn4X43OebIt7C95RoXCmpy
	 Q7EH6FjrQ5Ed1D+UhQud9PQPMoFVhIgSE5A9MDJ0f5mOhasCQY2WIuPlM/IwWHJ9W1
	 GbY5SHdcwNSdQ==
Message-ID: <sashiko-outbox-208461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594
 dGPU root port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Victor Carreras" <vicajilau@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111063221.14478-1-vicajilau@gmail.com>
References: <20261024054711.21587-1-vicajilau@gmail.com>
 <20261111063221.14478-1-vicajilau@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:48:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On MSI Summit E16 Flip A12UCT (motherboard MS-1592, BIOS E1592IMS.111)
> and MSI Prestige 16 Studio A13VE / Summit E16 Flip A13VET (motherboard
> MS-1594, BIOS E1594IMS.115), the I2C touchpad (ELAN0305:00, 04F3:31FD)
> permanently stops generating interrupts as soon as the discrete NVIDIA
> GPU (0000:01:00.0) and its parent PCIe Root Port (0000:00:06.0,
> \_SB.PC00.PEG0) enter D3cold.
>=20
> In the platform's SSDT (MSI_NB / AdlP_Rvp), \_SB.PC00.PEG0 sets its wake
> GPIO (WAKG) from the BIOS NVS variable P1WP, which erroneously points to
> GPP_A20 (INTC1055:00 pin 62) -- the GPIO interrupt line wired to the
> touchpad.
>=20
> During boot, \_SB.PC00.PEG0.PON() calls \_SB.SHPO(WAKG, One), setting
> PAD_CFG0_GPP_A20.GPIROUTSCI =3D 0 and HostSwOwn =3D 1 so the OS GPIO driv=
er
> owns the pin. However, when the root port runtime-suspends to D3cold,
> [ ... ]
> owned by the GPIO driver.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220725
> Cc: stable@vger.kernel.org
> Signed-off-by: Victor Carreras <vicajilau@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111063221.1447=
8-1-vicajilau@gmail.com?part=3D1

