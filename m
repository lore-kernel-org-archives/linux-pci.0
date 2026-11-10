Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296124;
	b=aFXdLptAJsc5F6FehyCkF6u60trfVbbmLlRrv4hJ4wNWOQsBa05zdoKHvTdYRi8iaRmi
	 IsxVDA5JR1i6tTJF8s3pMhW3JFSlWqfuPsX5ZKdCpWgvDnU5dv4s0k2tQ3axw+CPoNsWj
	 avVepajWc+igcEPo4Wxgf3iW8uy1h+jlV9y57GRc3uS6b4UZWaBKW/NUXSAWFm2Ct63Py
	 hKaRW6PWm3LCQx9B5ieP4o2CJWePapXQlT7xnZAQjrKp2nmgg7OKHXIEPp6DtTj4g1IPp
	 TqiMagQWb3hRfZXDKhM7hIKGFIMl9CQkMJAxIVYmcUulEoawHCyo3VX3QWfKwf/YdsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ca1evJkjUW1sjr52HDvJkP1b1bQXj9DrSZIIJDsp810=;
	b=VWSgmXQPM94lQAVfu3abIWQNVzBJ2j/Y608CJci0TWAsoGafJ4nEXd1xTWXTM5Kryjna
	 1h8vsnJuYiXMNjCP0IFngSDN3trxVkHQJsc8LFl94OP8PAr6qAbedPaNNlZxaRdXdLFuq
	 HR0PvmaNruhSTjlflXe6KVTXV4Lj19iH9Bq9lbdGQEESgMGcwdbpE9mtFUoJF67NcU1jX
	 WzhOFhgD0N93Fwvkg9/Sk9isflEzxQhW2cLX6i9KS0D+Run0eYQ+vCqgrALEbsMe0lioa
	 +sT7cNgP9otNggaQC8IwfHyGzupdmVqTez1CHMvfzCDt5OVPilCKvtipXuqd9JkaRew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=be3c+OuE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3781E60A383B;
	Tue, 10 Nov 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=be3c+OuE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1391F00904;
	Tue, 10 Nov 2026 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296124;
	bh=ca1evJkjUW1sjr52HDvJkP1b1bQXj9DrSZIIJDsp810=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=be3c+OuEc8FX5hrm6Rae5b1Te1k0MSW/7Ko7DHxjHsA5UrIw+qCPybMkiNFE8vV3+
	 McoTBUzgSTohZGFaIQdSMJDZMoo4vey+76tGwdqHAYZHesCmN86jTLAMxngchoa3ve
	 Gfi2f7lUcSE66wT0gB8WVy1Jwi9COVH6qzCz6Y25NMGKXuvUJL/4A4itfTuiNdiql2
	 YKMac8Tr6853Y/skNt2+QrIIXMWczfOzwBvXKdU+Z/hsDF5qD7US3W8bjx8sUAmoyn
	 JKZlNVnNPFiX+LLr8EP4UP8KnPlDnym5X0ojGiT2A94wKu77PF1SEXlZQJS2MebJNI
	 tBYzsI7tibxAw==
Message-ID: <sashiko-outbox-206515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/19] driver core: Expose committed device trust
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-15-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-15-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> IOMMU state can outlive a functional driver, including after failed setup
> and unbind. The active trust level becomes disabled in those states, so
> infrastructure needs access to the retained authorization.
>=20
> Export device_get_committed_trust_level() to expose the existing lifetime
> commitment independently of the active binding.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D15

