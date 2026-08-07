Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0F364942
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096268; cv=none; b=BcBVnQALUplmaActDpF47zCUxCrp5E74hJ+5Vk8i3A0Pq0smmFcSXkwJZGiIU5Ru4HGcOUzTSYggdp8XoKIB0JXK6gPaYr9vgMraD82hPNM7wXozDeAUIHX+S/gS2/ntnVea7MjA3n9eRT9KdV+ktKFo6N17WgbdLfTNacsw0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096268; c=relaxed/simple;
	bh=8XOx0bRS1eNIKI3dFOA1sh1fQwATq/AJt5d2jBH/E3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZcHrAWDmcL5tHWH+ZsP8AtlSKNW7mF+d5UL0FoxDrXLEzQ+F9BJgDegWwHYsJp0iVsYeK9VwfwT3ndgYDhjuX6934Dth4Lyq1D6o2uhNffFubGUuCmcVG8VlKJ8WnPAp0QjA5l7yf5kYMLsNMO5aRo6glcqp5m94hE0lWz9f9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygc73dCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygc73dCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E6E1F000E9;
	Fri,  7 Aug 2026 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096267;
	bh=8XOx0bRS1eNIKI3dFOA1sh1fQwATq/AJt5d2jBH/E3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ygc73dCEeW/TonylOdR2uPY2S5r4PigxgdukKt39eyJyf8Qe8Hac4JBGxFiGPqgN+
	 3F5nqwcJTPmqnfIWexKU4DwrDcP0vbrhWAZ7dqQ/CxbxAAciNiuO6mNTkqAW+Ayi71
	 v+lRg5VpcYPcNQDDhxTmAUBZSxRy4LsvquC6AVDR2FDR4/V9wCwD1PnPuh5IQDKB24
	 av9OjZYR8ugSmp1jxb77wPyxpWAPqpSVMp9ylhdk8vn8BqZxmEYkcS/vg2C8J7stlI
	 Fd307eCdvwnonhy2t+Rx66Wp1ccRLWRN9EyITpyUBkKO8YPN1D8JvJlHol5xhoHHDd
	 3eEM1ZKGEF+BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <thorsten.blum@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260807094601.263450-2-thorsten.blum@linux.dev>
References: <20260807094601.263450-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:51:06 +0000
Message-Id: <20260807095106.E4E6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
>=20
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
>=20
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
>=20
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807094601.2634=
50-2-thorsten.blum@linux.dev?part=3D1

