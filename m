Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD12931E5
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023993; cv=none; b=lJVjXTMA1RGDbfHjxsBDK6Iu+hY8a3PmR2EODvfdYvHwZ/KI/6tlv0ti/nTxGZgNQTZ4yy8yQO7s2VP6QbihWVNPHvOv8dXC9kmsxFYRNVaN+lAXePnuSuKpAp21WMbJGlZDe4x+M45EKepg51RVl3yadI4grULuvi3IhOoIX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023993; c=relaxed/simple;
	bh=p3Qd/1e4v9FWB9rkPTLag/DXeEWXbqVoT/g7Q4Da9EU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCHVHTS204VyZkhZSCxCzsTSJj0wleFwCHv7ZhiZtst7F2HH9GC3P/v63D7Gh5S23oPH/PI0iYLPDQgteN/+79139cMn/GwBElhgG0iuwm9KHJb7xfLAXxIeRtfwab7ApquB9NzqUnsIfxPW4hZc+TgwuBZIBP+jUdzl7vXzmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E48PnlpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E48PnlpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD91F000E9;
	Thu,  6 Aug 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023991;
	bh=p3Qd/1e4v9FWB9rkPTLag/DXeEWXbqVoT/g7Q4Da9EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E48PnlpFwDfQFHtdIj/WRt0gINqiyz+hqPUBSxwj33Olno5myw9d3SdVhPVQ0Visi
	 SPzac9bAEU9b48IFARrpJyqapR2wxGzPGcpcYmvOwMcHJ3CceGIX0lkiajYBdDFIj2
	 d/0nrves0hoGcc+lfXVRr220Y0V/VJxkOq7lNXSmoxWj432/+uxSc1WfXe1HUmu0R0
	 622TZ9sk3JJJa7owLYFpbGb2DUfd9XySIUrPrdUS0Ke8Xguc2/OfAMuUr+twXb0Prg
	 xYef5nReAMw/V9n7oESE+na32SY5XQgtCSST5UBfSCqXnZBjwcNI1JGfQtrpKPRvN4
	 KO2wmbcq5BaYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260806131857.119830-14-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:46:30 +0000
Message-Id: <20260806134631.5CBD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>=20
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>=20
> The explanatory comment moves with the code, reworked as kernel-doc now
> that it documents a function rather than an inline block.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D13

