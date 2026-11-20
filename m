Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182809;
	b=OZHBA+RdiLXPpeyZ0GyCPeGAhb2aeF+HGfE/OlWtuTwZs9bKsoKvFUjBtJFZLLi+n8pg
	 yiatdlysoewbGS7NE6bybG9G7AElokAoj6cmljZZRaySLbXgCLC8Jj/MvkOY7k3dGgp4A
	 orQO1drFpgj2NF005YCnRaoWcxFTqFR/jlijhEOmTvnxjZ4tamOI843b8zGLHhT5FO76G
	 xJjRFBwdozxq8lNCVdItEV5SCHgG3F85mj+vBO9NIhEr3/2uZBLq3U5bkIQnSNuvkjwGq
	 g7pVaJN/UbZ/ZXTbPIL7e63te4CgNmyRE1iNSAsSkxYAVv133pL02i/8iQC86OO6P9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=055dn7BlfKn810O0FMPT7M4S61SR8XPArFvPxDloE20=;
	b=h6vGj/5EA96ZDJDbhS/We1oZdDgqYK85i8oRpibE7prjThewR10hyARG2LNCGhYDOiKl
	 /e9ksnV1Egc53yx3tZnQ7VtyhAJ9KjHTeCsqC8PYayY19kwYgZ2pQYGt7jaHY3Xy3lSAz
	 UfEQDRYMqBF8Mjk1hspis7rDCh74LH0udFdo7PjuiTYmbPsfyxz4fLWhfZao7SsY3kHMw
	 CBCVoSgyWoU9IFS7v0/rVLBnBsHdLpm6544uG2Dgrci0oJKQ2bc7wBNnoFrx9xmkux1G8
	 1MzK+54MS+Xk2BGLaWnN105Nok7PDE1XY91NP6ELKqhyH8dMA5vGt9Q9KvvZVM5ktiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="imcn/9w+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3173606A33B
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imcn/9w+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1B1F000CA;
	Fri, 20 Nov 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182809;
	bh=055dn7BlfKn810O0FMPT7M4S61SR8XPArFvPxDloE20=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=imcn/9w+sfZbRAo2p45G0v6cNvpTR91eEVTnV7D0rboOEQf+26Kd8X40y406Rsez7
	 hUsQR7mws/izVuW/zbba2p6w7LOsPcbdm3ycZwIDoDwQqvZPoxM1X2XiXdFZGo0KF4
	 I2bXcDNIr0gA+mPRJaMaVVDTNN7gMlO81U60NQwPOwiEsTrcllnJiNfqVYoylplul/
	 wGphPIGDdU/SUyvWbQZ6use7D2RpsdNOmuzmBmlvq4ltpFa6RtrIuXoqaFVcofdZKj
	 Qirzalya7k93I2BHLx1rvKKeZljzCXKu7/21Pz9IaRhMDBOqCKU/mae025LQeaRs3k
	 aGYATOXsy7frQ==
Message-ID: <sashiko-outbox-225292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] platform/x86: asus-wmi: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-11-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:53:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The asus-wmi driver scans a single device and then attempts to assign
> its resources using pci_bus_assign_resources(). That function makes
> bridge window sizing disjoint from the assignment phase and is going to
> be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely a no-op in this
> case as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D10

