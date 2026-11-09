Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254023;
	b=BazkWjxN10K8JybOUXGH/ELl5HhG8Kqtev8bRpVxDQIisTadm70cjT8tSKEBeTI4NCDb
	 ZMnhk/7kq6kBezBW7IgfaKzH4vzxzFu9w9ORBQfSF8+X9reid9LhJrd+bdOt5aycDZPQB
	 oQzlttNgj7bvG3juCocpA49YWL1hD+5KglbVvdGE9NIw4lAW/H9Yz39UXyv5pNjHI+8ud
	 n3GedEOTw5FeHS9asPjRD6wxxsR4Aq5I9QxyUOasHwUoZw24Q9m54QXA1kJ1FfXkvnZ5z
	 XB//UwkWb9r0eIApJ1cOk/RV+IfvwiHzKkI7Rt0S55/oRJwhGelnnzxhXs20SHvntpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3NFD6tYHPzR69iTO1UnLfRlml1nlSS8MlXOTeFT9o9M=;
	b=Dtvlc397dkHBUwISRfbveqTVMHuhqkPRmLC07/5z7BMMTOW6Ud0QfnNNY7XuQTn+CRW0
	 pUW8YCyEDRpPaW5mB/XThxvXfn6VWPllOl/xMtYPxPYrK02b+g/L+mha4S46VZY8hQHxG
	 RThjmtSZa10RF/t5kHlpLCjE/chGz7DmpPkhAuVpygE4f9ss5zia7ukzMg/ColWfQo9qF
	 kX0gfJl35OHbJ2HXaTiS2ow3ia1CHrkSs9/1l/uRDz31Vt3WAJuqIkhBX1g8DJQPgXKpw
	 i2t1F1RkI0UuuLzEykabkAu4eCdpYlCeB89XqI6swnUCRpg4TQMUCNatIU/YcyGvp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJBKzHe1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5E60A260C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJBKzHe1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B23A1F01558;
	Mon,  9 Nov 2026 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254022;
	bh=3NFD6tYHPzR69iTO1UnLfRlml1nlSS8MlXOTeFT9o9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJBKzHe1A+qRe1EfjUrrGOHRX6vHsE6LXyTWYEUokJuMXQrFgTYYAHwPPX4KPw3+p
	 fMo+IewqsQR8q17EmbTyYsZLgbZyTa2WhBRuOSMMB41ZC2G4vVwT3RovkAN/t3SXk6
	 BWbdsD9r4jz0l35k9BlujnB/mp6Xh2ffajcBlS0AbuEpGUQZnrPEHo2YScOKgz4k+p
	 I3ZSEO5BJ/bFBhhkMkVL8OvSarVRcfClPsKDiacUSUwegIThFPym94EZShkyltZCSI
	 x7VgPkb+ebpOdPgd4gQ8MLBVPTno1yGef7fhn/TW+eetqHr+QPA2Xg0p6aO7BJmOTo
	 fQC/i+dEF5RQg==
Message-ID: <sashiko-outbox-205502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Constify struct configfs_attribute pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-configfs-const-pci-v1-1-8545f5886a01@weissschuh.net>
References: <20261107-configfs-const-pci-v1-1-8545f5886a01@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 19:53:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In preparation for the constification of configfs attributes, make the
> pointers to struct configfs_attribute in drivers/pci/ const
> and use the new ct_attrs_const field of struct config_item_type.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-configfs-c=
onst-pci-v1-1-8545f5886a01@weissschuh.net?part=3D1

