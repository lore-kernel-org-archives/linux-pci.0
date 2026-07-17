Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A602931DD;
	Fri, 17 Jul 2026 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329137; cv=none; b=ED6O5+p5MebSKpEyKigtxJZKuF7qhuDtDvWfEvmaOuWHD6qBRnl2dI3zLASxO8y+MUDVU71lIhDCneJSddMAhIs9ktxe+MkvpJwupsjsJqAwuO6BS5+JPemQEdjj4TFxrgswv+o80JUpyrm+62OkNDQZVz28RZTzX9/bB9rt/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329137; c=relaxed/simple;
	bh=r+FqOH/SKkGfTU8g+R7VKljcygWToIQWoCfpv0g9R6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VECYeWb51QNU+Et8lAKNueJ3s7kz8+2oSki8e/NWh3y/+n0iKorO65WbOy2kJGCsbaDafYe+A42kq7+X9zp4ok5l0bG+LK0NA7yEN/y041K16kZ+LXV9Nl6pYzux1Ttvfi0oVEcA7ulfB/8jM8/D6aRp/YFjbwU2S/dbBwoxenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROlgdtZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROlgdtZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC31F000E9;
	Fri, 17 Jul 2026 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784329136;
	bh=r+FqOH/SKkGfTU8g+R7VKljcygWToIQWoCfpv0g9R6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROlgdtZNcvBxd0SROovuUKOQIbB8bRbfd9BECfE2xUunIap29iDstxVrQaGs69dfe
	 HleOZf5YHUVZSAF5wAkVJ716F5sqfDvZiMOPgs9tk++ZOSfCIC/07I6tpgHpYk0tbe
	 X/dUIzOu41z7mpyvYezUTF36KN/PO2Zq4H8VSALexZRHmUJCRo0xxVRwn9MTFLiSEo
	 GALKx8i0hAnob4SR0GOImMnIenVpEw+M2kpvM4F/3VXOGXqk+0MgRRTamiZ2qCs31F
	 r1xR6wcYfEgy0JVdEKgfUY8GlLZfrX+t50D1JgVCB9pugBoGgKbPAG+OoymNtbyOHm
	 EISB+EDe/UQHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 12/13] PCI/CXL: Mask/Unmask CXL protocol errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-13-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:58:55 +0000
Message-Id: <20260717225855.DCEC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL protocol errors are not enabled for all CXL devices after boot.
> They must be enabled in order to process CXL protocol errors. Provide
> matching teardown helpers so the masks are restored when a CXL Port
> or dport goes away.
>=20
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core
> module.
>=20
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> or non-PCI @dev so callers do not have to special-case it.
>=20
> Wire cxl_unmask_proto_interrupts() into the success path of
> [ ... ]
> which is sufficient to exclude cxl_test mock devices.
>=20
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D12

