Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973332;
	b=odNc0ron9YuQemNX+DcrGkQKG3foK69k0adXgSGfsMPge1pVCAMuBdo+lybKYTzlTR1g
	 x456RkJ+s1iOPfj4ryl7DArGzZASrsPCsRj1nE9oOHWtxpZG0nDwJatMiqMcrZ5oCoqwK
	 k705AiV67Z7DEr1tM+F/KREm3xMQVHDE6Eo+pJ2po8ZerebrLjc8ZuKcZsMIqCwC+/u8s
	 YIFcECKvufOxroMbflsvat3xCvtfoCmm9U31fmKDhbxVOXSXW8WZ19yl94vcH66K8n5Te
	 1XgUZAGqOFhbm8HCndu2XS52RS9PmmCWpkc72WEy8Tsxq4LiJidur+8ee7jRcCw/cOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=huD2JVVMUHY2Cj6Bi2KfTsA8UwAIIV35GH29pW8adwo=;
	b=Jwoq9NALmPZ5Be05XSFW4otYx4ipRNuSlZwHqGTu83oPl6UWolx4l4YiiLpPF3PHAwJ5
	 J6VBs6aVkSpsKsi1mVDu4ZL33Uxf1VDYWeolbceOJ6hSEC7QFKebSy42ouhWKa78foTkS
	 khcXF94AiPrLuKCFh8IbmjZasVhdezZKsPJkM9/p5CkMbbjMecy0VkmyR1pgsfnRfHydM
	 tbi/DERDJBSeFK3lIr5olJr186ja74yuHgKlej4QOLVCm5GWmQIPp/6lv3qcqyhoO4YZp
	 dXvzhd+kjn+Q8jDXkQkxttVEPTf/s8oehZRpEz+IVJxphpuk0fa0b7ZXEf+e0C1zUmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xh6cR/Ok";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCB606EE8F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xh6cR/Ok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714261F0092F;
	Fri,  6 Nov 2026 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973331;
	bh=huD2JVVMUHY2Cj6Bi2KfTsA8UwAIIV35GH29pW8adwo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xh6cR/OkicJcRr6ZoJLhfLWRqzm8ZI52xUTHvKoPxSDrN65rKpXvrYBfFoMiyTOaw
	 POUcHshQk0jhHwC0jGeXu1a+kuV3B0F6eilU+Xk7kdE2G5gVMPOfuXTnB/Qsrgxd2C
	 MqX0h79aaM9GSidP7xfs5APUqfH1hnPQL4S4MScP06Lbq734HOzAySjhOYrPTEJXpj
	 E1y1iRLe5dxIOzDFv6o9uMRqvKd/iUz4Pre+yEBy1I0eWqVr4Wj9kZeXDQ2n4Hqz0X
	 2VBo8xZSWs8awgCakcTaDjTE6pzL5MDkGaWZrOohgGniYnHALmJCJofTjowASoOv2J
	 b68uY9oTkkpFg==
Message-ID: <sashiko-outbox-201512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/14] parisc/PCI: Clean up resource debug print &
 use dynamic debug
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-3-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:55:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Remove ad hoc DBG_RES() and use pci_dbg() instead.
>=20
> Remove printing parent resource as the passed resource is a temporary
> one not within the resource tree so accessing ->parent does not make
> sense.
>=20
> Reformat the message to the typical format used by PCI core. Print the
> resource using %pR.
>=20
> Correct format specifiers and remove nonsensical res->flags int cast.
>=20
> Dynamic debug prints can be enabled by providing dyndbg command line
> parameter or through /sys/kernel/debug/dynamic_debug/control so this is
> a more versatile way to debug things than the previous compile time
> decision which could only be enabled by changing the source code.
>=20
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D2

