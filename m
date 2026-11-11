Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441273;
	b=0SRRdDSQ3wwVlj5hn9Msi40JwQ6dXw/ZMekbAns77ZuvVu5VVDFyyhIFBpR1tZtOSqhp
	 J69j7TM2jiVH9iaIpEGoRIzjKAGwuKM7ZFlrM2z6TRYNbENY0k57WwGrsHNyVGnlC0HcE
	 MWrxXjukaqHtoiUbAXlD855napsG2nW2jQmpCaIUXNU5AgIZZVEyHl6cTh58P3XCuqaIo
	 HcACWXzF0fHzLASSAXeHd8azexfDwr18k8q2L2cPE86tusIzBmIfLTjp97CGYHJ6QJbzR
	 F7daL9vzE/3z71SueGYMzbviA2fop7QQt3YcSlkD3wJIR1OOHPcLIkbK+haE3VNdzEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Eb1IC4RgbHh+YAMkmIh1GPMqIGIlZ86T7mufaBLgmQA=;
	b=uNniyyWjQcysIWbCdQ5YycQ+r387KqbWj13cppkHTNWnyYCSoFNSrssuP+J1zBTRxZZB
	 rS6o08DPhziQLgeIkIbo5lGaMq7m8Oc2Y+l4ZKMoYs4I7HfoAUmbzjiScMyedBAUAQsRW
	 cri7XKp0Dm7zkf3IvjKVI0Rqhwz02adeacDaNxM8yru3KZuN8OqzkufC24CqnlgNEAKMf
	 euHV3lLUiv2O0TOC6V+7fXK4n/o6fhfCPGJk6qp/5Buu40CB3dsINq1Vhyy2UyDG3rBQV
	 AySdLd4xjC+L4i/7yHmJ64SrujNlCqosDe6UQRxduCoaiugJQ3myZbJOIRPLWdV+xjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUkEEPYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B464606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUkEEPYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35031F00A0A;
	Wed, 11 Nov 2026 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441273;
	bh=Eb1IC4RgbHh+YAMkmIh1GPMqIGIlZ86T7mufaBLgmQA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iUkEEPYBByJ4Q4fFCcmRtt5H4Z8UVBH0UdJzTm5lLH3p/kcqb80JEN4+sqvFT24n/
	 cb9On7kVHpieChvCl/wDmTwrwVlSldENk7zTPOdw7OFfHlhb00dZIsXsaKOmnC7G53
	 zxPfOggv9ElrePm1zOIkQr/gBrlEWhpThHPaFwhtHTlhPwntL26SuYRZ26gLgVNNLs
	 rG7ykimtah+qCPe5s0sBwNkmQiPd6zFgRYdINd0JiPvGMJxPcKWLkaookju+EPj8G2
	 UestTrofmRvS+pp/o+sxeH9Eqb+HJ0ujjkKEjyZLM6g7pej3h/D5XQ6Y1k9wh7XBZk
	 IjjU94E7saNwQ==
Message-ID: <sashiko-outbox-209867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] rust: device: clarify the drvdata_borrow()
 safety requirement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-6-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-6-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:54:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> The safety requirement of drvdata_borrow() says it must only be called
> after Device::set_drvdata() and before the device is fully unbound.
> This describes when the stored data is expected to be present, rather
> than the requirement itself.
>=20
> State the requirement directly: the data stored by
> Device::set_drvdata() must still be installed and remain valid for the
> returned borrow.
>=20
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D5

