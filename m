Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157526;
	b=emNWFScMAiK96R2cK0w8T/4b5WYhMfkcPN6ZyQ6MTSuda5LHYZhoEog1jWJTETGDpx4h
	 CAbSW9svLhfCxXStt9QQTPHzh4tOovMO5hO0CAHFsPuF5ps3Z1gMeEEsaaBNwTYDBQZvJ
	 F7bEsK3TlKYyh+7gRNev5YiMGxSCxr3yDSuAOsV0LKGy3w8tsv9dWmJyFLprJe0ZuL4vF
	 vhMdHOafRoic5oECOYRDXVKQqg5nDwS+bcRYbTThncJm0f0SGy+ClsV9cKJTVpXSdlpGt
	 vIUIrSS/R0JvGrJrSafH11JVgcDELiWrDBNQstRo3RBzUE7JuRCuQ0zKd/xt+IBJh/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C6oQKahFhRYk4PxJPPRL+fR1s7SzwnZnRrRTpZO5YhI=;
	b=MXSKWj3fqHDtghuLCyBifOp8ayhoiQ3lkPUU9BfXwx8yGNfiA1uCeoU6CUDaWcrzpLTb
	 BNsnhIcnTqu3kKDT0O2QBtsnKyMF9YmMR4TO2SLl6KwlwJ/aLWYly9DdCkjrT/G6PJweZ
	 8AatoeDXCCLTBvth25lVsiSCwokFRVC3MzbHiTFolCwiUD3v2JuLMXTdoxwUACTeaYKDf
	 2aLCMQliDMYcKMfnZRa/eISENK/vPXkmETUr5KOw8CcLZfTi0y0uUfSfycg1WB2GQJ0WU
	 HZGwhOxVw3we2CJjYXuPAAOY/pL9a3F1Qlp2vqb9Zp42UVhIYNNGh7FET/wtpp7A1Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBDPjMTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D670606A323
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBDPjMTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB9A1F01828;
	Wed, 28 Oct 2026 03:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157525;
	bh=C6oQKahFhRYk4PxJPPRL+fR1s7SzwnZnRrRTpZO5YhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBDPjMTo+im+/ESxpovEuE6iMwVa+/oavD8L+msyrS7OK6nHzGE1mSuqdXC1HN/lj
	 jantPN8PmxWE3IoIQzxKAiU9PSX0tRgKWzmvJ3FeQFHFBJl4cDTeKfWaXfsSFRjQ+0
	 lLTdmWuq1sfvHpUAV8Jjk8jH0bRLYOn9f5P1quAklvcoy+J8Qk5e7i+K6Y5wJMXMbx
	 pW5vxXTzPJCkvSZJZ5+gHnLeoGvVx4+ok/BeVe6f1eazEMY4VYrJrxAa0mL5b9k+eX
	 0SwDNYqIavhpw97Jh2gA+J1G9JGQy/b4HWAzxwEmh0nXUCU4PP6QoAPObEJdfdVV0M
	 0J2byCOlHVcaA==
Message-ID: <sashiko-outbox-187412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/16] PCI: dwc: spear13xx: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-15-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-15-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:18:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> spear13xx_pcie_host_init() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap() and store the offset in a u8.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D14

