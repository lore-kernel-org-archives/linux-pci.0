Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761014;
	b=brjKSVDozIawhcqeXbwKbwiGja60iy7BE1MQ3hztlBQf/N8+gZ39ZuOD1PMpUVu3veZ0
	 aHwidd2mfnRrHIpV4zZ0/sjt0jLZcHvo0eVcizFRjTlYpgSm8GE5fXd1+xu3rGCxC2NpJ
	 GS26OyrQgiGncVWDJ83qSJaaKzLx9nigAausG9qK3DlpuoA6IPFQnloG5LPGlJIGYczpc
	 sCPl0A5xWFhZN53ioioKYqh3XtLnm7BipExAgysa4n/5XSP8MjasGXFQbcOLDugc2QnBo
	 A87NVPnJJJ9lfn7kknJBQDeM3YVBqYmovJ9w4w/5F916614wqd7QRi+NVl/4/O8ebXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s1iIK13J2GVauJu7+PIF2dqCzIIPiJyRIzTZT3sMI7U=;
	b=zGRnfhBHzo236+m8lWsHzGxk+PlwtGCxQ8ZiFWTZhLNbPM7UlZazWyB2mkeLD0fr7pLy
	 ukju6eKaCFLEbc2Jfw4tLiqkTCccXCA/xCS4PUK7lqdHOeL1086w0qW0AYuel00+3fGNU
	 w0wtR4zuJQFBBRGXChb9yRrMbLKuU2sexgfLun+DBhBepQbsjr51wdksQcVJ3rsRrOKVr
	 2QqP53iqGmEbMG+gsOZn99Hgk+5ARLT4sKKa7LGW+b+6xXlgO5bLZ9jP8mOpib8+lJTI3
	 Tp/s8GqtO7jtIDind94MwjFo9bDfQSabzcpNRK5JJNnNiKmNeAiheIkayx6CfPC89fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0LH9iZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8280606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0LH9iZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262761F000C1;
	Wed,  4 Nov 2026 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761013;
	bh=s1iIK13J2GVauJu7+PIF2dqCzIIPiJyRIzTZT3sMI7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0LH9iZfh9DWOHg617lWNetl867zfpKAeyJyettjbsuwrfMSZEOyf2/0xFWHj9TU6
	 +aRQjkwyzer7Rd9vd6aS3eAG0goLKVPDnBOkF+8keEYCGkYLOXrHmeskqJgtx51k8h
	 /7FwoNdLtX7zNYAUgdG/2XtGLAm42p7GnS2j479pDWCATMouMiDRxKWHzrxGv57Z7+
	 ZLStQslUN+1LxyEaJjnFSGWq8thlfTYuLL+a4XWpKDuZFXX/WSeYLzaYrOyN56F3uy
	 Fg9IQ10an4B39qqh4F5ajG6fRmctxK+SApLiVkqUKBIgcVdLGmRUF+jStoRENVHd63
	 bOD13EvJcO0IA==
Message-ID: <sashiko-outbox-196551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/25] dmaengine: sdxi: Add PCI initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:56:52 +0000
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
> Add enough code to bind a SDXI device via the class code and map its
> control registers and doorbell region.
>=20
> Keep PCI resource setup in pci.c and register devices with the SDXI core
> through bus operations.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D3

