Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296116;
	b=vIIZQIdSWDc2Snp5MiGV8xvR7gOQEldcsnRZnUYmpHbzE5yUdvpJp7eZln4GceZHMrYH
	 aqPXULh7Yof5Kwundwprs48CprdTDAr7Zx2QClnlPkWuZyXpZflyVXfmVoPMDVcoZICB8
	 grkqH8lwPg5ZfTK1ZBqFaccfIKOng08UeKzgcs0Mcz3K+kJ+PTHDmxXg4ToXS2fpKeb9K
	 KuAV59tPyOmIjn0ViAWbOIz0oGYOwKOEnJjydXegTzhDnJFcwsgfYDfQHxSGqNpNdacrh
	 qgNv7ny/1LZx/P9oQrQSDAFU2/1+3j87pJwK0Bxrp9dVs6c3cIlsD6JfGXKLe2hfqXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TqCAxrkAkWZ7VSQuQz+1RFID+0fmcA5gtvZ2j/M13Zs=;
	b=lTWlQyvzyPCRXlcK0yoOuK4CivZGp1O7eAz/6DsyaMq0cJioaI3MOfGBJTn5T5z1MTl+
	 81czb9q6Z0865LYCzF+ZNaegc+kQBrKkwACpXTJsU5I35gEwpNSr1GBJtWCGUkOwlRQ6C
	 vnLjaH+Tn7zKMpOmWgQihv/mKtdhcnWt2+Ni0Wk5cxB/lRT2ZtGL6aM+2iafwo3qnjg7K
	 HkO5XQA4P9+k3pguNBNBMxKEaweAdt3g05K9GNTPBdpif/vdqo94nD+DWVvqUQ4i2kzL7
	 mNAORWYwI/6zwGnSQimsYfrZVkC4R44R/UUxub3LnKusmFbjmW9hbB1wHid+Cg7f8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMLbrdbV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F927606A32A;
	Tue, 10 Nov 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMLbrdbV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0171F008A2;
	Tue, 10 Nov 2026 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296116;
	bh=TqCAxrkAkWZ7VSQuQz+1RFID+0fmcA5gtvZ2j/M13Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dMLbrdbVsnFqQjNRx0vFT+cOWRF7nHffUVF96MMASDBcFwyohrWnFkuNoeF80D7Op
	 x4ZFoAIlwyd16lUMm9CBbYt0OSSoNZzSaif2hmFuBVZ87RUyfFxjB/5AXQ6UozAERR
	 uGKznCr3KO8vF8mWtYTwGyufakvJF8oGoVPTfJEaEBI2FBXyaeiflINvXl1vVPcnyY
	 o787mAGx46w/qnji+5oGc06LNvwJcJRw9wnbEkEXaaXQxbMkLO2Q5YKXHNhN/gac6K
	 SHq4vcz+IGFXkcoVvoo+1xYLbIs5cN3PcmYN+H4wTzYeIKsIITfl7vygndJfr39OGC
	 YXI1AltPVNvVg==
Message-ID: <sashiko-outbox-206505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/19] PNP: Attach card devices through the driver
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-5-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-5-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:15 +0000
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
> Card device requests probe the selected link driver before driver core can
> perform admission and setup.
>=20
> Use device_driver_attach() for the normal binding transaction. Keep the
> card link owned by the enclosing card probe until the device is bound, so
> probe cleanup and debug removal cannot free a link still in use by that
> transaction.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D5

