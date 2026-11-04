Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761571;
	b=4sq0T758t5EYOkGu1FU43MIXRPOpdwXESvFegwYJf9ZA6gSt3faxBxFPPdEoj9L719wS
	 +loAcL7DO4Su6tikQTbXxlr4usVx3OjNBryU8FncpAs8aZ4cgdWzPu/wt4an/YGeQnxFy
	 xnRXCEBjaGGjMDK74ubYiLv7kbz3kbBBBaoEWyfFXz3cvtFSyZp5uKt0wjdpQo3DUEJ5T
	 8x7tvAvSDgPNYe7szzquJHeIpLfA5yDLC+/w601dg/uC7TPZqaXKdTc17wdin4iAEYm2f
	 rW6OYeUFprHIFMegvvsMbMYbi8G3cnQdWcXtNZS7INFInJ4zf2MCf7C81cXeM/4GDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wes34L3/OFrJRuJPtHLf9/Gu+mSzfsdP0d3zOcnXJdE=;
	b=2OjbHO3txc/Dy/XUTBK3bjC/hTjZCzAwqJBteeKT4gVv2V1iOEj/uzz+KONLINE1eaBL
	 7UGyKV9sQXb9k4wsQuQivJtUal0tw2v0FLE51vz13s1AuYxf9fs3O4EqNYUqVVSWrCpzR
	 Jm3juowhp/jGaDD19jsK974I3GYgz4vCpPADgBdIrX0SMmCVDv1n/C7L4cVkRBQPKnYoI
	 18h1/AxXHTq1Krw0ex1p7+ME9pynixiJ7CwahK+Xr7ZuWwkmeHqy6jH0lqlIZ2e4WQdip
	 isZn6BPzq4MpgCak7MaYCBZ44i8g7IrN0Co+sY2Cc60p4MJclrvW5XrESKn23VKBl/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFiTD5KF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BB606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFiTD5KF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E351F000C1;
	Wed,  4 Nov 2026 03:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761570;
	bh=wes34L3/OFrJRuJPtHLf9/Gu+mSzfsdP0d3zOcnXJdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFiTD5KFnamUufuklfJURbP6GSm/FtIcETogUdlz+pMfOQ9pyzMNLARVg1vK80cbY
	 SgcfXF2HGqxE5mY+tQNhTUJnLdu/bSdff+u1TPtteePaRt+E92XpahchYMFzU1mTAZ
	 lR6vLQ2sCQjG8hJpG1VYpUfPsMbr8ll/itchJhKtz1WMM7ME2AYt3VllOx9CbeIJ+9
	 Cshj1351aPzLOCDcH09LacO2aFC1Dir75KK2uKhGl8f1obSRKoaBj3zIhcMlpa7EPC
	 bRL1lz9cHBKp4AWx4dR7tKgVdB9wRkHbGKqiZARFFGS1thAYzBr/amxYu95aUf7GaG
	 gGs+02W8u337g==
Message-ID: <sashiko-outbox-196581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/25] dmaengine: sdxi: Prepare function and sanitize
 MMIO state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:06:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Recover an inherited function state using bounded native stop/reset
> transitions and a PCI function reset that saves and restores PCI
> configuration. Use the locked reset API because probe and removal hold
> the device lock. If reset fails, disable bus mastering and wait
> for pending transactions as a best-effort fallback.
>=20
> Disable inherited error logging before stop commands can provoke errors.
> After stopping, sanitize writable configuration in Chapter 9 order:
> preserve the function group ID, clear PASID and interrupt enables,
> restore CTL2 reset limits with operation groups disabled, discard stale
> context and supported RKey tables, and clear error-log state. Disable
> mailbox interrupts only on functions with SR-IOV mailbox support.
>=20
> Keep mailbox commands and peer-owned payloads untouched. Status cleanup
> uses the specified write-one-to-clear semantics. Invoke preparation
> before feature configuration or publishing new DMA control structures.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D4

