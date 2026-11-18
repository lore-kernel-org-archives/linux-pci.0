Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026263;
	b=kQfUFQYhpBcCIDMHpyObq+4B3gPOf/r25YPTrsvYd2f1U7PHM8piOMeohMHVBEg3/SPh
	 QvL0a7CrjOkjpRiiI4CAmroV91VCBF65Y4R6zAOzIzyEhX+Fnk9yG2Cdj/pFE0YiF9m2U
	 uoSIXLrwB0Qa4w4uogCahErMNqDyh3LD6h6uIUJ1NoMaCS6tXX5TiMif9oV85rq8bZGVU
	 1M6Kuhz1fH+Utf+2fKgwSLQ006Kyrp7kw3Z9vlGfpbmBGhd/U7y8srfxJRGq9XVQa1gGC
	 CCFlXoxU94G0bslZjyhTlFZjUAdiqxaKX+aBUnpDCEKb2WHLuj2M0a5GBuyPHBj0WbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TI/qWsyM1tAa9jhgSjSzsHqUJ9QLuvccIO/+z45ixSw=;
	b=C5sjU6l9DusBOwtzNp2caL7WMKqHMfzDAEP1vQf8j2oAkJWTR5KAdb10U9OSFARbnxym
	 +rBIt7LZu3N+rDRsVH1S9f2fD1uj8zqoOn79jxeHAzvqY8G33K5sSDERyLC3cTb2jM8cs
	 n7rUN2auEtOrMpfgq6zep83+6A9CdHPs1B5wbSTVaFJSCk/+FK79O8d7oIB40DQC/+/Nu
	 Ul4Pl4wQVlAORnK7N8zdSPCAJ7GyKFVN2jE9Ka1peqeeneSxu7PGUAv1zS9czysXwlaCy
	 5gmCQzZ0f1xAQDtet/pPGu0EE7puuEqor9LvKW+bJWXhh51FlBOEMZEK/L2CSWjeIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kDik/2ux";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203860A2603
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDik/2ux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FB01F000C5;
	Wed, 18 Nov 2026 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026263;
	bh=TI/qWsyM1tAa9jhgSjSzsHqUJ9QLuvccIO/+z45ixSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDik/2ux2OyKewxWVmpH9GZBLUOTfXAoIrEqT6FT6Oh+1CSMNnM+x2ftCpA7m6izI
	 In6DMPgP3rE3+CScJI1Fdel95g7j7IK7a41+SIBks+ZCqYXW30FEJhC0VcZHbXt6+w
	 H7NCcI/6DJbO6dqV+OoMbN4jvCauvrMUbF90chLKAQ0adKU51SXOPVvSx6tUG4L/Mw
	 BqsCtmTKdFqT5oSjNS6n5kNacN1AEdeho2npXTucWFcPXCaSdCSVUtPU+r+onEhhqI
	 c4sonRk/pLbHIt6I45e4AJrTmtmWFUzKE+6OvBEvmZ0SgOhTPswXEJsDy4q0j+5XIN
	 i32VgNMdED/qQ==
Message-ID: <sashiko-outbox-221743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] PCI/DPC: Reinstate support for AER-incapable
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:24:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
>=20
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
>=20
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
>=20
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER=
 ownership")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D2

