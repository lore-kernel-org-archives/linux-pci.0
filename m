Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017209;
	b=WvukKgbkZK0JItQkHqOYRPw3XADACqgGN40yVlwlHpTcMdhzFWeocGX1iCAL88kTO9Ha
	 zZ7R5kdZUM6yEVVCCl7zt++VLL1Hjn/OfIcs4Mzx7VHyDmD/hJEy2mp6mMEsgAz4ZdSnB
	 rTE7CTxMhnboqzRUlzr7qHXYzy0n3wYvgRar2L2d83tD6lFal6MkSB0syk028V1D3jv2l
	 mqMEaxyoSOMbQuDl3wZZtV/TQsQoSxDVLeREHj7DKBQp16m1UxcMqITZdOzCxKArXN/A2
	 hI2bRDQ/aNshrw3GLbV8F22hmwTIKIc2KOh+NkIpAyeUDtTstz39HHH2fb5dP2KwFbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4KBVfu5KZHfJINTZ1b4wtYkDXMOlB308wKRhLuWnt3I=;
	b=pGVDbsJ4G4Z/qg7BoDExlC1Dm7emyxoxpsHe8dyGbdxSfkN/dSus/YX62rS+c5ufsORw
	 TeZa04t1DYx1+Tu1vc1wJWDDm3tkSW51WFOiAd13uwsEN/EGM1CgGKDrdE9EymlI6oqoY
	 lB8fs8ZEkln+aDVXyuKQ3P6g64rCyk/upRiCCrY+QeNIo7tk563jv4YVnGGIrfdBx8J+g
	 qZ9xQp+Vck6Py6VqSXf4FooVH2Ih5HSf9CBxJ8g5raG/QWR5Ba+Hg53xZnbkGfK/x0DuL
	 ROwhA77IylsK9xxHhV7tj4G1e1aCXcH6ZqF3fE0fnN/1HxHd/Lfa2sdKqDJeBBfzh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag6kWeow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6792606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ag6kWeow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B1D1F008A1;
	Sat,  7 Nov 2026 02:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794017209;
	bh=4KBVfu5KZHfJINTZ1b4wtYkDXMOlB308wKRhLuWnt3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ag6kWeow5BOaXLv9XEnuDhWunvOxBtSODfzKZ2thKFnmgIn5qvczjMtkpxMUizRUc
	 iY38DSurGhZtMqPRye5uF9UD5P3lh22vbjoxnpFZw0/9oxGmejwgOYF86rNX3JnZMl
	 dzLGQBSRuRXHcw/UaY8UXJb82dk/+V+aVttbcdhHbs7Vf0WK83trmbOjJlcJH+I6Jq
	 cICVeBbG/bwrwCu6vVtXSJBcqn+WY8l3qABGQ+rh7+fxYLfXFVyBfwW39hOhyrLK3Z
	 xia9VARjcu9c3erGHDriOK49Dw+HfFTL0TZjKA/9G75btsUpDW3klRyW0eQ3XsQVNe
	 KyokoioYc07Rg==
Message-ID: <sashiko-outbox-202478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] PCI: qcom: Implement shutdown() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-4-bf607c6429b0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:06:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Manivannan Sadhasivam <mani@kernel.org>
>=20
> PCIe host controllers should bring the link down cleanly before system
> shutdown/reboot proceeds to remove power/clocks from the controller.
> Without this, the link may still be up and endpoints still have
> transactions in flight when power/clocks are cut, which can trip SMMU
> translation faults or NoC protocol errors.
>=20
> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
> into L2, putting it into D3cold.
>=20
> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
> link and clocks/PHY, since a late/spurious interrupt could otherwise
> reach a handler that touches now-unclocked PARF/DBI registers. Use
> dw_pcie_mask_msi() rather than dw_pcie_free_msi() so the MSI IRQ domain
> and the MSI mappings held by downstream devices (which device_shutdown()
> does not remove) are left intact.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-shutdown-v=
8-0-bf607c6429b0@oss.qualcomm.com?part=3D4

