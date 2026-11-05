Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893458;
	b=YMC3efw25Kc1Qj5vRJfhZ/WLF4ZLmIf34oDsumxg10UKoiTmhIP/d5s1n5py8QCkWWRv
	 xQTkfdH+AcPZk7gdp0F4HK5HMkcU2Dt40GcRb61YPxz/QlZ+/M4X8CsLnwXxwj5q0GGq+
	 /sujefXOxcZs7Isa4EVfrohSznbG6wfURrxEjG1jSk3G9TSgdDSUhpyyqtE/a2xzIzysr
	 0oSQNHy9Z5R6NH25yMcwZbS7pDiAjDya4jZzStw6KOfTK4Gs9yZSGDx/npW+3tB8GYbYd
	 HW7iOFbKL9+R2tqv8sTzg3UthVQUV7WrBz9IYqQoNMVWaMyDJa3zQ9jlfhOVoZyUbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893458;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u7RkuIenLeBu/MIv7dc6avr9u6u5TelKDALiV5IzIhQ=;
	b=lI3hbHwZErWYch34n4l1uidGaxBBOmN+BJWpqd7Ysok5SKzQpiDk+B0gpaEHEW6O2Z0I
	 3CHp9nuu70DwHpTzjn6AquXcXAAyWlPiyEGN866veAHQOIdmZIr4Jc8/nnNuhOjzvRSWn
	 gJBncPFQdZVN6U1KLJccbPy6A6erYeteQSw2uS662I8KiNHrWRIUhATgLtps6/iBZdgmf
	 H7KHifUQvEP79lf1CWNNVh2WotsiwwofuhJsJ55lI2Jsx90Bo/9QkwtbJb5OgMlNWwckg
	 ahzB60RNRMoqSEdP8RMiOKb0PqSIfVihsHX4+Sjg9rTSoVBoNsAUedQPYCfa3XhcwjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlYVi3ar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9049606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlYVi3ar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621B61F000C1;
	Thu,  5 Nov 2026 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893457;
	bh=u7RkuIenLeBu/MIv7dc6avr9u6u5TelKDALiV5IzIhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlYVi3arJStYLd+r+xA/VFrWqYrYoY5rzJNZF1Z/dimguXw9PF0t/t665tqsIy/Me
	 MzbHSTSjYOqDe4Ba1B9/4mwuhVuNzHTtFow5ZUCWnciulgdCwNvUpdx0mYGcQqX7Cj
	 IEof6yiQ8Wt6Gr6GR6gzBf80YjjC88aVNrTpSa2n2xYPr3NDL69fbsuYXS4+0E4q01
	 CJlvRMyuoRpe8T0qeX/4mxMdp6rktNFdBW+rjPoLTZIfHhay2dzv7Apjp+Hr332neR
	 cUloA4ah84i8roBs1pp+qEqxtdGk6VfpSCTs6RS2VM6aH4Ge4MIUQdF+GGf1kQlr/I
	 Gp/4Z4WEYzCzQ==
Message-ID: <sashiko-outbox-199333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/10] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-2-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:44:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D1

