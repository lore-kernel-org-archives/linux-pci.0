Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2622689C
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023525; cv=none; b=HqC9zPlpL8Mz6CKESgsy1bh4bGqendSe7hBZah0B6HYWZpFEESaL+PjdgWGgArPPRMESzCRxyUinxNhRUGvcrTQhCDPVEu4UT0XmgbnxWuRV5Arw4QTm5YfPwbZDpnMIzruUxcl1nKX2uffSwlKQZ4njyCmGm/5iPk5WrtbJolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023525; c=relaxed/simple;
	bh=7CWGGPFOuTt7UK8EeGc635ibM1XF1/VTsomZ9LhaJ+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ennzwOpu8kDvHxRDp4Ebw3Yukee5NJDNsUS9IsLePo6OfeMtr2n7B4+snEMOrLIXcpfdnfOZFYrGJjPZ7OBPFr5JnxVNcUNMKAPeoH30Kd6xJHrukIXsE4lFuBObLvpI6L+BTpKUq0w3p3jAtYDWkOOLoHe8B3jfli+OCY6N79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfwBdexZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfwBdexZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71761F000E9;
	Thu,  6 Aug 2026 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023524;
	bh=rwexFvcO8J6HlOD2oYnykRyYcs8hO7xAMMpF1P8eSno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfwBdexZm06vgrXzI3Ks1auLWz3XFCzrvLEzItJK3l0XLhJ1aksR566uBgGxaPM/I
	 w52IxIqzO4JMxMRxtRkch4usouBzAB0o6s2fKhSz1pk8boL71yCX69nhOvWeSRUjSU
	 VRCWFgOCQucg7ghZvAB2rgsonSCjpVRAPFmnHHlhXtca9qClfy+CoGOzYHr+dH2Km2
	 4FsncaXt3dmMlZ+gumdiCmwRgzGtjB2RPiSu3c6HP7LzvSzj0Sp1TEsnAEH7mle75+
	 8hu16vbN3TZh9MoAYeRkNwQ/QTcMd9qJutENk2WXwz2KBxc6cRsjffSC/tiljTa0R0
	 rPP6fh+7e2iCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 02/14] i3c: Fix unlocked dereference of dev->desc in
 i3c_device_get_supported_xfer_mode()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260806131857.119830-3-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:38:43 +0000
Message-Id: <20260806133843.D71761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_device_get_supported_xfer_mode() uses dev->desc to obtain the
> master controller.  However, dev->desc must not be dereferenced unless
> bus->lock is held, and this function does not take that lock.
>=20
> The function only needs access to the master controller associated with
> the device's bus.  Use dev->bus instead, which is always valid for the
> lifetime of the device and does not require dereferencing dev->desc.
>=20
> Fixes: 256a21743d91 ("i3c: Add HDR API support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D2

