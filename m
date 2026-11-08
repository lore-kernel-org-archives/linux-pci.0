Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131049;
	b=UaVUrOnTMlFW7uQOa9VwHrS/ZiAa7U+ZC1WAjCGhryQtOfZd/dCClkgFMVWCYvcsKhqF
	 Ca5P7ItgzQqJ6anl21mY7sTae+tXUFzQJ1TcLhlp1ME+BsFb3VeYBFp/5p1wqOYbxZKI9
	 Lk4kbByOXP0LS/bAg6171LPxMjg+jY/Husp3B9qxWLbDoJxejzyOP7QCDkr8RKIxYF7kX
	 LC33OF+uIUtzWCncF74FA8VbGjKjUVFRv9v4NKWBEipMDDOD0k/A0fyrUWYAZiIKe6Z3a
	 P0jArA3wG0lxgPp8FgZxzV/3yFrifeTBPn9Rg7Km5Ldu1oXN34IIaAuFVlK7XJWYdNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MDedARNWKwrJRFKfagfH9/AgiEaekFPtGMpkh6OHkps=;
	b=FTGHY/USFpjNQd5x7Zq0uXDkGEZjo/1VYYyXkfVqDshzQHYSa/sJF06APXMFRng/8TQN
	 zD8b+EHcR6cAmQthC6eOok0D5/n1mbGDAcAfzwGzS1u//UvRlStJ3N1qpPNfxWHA9nH7X
	 L5bLNEOEvdFc27tzewSa5mn3Rs1bKz0ZU7VpLP8o7kCPa+wZqgjgOLmzc2obD8Fzk8DVs
	 N13k+afig4Kn/VA0Rht3qRMg1XlsuP+eKaaP0qHZyL8yRp6uG5d5GuBUx667Pzzf0UtYY
	 5CJJyaWxByckF4l6oHHAQ0SWwf8KzrsiLl6iTYa7qMmTTqKDjjRPLMcezeXHYlzo/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ly6tiY2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B8606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ly6tiY2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369901F0089F;
	Sun,  8 Nov 2026 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794131048;
	bh=MDedARNWKwrJRFKfagfH9/AgiEaekFPtGMpkh6OHkps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ly6tiY2eR/+IfH8i3s3GgSVTLt1JlRI/vSV3dYY/8/T540eT7Ii7p0VVG91KBb8IJ
	 hE9XqI8RsKhJwHghANX00t0QfQc4OY8b94rpwy0SLUKiHqEAcZle6AbEXJvF3nxdVR
	 iJiEvLZVkqOBn1+yLmu2hpsbhb6V5uuseM7sjs3xr8EyFWyDQwACfNkkM5KN1AewRp
	 K4R1i842H5E1nkEb2OFlRssZL9ncMZgFjZkUtf184WgEnrXb0hTQPVDUEKYyurVjwO
	 WLkBFhHEvVoo/zFsMS3CbpGwKs3J+jZ5rI95gwhfEnoij6N4sJ172EpY2jJiGe+gdk
	 V8UL55ROvIijA==
Message-ID: <sashiko-outbox-203665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI: Make pcie_link_speed[] private to probe.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108094034.679945-6-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 09:44:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pcie_get_link_speed() is now the only accessor for pcie_link_speed[].
> Make the array static and remove its extern declaration and export so no
> other code can index it directly.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108094034.6799=
45-1-18255117159@163.com?part=3D5

