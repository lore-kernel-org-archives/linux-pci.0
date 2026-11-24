Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510486;
	b=H1VzGJmaYUHmt6xVyBx0zHZ8XCM/3Zxd3PDFr+MuEQS9vonCQY29OzUqluET4FhX757c
	 vp0Tut/eE6hCZYgbmV9slHTvbdM6SrNNIq5rGIfo7LvNumIoEbjLmzYBP+Ne1utVvaolW
	 qUKrNR6RMyn/sLYGnfJe1ASffm+ICjmyruhaFbyxroNcf07T6ZQ1/eI0Qy3hqg/DzSMhz
	 eLMrnVi79W3vxScUhNhdit/k6XPumttVpx9Zsi6zn/UZrIYhjW43iHr2W9A/aiP5ggm29
	 FNfkRi8S2gca1Zxq6ZZ5oBglacgUy+RHOsdY7T4uhmi4eQdXyVdW5kn2IctlDvJzAxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510486;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LeN13AY7OaT5SaP8gn1Mj3iPqbEob2yLbodtmi6k6mo=;
	b=feWNrFXn8/SJN+S+bBRqmOHapN6v3AsFgxUedXTuB1EqtfxrW5HK+NCXHamqgQS6Q7Sw
	 zv4KvTcbK3Oc7lWX4VCj9wLf34W5dD6yoG2ms3FbcxF/s7rcSYXwAg6WvJzJPBxB8+q2A
	 lP2wUHCxdRDj3KCL1RoXJIo11oqrfcnble7s91J+ya/eJCQTDIOOjiwnMGAR+fiyBDYEo
	 sdR2n1jUgULGnjTOF6tUKqkpbWj8+uuVJT9WezNtCcsnrlotq4ERk90JHA+tXtFXqhTOf
	 NfmbQqBa/+U8MG/dzfdnfXsTJJviyphtzRWSw50XY7osr5OvjlV9PlE1bXaI9UQxu4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwCqZ5F9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658F606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwCqZ5F9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1531F000C0;
	Tue, 24 Nov 2026 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795510485;
	bh=LeN13AY7OaT5SaP8gn1Mj3iPqbEob2yLbodtmi6k6mo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jwCqZ5F9OyU/rat+QJ3lP1f3h8Se3LbQp5j5G/gFhWG2/GBIJX01B13/WBEIha9WM
	 XI37Fc1H41zMZm5ukkwBUlJAeo4dB+mQWK4H52y7+ygY7RHy1MURKpx7vSh+SAPCvK
	 74V0ncj+WuOgJ0hvAWmuayF8Ns282Fp3hUBSbW+V+9JYT2BjMW0fZlvHqp7MlcFw8b
	 7ELcUleEtGHlRF5KWg1SwGzu+lsRgKL2WcE6UhN4mazGqCuuKFUeNUh2HkJuNf3GqO
	 USCBjUMYZjLKKOC2PmoBwrmUaKHGu/0Jag64C2LsZXbYuCG9OUTitTjX0ZMNlvdY6x
	 sObOZm21cpTvw==
Message-ID: <sashiko-outbox-230751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Correct PCIe port type field encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gokulkrishna Sekar" <gokulkrishnasr@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>
References: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:54:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
>=20
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
>=20
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
>=20
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
>=20
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@m=
arvell.com/
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124085038.1729=
9-1-Gokulkrishna.Sekar@harman.com?part=3D1
