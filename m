Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327E45C6EE;
	Thu, 27 Aug 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840029; cv=none; b=WYdw8qrEDFr+WPC8GSAoEEJDKqAyM+VWq9scKYLvia3bxWM/+4WaKanCKb9Xm2IWmwhQdynws6NUn9ADCOg/3yEXupbLNfkn04YrnqfrQxuaVtEVF1KUAnxWWJpU3E+n3J+V+q5fFzkkO/5/Hw3qcWqPjhN6n93zlvLhcSWrz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840029; c=relaxed/simple;
	bh=9zIDvWVZDoZGbkwO0k7DF+tLFSqxx9pK8z6Q1+xQ+xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cn45tuhCcxSbVcGwPEpOsXmPnr/JYQzUeo+flCQFP7YTHtM+bwXg4PU4P1crdFjUtmn/kPvVpBNdKSN3oGjdJQyF34ozx74Hk3SOVxuSzJMyOZiCzLJZtM8Ywfy7UVIAN++FMItAGxb6uxUcL25eaXEiF9VF2JcJSaxzOSdZWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkohwwpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkohwwpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC521F000E9;
	Thu, 27 Aug 2026 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840027;
	bh=iNqN2hRl8zYWrrE3jXKA1v01MaQXcRyvUJfUUXGoa78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkohwwpFMdZQAVq0ed+P/2D35ue9BjrZqnKlq7ifUqAc8DOIwpbnQrFO4RXNDwLql
	 o1MiugjBoHIhYqBiQ/iL6oCp9xp4RciPo01cn8zFEk7FXm6w0ixpv577C2KKUYwb6t
	 3UpXWSoSbxVbgq1UTF621oTM7hpAM2az6lW668Aild+H0b8nPcGRnuJIcp5nN3b2CK
	 U/6OEjRVxlF7WFQ8l292nyhWfVGaobESU2OVdVhVfyeNd79D/Ghwc3HlogSez1WtaT
	 bpE1XbA76OMVWJ3ODkK9AtNlfp9EnneFySp5GaH2Px9xfctKHg438tYmAlAxicjJ4w
	 7p3wHrv8yRZiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] hwtracing: hisi_ptt: Add pattern PMU config for
 trace format selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260827140442.2031128-8-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-8-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:13:47 +0000
Message-Id: <20260827141347.7EC521F000E9@smtp.kernel.org>
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
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D7

