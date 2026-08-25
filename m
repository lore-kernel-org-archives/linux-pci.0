Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D318FDBD;
	Tue, 25 Aug 2026 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636982; cv=none; b=O+9tIzF9BxSxMu4bWJcGL+dh6rrBRl6h5fdorPwvb0cx4BWje+y07aLUp2R+OM76AMFiHGZwz+1RWrYnRt8irAEX42fekarN5a0EZV6DueU+FVr1DfAexFOlKVclQ+gvrB+tCk3BYHP0X/hO0ABM++ulfnXcpJ7RyAKq1cQpHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636982; c=relaxed/simple;
	bh=ChXVvPRNqiCPiIDDjeHPpYTYuw0wt0pt7DMfc3pcN2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LKnICvvPW5epRv51WyHCFNguEZwgHtFRgzjwWvdkPj+GKiJgpzGC1KU/aS12QurMNeRJmj6GfdxqgV6shfYDrK/uO4U3RIijB/fA4+DJadaNYnyo36oEJZCqScO00swuvsvr48sN6S8fV+ueoA5rXqVB/27p7qXipzWDUxU9Epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6jhesz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6jhesz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BA81F000E9;
	Tue, 25 Aug 2026 05:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787636980;
	bh=ChXVvPRNqiCPiIDDjeHPpYTYuw0wt0pt7DMfc3pcN2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6jhesz8muj7zvXjNpAVyS75juzRVuij42NRnRQcO+u5QH0O8kMjPYFPhvFqGchxt
	 w4jvWE8ZQ1n/ulddLpFWICTq5US68hD8/joom7Y+EUT1oicghYUhLZmp86SYSv9pM0
	 AzZgO0Jmdu0R30Zd6xlB8pAHQ2lVNJ/pEO3ALfr9F+4BHEF6CBAxhw7G+SB1su0Gpt
	 9TjNrlYlqJExBaC/hcBXDtc5iiQQz/OvHwMFLEG4Qx7TleuaNG65yn+N38s4SmxBh/
	 aDYgBm2Krqf92v0EuSlBFnBYpMjm5Zh0aswfCSFsbvAGhynApjRu4AFnwi+yFGz5Xh
	 F4NJgC2VXIlwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Export pcie_aer_is_native() to AER
 namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: linux-cxl@vger.kernel.org, intel-xe@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825054312.1319951-2-raag.jadav@intel.com>
References: <20260825054312.1319951-1-raag.jadav@intel.com>
 <20260825054312.1319951-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:49:39 +0000
Message-Id: <20260825054940.55BA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_aer_is_native() was originally exported to CXL namespace in commit
> 49f776724e64 ("PCI/AER: Export pcie_aer_is_native()"). This is a bit
> misleading as the symbol or its underlying implementation does not reflect
> any distinguishable CXL functionality.
>=20
> Change this and export pcie_aer_is_native() to AER namespace, which is
> cleaner and more suitable for its implementation.
>=20
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825054312.1319=
951-1-raag.jadav@intel.com?part=3D1

