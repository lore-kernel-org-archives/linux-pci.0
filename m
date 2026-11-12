Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453821;
	b=lVCI9xmZUDiCJOjNBLYWSYxS2ggNNzrIMh8jIJeOH24+cQOVyBFM4Uqp7iqrnE1mCag1
	 uq6hHH1sSkYQQUzf7zmsKTwrHcp2pzZMSVaLlKi6rjEcR3bkiXpScKRgr4omkR6v3h8IT
	 ivloQG+cXoNKW9sd7NmeFV+jVxxoFVX1UAFS79rivZGo86mMUzvQyO3Z308qtvLhRofHN
	 i2JWPAe28O2J0BcSK8VZjNgWiJI7+zOPBZt2p1OeNA0POSZwxMFCkStQJ+yXJXTKZyo6L
	 6vvLxN0QgCziSJiGU7zaK4rzzh+JFkbHCo/xrFQ/YW8PGp6zJZ0YJVcCqLVhGMkip6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453821;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t0gEVkJKvgwS09FwmWOtPlKUg1VPVvbrgPzuWRKhz+s=;
	b=KHrulnPlfSrzHUwJYVXgVGUyfkPbZsSneNh9J5vS4UW/7lOX8XSwctmOgKmQg2ARW8mr
	 04lLQE6JzC7MVQYjmwUYgDf2KE3A9mI8/QcqjSmVq2U9jKWI8ZaiDs+msboBaVPuSIQEL
	 k/JbE3pT9X0Lfsb+WOFjPEgPz99TFTww0atCzF4mP9/H6SqbM11PO4dDLSmysQh/cAg0t
	 hTsOsjAjRcAYN2TqeAtLu9inTGa/eOKbBnDx0WlBaPMA58+0dwn15JC8Zad2ktYphWhGx
	 5OCN7MDB+O89sIkWB0nTfDL7CKMI55lYdp2xKSIb0p4af25lT1Z0opxQbqWE9Y0Or5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYckdRAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10750606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYckdRAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0E1F00A05;
	Thu, 12 Nov 2026 03:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453820;
	bh=t0gEVkJKvgwS09FwmWOtPlKUg1VPVvbrgPzuWRKhz+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYckdRAbmQ5gMIw2CsO65pt3LM4RDIoLfyoiTBQa61P24ejEWzcfP7mAYaEk2x5yw
	 BoJI+ljgT8LJQHlfS0lWCy3xRITlF9s5ArnotOg0x7fQLL804blJ6VaUhX2A6PUDzQ
	 SiF06APgiVMiIyKgU2/RUpFvRQgoTqS4e+F13S6C39tfcJTyJPMxqmW7rw4VKyrZ8H
	 wsm/abz1U0XZYFoyFfMkNStg3sQnthx8+UvdggdZW+eLbmFj4+6ERrHUW+zh0AcLq7
	 6YL5BTGzBcNh4l2Dhgdt1ORz62Xh2bsdIKWIGIhp9LWJXJCs2LnKN5o17iuBgGRyYw
	 IeCmdv+WvYGjg==
Message-ID: <sashiko-outbox-210261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI/AER: Use pci_clear/set_config_dword to
 simplify code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112031921.1255661-3-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
 <20261112031921.1255661-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:23:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace manual read-modify-write sequences in multiple functions with
> pci_clear/set_config_dword helper to reduce code duplication.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112031921.1255=
661-1-18255117159@163.com?part=3D2

