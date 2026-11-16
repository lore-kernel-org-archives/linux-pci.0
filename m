Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843416;
	b=ANubHKBfofzu9OGQtHcy2ZmLmYwBMBg1SXJlXbXdkFfOzrVOb2iCyZPEkdLEEH69nfVb
	 rLxFhwrbHSEwQqq5a8QJhUeNLmrGbwmBVVRsbRiGerjIGRS1RwoFz7eeaLUNfmc09mG1x
	 VkN2sJe1etSViXb9j3Ip3zyZWa7itOzAuWJCI3SxErwzaBDnooJHXAP+Rzs6ryjAgUrca
	 7kS+2dE5C8u+ZuD1fqIs0hIxuWgUXcz9LXkBn8mi/uNSvguTmg7DeDKDNBf4j/YSDyz4f
	 KnBRh1egq8NPhcXxlKIFYpmDVRQyjlPAN/tzJB9rwjytWpIBK0dY59z61qWSJzf76Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xSTZxM0sGgFl4zPfTpKxsYn3GGUB+9ijKxVcAHK2CSE=;
	b=TpJZ1zzMkHlr+8NzTWCCFPfPCFXVp59aaRP/8IFeWtcF41OoxeYpsSv++r1nH6G+y1aL
	 zdjN5dcoCxV/8HZCN4cNMpjoV9kJPw+KZk9mSteD3lhKNRzcXfE2P8fZct5ldaBocgozN
	 yQPZnimadiltgCS2VjPbgwDg3n9l5WLx+CcXw5A/9u8RmabAsQUioXWNp2nOrxWTmbNMx
	 y3eq/zUBS1l114Wcn6Z2PLox0rovYH7M4jWOAIwycXf06eqJ/PGgOjoBBi1oVe0340dGC
	 dq98PYrve4rkp7rZCgt6YH3kwxRvN+pnrxfNgNB5x+42JUKTUI3OSL2unR2EvyQiYFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U26tifF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1C606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U26tifF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D6F1F000C5;
	Mon, 16 Nov 2026 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843415;
	bh=xSTZxM0sGgFl4zPfTpKxsYn3GGUB+9ijKxVcAHK2CSE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=U26tifF42IARet4CKwsnOZSsTYy91WYlt6NMTWueDg6YTW7D+syNwFit0UwS/SBti
	 g3cyNDpjBHIyM6w5ajB02kKG2DxZ8wvJwEb5fVzCK3vrXQf1rVqP97zHFA66JQJ4v6
	 3VNAMmXNK2QK0LqcOd1R82ZN77/5CYMNphaRaZJYjHba+xIzVbEGZlQyPhZS8EQ8Wm
	 uhgk0kAbdSHX9LqDQ5Ahc/ZOT4Sb7IqiBAZn8Eg/tyIDh2FGdcOnHibXSfAvDy54Us
	 qSJOyKaIJE7S89L/4mARA1S5GpoBWBytmlnJW4ZVdv8nU7HTYelS6f0tXUIn908iKY
	 pOKUTK3ybQ7Nw==
Message-ID: <sashiko-outbox-217306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] PCI: Remove pci_bus_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-14-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:36:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The pci_bus_assign_resources() interface is problematic because it
> makes bridge window sizing disjoint from assignment phase.
>=20
> pci_bus_assign_resources() is now unused so remove it.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D13

