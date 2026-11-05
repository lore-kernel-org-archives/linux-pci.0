Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906847;
	b=XeshgBxkaCT94nJdadNuP7zr/KLQhY/0CL2ZpQE7mINF3y98+9YwLByv3IBx+5AiakvK
	 gmFLy2MKvWMD6pwAPBWBhI2lDoSf4shSVMuEiDmObGKocqnoPJh6qcqFvJmFq6uDZqc7T
	 l/p+cE19Evp6vgPwMGoqRgh3Yg5bp8XGeU62U5ISzCE9UYrIXQWNC+AlAbUrvKEmPdKKa
	 HubObY2j5Wdt8azMswlgWowrgUiKBIwq9/m3U+TU8hcL+EQscOJvMDVYforsFi15LJAsZ
	 vhZJYaOqZKmYz+NgKA7wztfJHV5EBxUNGd5piyzALa7xKydSqExQNVfqeo52VF4/31g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xXwJGWxu0U9aDPCfaMBLKIR/yzoiuy0V0eyfGLKcZRY=;
	b=i4U5xuPUvmHRFUgbJ768tWu5uUW97h0XhOcyj32d5PBIYbsUDiuT+XumfCdIe6Bo9nqs
	 Z/lj9iKm/W4hrzdGz3Mgs5+luEgBUoxSdwhLkp6OGPZCo7BQJJ+Zy/khdiFDv8F9TBb+5
	 tT6NbBgrzMyHjuYsPmwgB9A98L1E+NcdW40FjvvfLEaCrmdrfX/E6ebji9PXrGyrp1wCI
	 f/Dm+BzsEV1PyjA89utZWNJk7R8Qqo7n0PLAvOc7MEEE41VQzMQ3tEFYZNWgFNFfUhQyO
	 fypxcBAgXx+cmq9Ko4wofmgj7mZDGrxHSib7xODLfOo8zL2pJ7mwH887ZwlHnagRCzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kN/Ci+PK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F7606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kN/Ci+PK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D51F000C1;
	Thu,  5 Nov 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906847;
	bh=xXwJGWxu0U9aDPCfaMBLKIR/yzoiuy0V0eyfGLKcZRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kN/Ci+PKfQrtY9eMXo/A8TG4X57Wn9cHHDeFsYtFX/XPyHixvWJfEYgtnZQ31g+Om
	 PIlINyPu+LY2x6BY9G1HhN5paD0wFmdrIjTKFz09PT+foZpfSm9wnXJQL1lBsx8zen
	 +EWkcocYshsRJOGCj/t3NsT9gp5FKDp6BvqyiCmu51bwJ4DEGzr546hQEC26BT3d/k
	 ze+XBzIGL58qw2QikrqLoGltugVTwxFHBOoHPF9DCgK4Csh13uMkWsSQFp4eJnSEVx
	 KxOh6cTpduo7/cf60BDFL5t9PCvQT7U7lK2+rbTz10wTQUiPq3oYkvoBvEho2fpDQX
	 b7OJVcc5Eizcg==
Message-ID: <sashiko-outbox-199857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105191556.4042191-3-kbusch@meta.com>
References: <20261105191556.4042191-1-kbusch@meta.com>
 <20261105191556.4042191-3-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:27:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Keith Busch <kbusch@kernel.org>
>=20
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI keep using their own irq_mask().
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105191556.4042=
191-1-kbusch@meta.com?part=3D2

