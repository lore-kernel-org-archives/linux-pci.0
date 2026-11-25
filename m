Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622655;
	b=nQfagDs/Fkv0QiSxBUoPDt01lE+PJpcRaPB7PW0J40Zfj8NgLTupQaERF4/q70JkqmlY
	 JhTXRZT0vnxhAlaQ+mjkn3mLQycHpmhv2d/ArE5tQOhViVMrBvBAxofFe/IUV9uIIuVH7
	 UNTecFJBCDWMEYbrOgA4Jvg1mPdO/vfaWvK+G2o3+Jk9f0kpgpvnSDPAym7bZ1VUdM6q7
	 P8IlUDEJxYwCPQpuJsvzFub/xoAS6Ed/FDVzb+sQ+osH4qUGLB9V5UYktUBGU+bvkYV02
	 6Z30/+Vc98xAAQhGsxONwgWj6n5ol5La4iN2hYf34XvcV9yauUAWA6+CQCsb5ncCnuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o2QXDrmdZDVsnlXSX+OobKFcVW+kPW0/9A8LF1nMsCU=;
	b=A6jWSNnRo+UlOBoalJGZrx3KJdpp8JyW3OucoKY7WeYH9sB+lZVzWdjRMhXotmReMLIY
	 a4N3u/jOedIIgwOvfex1gpa4GYCOCcysFR3H95PlvtHtvv6O8LpIRP/Xac5S4jvB7Vbi1
	 cTsT2jLZH5QkCDjMfMglz1RVMt0EP4W/ZsWnVMeYG7vsep5EOrxA0SJu++Uf2120VDpNK
	 YbLGc+kJ/0Frn6NyJY5pHJN8YviL8L1U/Ngyo449ArXlbK7t7tfUoRXITTS/SCY/2ywoo
	 USbJWQc12bhLHvE0/9CVmqzpSI/k0njh7pMb5BLmYSskbeaBcY8a9gmgOEBdzYxOAPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ac/VzwkE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EB606A336
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac/VzwkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C121F000CF;
	Wed, 25 Nov 2026 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622654;
	bh=o2QXDrmdZDVsnlXSX+OobKFcVW+kPW0/9A8LF1nMsCU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ac/VzwkEF8FM6xKEY6uFtfK0ThPos2ZlIgTOzHCS+paM0Wzw+FtOdx6CU9jcTw1xi
	 Ocb4vJsDu2eRxxYIDJZX07c2HzwzMMHirOtHIe60HOWrgh3j+YlTLBH7ls4NAbXX20
	 obvRBhts10vvfOwm9isVpofu2Vp0Q195E1yy9Gbjt4IuO6RM4XJvSIng5b38sPw22P
	 s12vDMxoV0aoen7NLAr9hQTA92lilkS6MEAI8lTaxyzYTfaIp4IJEcXA0FrdPVuQdb
	 K+k8caF7s0v9Q9CNUEC0ZsuCuDtyow2f+oRlxXPHO2k062FrMx5363YD/eA5dskHj5
	 b73790SaShAkg==
Message-ID: <sashiko-outbox-233704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Tang" <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:04:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During stability test, there was a bug that running 'mount' on a type
> of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> error and panic the kernel later, when using "pci=3Dpcie_bus_perf" kernel
> cmdline parameter.
>=20
> The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> its corresponding root port is capable of 512 bytes. When enabling
> PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> both set to 256, while the root port's are both set to 512. But the
> NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
>=20
> "
> Max_Read_Request_Size - This field sets the maximum Read Request size
> for the Function as a Requester. The Function must not generate Read
> Requests with a size exceeding the set value
> [ ... ]
> setting is no larger than its MPS setting, while the device breaks PCIe
> spec. It could still be meaningful to warn about the possible danger.
>=20
> Reported-by: Anju Zheng <zaj01616726@alibaba-inc.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125155829.7726=
9-1-feng.tang@linux.alibaba.com?part=3D1
