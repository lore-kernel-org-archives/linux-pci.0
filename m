Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026270;
	b=w64uxnDZt5uQ9gjF1EdpygOd0Tvb9BSze7hVeRsKcZTaOjGMeYNo8Zx18lo7Dne/FekD
	 +alVvKzDOpY85aOwWKX3xRYmKSmwQum2yxFnKh9v/1UVIqXhq8otMpUnTdeMQvx/iyvzr
	 eLU7yceQcVGca4O79yrxjl9GbryG6qTZUyB9HU3emcy+zhURfEMUaXwtvAWnsSrYprkKX
	 rQxrgf5OmdCnSiw+01vl15pW1fLHrIAIhaWUw3SjKE03BWj9GD2qkI2R9e8btO38kUVnj
	 GFzOj1cSPfFweUlqbgdlyqHrG6PzLjYbo4qv2XSMMTETbaX9nu+5xeoeG6Wilf5veRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M3xrdA184Dn/wcUbLnH29k8Y947twxrOS792GFyFNzY=;
	b=JatcndXfLRretPiwocghSXvey5OMXpyS1ZnAqllq6CbPWmfC+bK+0s4zRwDZhdY4D6Qf
	 VFI9jnDZ/XzP7U5nDbaLdTNc8cfmDJfoQw9iH+ESxZ7ba62ogSFdW6COpNMw3bjMM8kh+
	 vgGU61ztevPlgwLaFCRrvEsDjvW9ZJQN/4oUE8a0ymKUiUwZpaWTx9U/h8LDqpIYiwkNC
	 cQNq7MapA3qFofl/oC+FYrM5oKrUc275gy7q0hu9NceCVxfiIo6sVnam6s3qee6W9WRux
	 XdAhOAr+rkmMZzUp3jD3wY+adUo72tmzkBtqBEzIoumQ7T3JAlGqpXAP33qavM/50BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4db8ZlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A4606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4db8ZlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E11F000C6;
	Wed, 18 Nov 2026 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026269;
	bh=M3xrdA184Dn/wcUbLnH29k8Y947twxrOS792GFyFNzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4db8ZlFeOInKgVz+PYmV/HQcmJnmQsi3hhRtJrFIjoQoSzpOePjO7q7mqkejo1nn
	 SM5jtMho4l2onZdJ9z/cBqzKhSPKspndOeNX6RRoT97hw2ZuL+uJBaePyFiMkExskW
	 uYfPcPGtsi2buaPOdu6G+3tPwt9QK9PYEWBKKBCgpFPxn/bH7CipBXDd7QSYrluPbs
	 wBZp8ZB8xN6gJPfDv/7pugD8vtLAt28tOs7UlhlQT4FvbtJHtn3HrxyqSNin0RdMUA
	 69ViVhSeOLRRtI542g5gtd9dvbqu7Bhf9Pz7Afqg8p6G57pkB426kYArd4xJqNDmgU
	 PGoJh8FN2CJdQ==
Message-ID: <sashiko-outbox-221745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] PCI/DPC: Avoid access to non-existent AER
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:24:29 +0000
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
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
>=20
> This did not cause actual problems because in March 2018, commit
> 4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
> the BIOS") had seemingly inadvertently prevented instantiation of a DPC
> port service on AER-incapable ports.
>=20
> [ ... ]
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
>=20
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=3Ddpc-native" to allow DPC=
 without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

