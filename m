Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493792;
	b=GuY7wDjCkU9efwaiuIgSovcaXq2EFfoYzYFVjZHQRFAegqBJ9hTWf7+PHil+wETy2eRh
	 8yHAd7aM606t4n14Jt937PfXf/PeYGdUrjmI6mENtDtk+26p0IyX1mTHVXZdvl2gQg1kQ
	 6EveDeJaB4P0sMKVzWnkMZfk64TPzfEpibMTiI3gG+rNegk5C3bSJP0cDRlwiv8thP1Wz
	 ugoVw5bKz5Gdci0lqqD2Sh6Ck8rkeTB8Zr0i/EWO5ooUyOvZsL5wP3pjOgsQcLfy0WS0P
	 /io1ZUxIqw7uTSeipY3fHZAXZ5hMIzxlrqScMQyJ9/H9vtWIhpCqm6OXAdHf3ziQ3JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2V2cwoAN8kfGPzqTjhl6pUC5fQ05bMqC8BBZ4ectDbs=;
	b=CUfscB38XrFfaoFBOlsL3zHIvrqz2d5WLY9NrSLKrG/SKAqtxbFY7ir0+7KqsGERR+Zt
	 15fwEYEJY2B3DwjhcGztndtjSUg+3W1Fxb2sG5DWxYLqdsSRqz6ae5pXYFpLHnlhPG7lo
	 LzZ+85Cw0faLWiiM9djvu3SeUhHjgYT73CyZ8J9CNEMeo/2fKkzZ8vn0lRLYH5ED997fh
	 WZZ+9moqzuvI/vfml2qXUT7dxk9VRtRzBr5GiS/iWP22aWrijNdyxkwoFIx6k5dIx6GC2
	 fT4OdwgBTrgdLLd3c/HyYFdZn1pksGMDFuMbPPjFj8l2Qn4iqEoLFaslepKT3r8OSIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSMOynoC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA7606A8B6
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSMOynoC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D011F00A05;
	Thu, 12 Nov 2026 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493791;
	bh=2V2cwoAN8kfGPzqTjhl6pUC5fQ05bMqC8BBZ4ectDbs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BSMOynoCxAU0AksBBLa/QVvziGs2wwjRJixycwU4WghxHhQ89PuSKg76HbQlpCzR4
	 M4rXgKu9mPG+Oh7TQKoHJBgY7OZHR6Ru7nrtsU9j4B1b7ywpVGAmfEyHn/q0rCcvIg
	 5eH6D1J/lYgNyKX6E6PQNXmntJwcZYLPty+GGNUS8FxRSDiLXd25Iw3JbQytI0kedE
	 wV3VU9JZ4VBZDm8LWStu2k6cEO2YwQXF7VcxakgdBoUlBv3xXdOo+kDVGo6Z2nKCe3
	 yw8GHJ564mzu2d+2zPoEM9DsRHs4xEcSvx0jz7WJzypZie60qKF2rc8P4Or+vWDoAV
	 C8awoIAU/45bw==
Message-ID: <sashiko-outbox-211321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 01/20] vfio/pci: Add SRCU-protected access ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-2-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:29:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Before recovering a device, VFIO needs to stop new hardware accesses and
> wait for operations already in progress to finish.
>=20
> Give each open device an SRCU instance to track hardware accesses.
> Enable SRCU access tracking only for devices with
> pci_recovery_supported set.
> Select and call the access operation within the same SRCU read-side
> section. Keep copies to and from userspace outside that section so a
> page fault cannot hold up recovery.
>=20
> Introduce live and blocked tables. Initialize the ops pointer to blocked
> when the device is created, and select live ops when open finishes.
> Close uses a blocking transition that installs blocked ops and drains
> SRCU readers before teardown. Open publishes live ops after setup.
> Serialize these transitions with access_lock. Internal setup and cleanup
> use their own helpers.
>=20
> Provide an accessor for operations that use their existing synchronization
> instead of SRCU. The accessor only returns the selected table. It does
> not acquire a lock or keep the device's per-open resources alive.
>=20
> Subsequent patches convert hardware access paths to these ops and add
> support for host PCI error recovery using the same blocked table.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D1

