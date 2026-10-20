Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521274;
	b=PC9TALlZjlE11QWqu14ZP9A2GraItgoxs0wfuGQhsYR8xWjFgpiOd3eYb6yum1dc5/P2
	 ZARDc8dmfny2FpVYcRwMWgYWBdK6BOzzxrzPyt/bnZeSrhZbQYfOv2A+Oxxy4kgxMDOU0
	 GKiZw+C9ZRi71IGkJOS38w39vXM9CwpF/ROpdYqjibaosczVRTcAGFyK/53Xoyg2rOo3W
	 SB80alVn8eIlKZ2XXUfHxdJZo2kW15EZ1LjWV4KLvbq1gWmsPa+cykXERqyg/YCR91gem
	 XZyQioLrhwyQs9angsDh++/+HOZbc2i9rqG4S8iG/Llim+CTwSvwJFqmzDSnu7nD3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q4PPzC7LuJC8fYlwcd1Bz7B+A4v8JWv2k3gPDkGUNEs=;
	b=hiPf3XnBs+NfCarjZLg3dcpcREqPbj4rhwTYAtiNSdQPwSsAO1uOG8Y0zA8bbD3mfCHe
	 r551jcdvAjBuJU3j1O7RVONoP28JBSzMR6+oYnBm/G9DKt3Rw0iwYrAmL76OtSQfzIvma
	 hX2acau8pwANb1w8/sXE8lp62wiaQLiFDgYGvuYuZb5aVAcA3qA+Opwc+qTN/grXEqcLE
	 5ERxKzSy01u3DsLvm0IRdGqc0QU69xIiKdAHIRj+8XryZOqxZ2YQ9l1muXhSAm0IqV8bq
	 0Nvry6aS8iGsRn1r2XDmCcNfCE762NliMMBgrkfyinWZl1j4KhTjkmEUHVrSWEoMwPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1xCOd2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AA606A31E
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1xCOd2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0164D1F000C9;
	Tue, 20 Oct 2026 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521274;
	bh=q4PPzC7LuJC8fYlwcd1Bz7B+A4v8JWv2k3gPDkGUNEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1xCOd2BwMMlcaWktxFjgiG7HRJzK76ct1hLHxwX3Blxe7Y5EyXonzdKj4Rc82Q+y
	 4yQRgiEW3eNSORtC6TCZcZUI8EaEVFygzv9QlcvJur1hSIN+hJ1zRnUBEpYv4aMZuY
	 6gl4lPezB2x5eTWQ/g5ZpmblNCyCO8SotV7SmMI266Ddx2ECFcJ5h0pjynUKrrd5jV
	 u5lnXsNtKWuG7mCCk39YaHsB9Dyn0xPO3V6PLFfH710EP2qNE3YOqZdahhp7aavVFb
	 TAoWBm1cjwp55NSEHWT/tjCW6IhJluH1BXAYyVdtc8z2Prvb+Knvp4x/ZlakZVP38a
	 i7m6HvuPcvtSA==
Message-ID: <sashiko-outbox-179482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] PCI/portdrv: Don't require AER to bind DPC
 service
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:34:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> get_port_device_capability() binds the DPC service only if
> pci_aer_available() is true.  pci_aer_available() is false with
> "pci=3Dnoaer" or when MSI is disabled.
>=20
> The DPC driver does not need either of these.  pci_aer_available()
> depends on MSI only because the AER driver does not work with INTx
> (commit 3e77a3f7895e ("PCI: Disable AER with pci=3Dnomsi")).  The DPC
> driver does not depend on MSI or on the AER driver, and it works on
> ports without an AER capability.
>=20
> PCIe r7.0 sec 6.2.11 recommends that the OS link control of DPC to
> control of AER.  PCI Firmware r3.3, sec 4.5.2.4, requires the same for
> _OSC.  Both are about ownership, not about using the AER driver.
> host->native_aer and the _OSC negotiation already cover ownership.
>=20
> [ ... ]
>     uncorrectable error that used to be ignored with "pci=3Dnoaer" now
>     triggers DPC, which takes the link down and resets the devices below
>     the port.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D4

