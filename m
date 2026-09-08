Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18655C1D5;
	Tue,  8 Sep 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877173; cv=none; b=XaGnCmSg/jirfDhQKsJHQqAkExMNA5NdmYxxI1A33CpuIXqB54iodK+0TtiYvHS+I1/gw5nZ6loJUHZamynvb7WFWp6JNDxWSB2/uFciLpOmETq7VykiTzP3CwYjbjWK3zSDcKh7DeDUB+SNpo0S04Png40p+hS4wnnSRg3ZyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877173; c=relaxed/simple;
	bh=n/C6TJNDN2oLBRgz2Rf7sAIIX2lC7vvyw5LhB9+khd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UH38yyNL6wKGKDsmbS5OQMKKaVqc5U8yhxladCgkLANuhMw2a/kzzkqgOYwgOL0FMD24so2mNQpZ+5HVmY+pBNorwl+HoH5acfLlEmzjayIeSlRyA28vsX71FxTmJ0QXf4sSkP+lZ8W2piO3fkiH6KRS0+Re5055Mm9ZGQNbzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQrrlh76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQrrlh76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA11D1F00A3A;
	Tue,  8 Sep 2026 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877168;
	bh=MwiwDzVsxLO4GrpKFT2691e09KozX8zvbs1GIChQG8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQrrlh76ASCz/W4TKzrzYrQl/WPLrfM7XttZxX98q3uhHuSyF1qtlE7i92hEedc8C
	 FEEqfNHBtPBpzyo7DdODaf1iG5wquPWe5h49R0DL8MMDcuQxVIDlZ3WBDfz5rVfBrK
	 DdqRjwp+DywXhlpSx4YW1tIa04bE0OT2P/c+TdWDtmbxbDiT+7LDZ98uzI3Sk59SAw
	 qcXfpW4tU6FhKBHpyF2WjDo6j90XA099Soif+cVyhyvsAAkqnnIsPGkxfGfnPywDdO
	 IDHyLDhG1L7hKLDcm7PfoBOAi0q64hCX0T4OzCDxlC8fElLI+mCYiBVGIUzeVvfrFU
	 RuvD06cteKvqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] hwtracing: hisi_ptt: Add pattern PMU config for
 trace format selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908140509.2485649-8-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-8-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:19:27 +0000
Message-Id: <20260908141927.DA11D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce a `pattern` PMU config field (config:36-39) that controls
> which TLP header format the hardware traces. bit[3:1] are reserved for
> future extension and only bit0 is used currently:
>=20
> - pattern=3D0 (default, compatibility mode): the driver sets bit[8] of
>   HISI_PTT_TRACE_CTRL so the hardware traces the data in compatibility
>   mode.
> - pattern=3D1: the driver clears bit[8] of HISI_PTT_TRACE_CTRL so the
>   hardware traces the data pattern including some bitfields of the TLP
>   header defined in PCIe r6.4 sec 2.2.1.2.
>=20
> Note that bit[8] of HISI_PTT_TRACE_CTRL is inverted with respect to the
> `pattern` value: bit[8]=3D1 selects the legacy format, bit[8]=3D0 selects
> the new format. Bit[11:9] is still reserved, which is consistent with the
> PMU config field. The driver validates the 4-bit value in
> hisi_ptt_trace_valid_pattern() and applies it in hisi_ptt_trace_start().
>=20
> Document the new parameter in Documentation/trace/hisi-ptt.rst.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D7

