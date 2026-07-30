Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AF23ABBE;
	Thu, 30 Jul 2026 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393290; cv=none; b=bpEF8gJ5HCbakwQQWoIaxg5oNHV+o1H/A03dslczzts6VHulvR560DJDu/hsvPIOvNMhWD1dqFYnV9rDbzIsn2J1n7SDJtBAYa5c14ZFo2W3eahyb1kV9c7Vn/5LAemz3F2Gx2vi2qmYyhQBv69QpnLjpLa/WZnbtF+oCXnZzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393290; c=relaxed/simple;
	bh=k5itimuGGvgsqBWClwf8Yp8J79JHqipVmKNYp27ljxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtRAV/mJeMwKoACI98IHmRfBjZaOgOxsmdINZOCWQX120EF7c5TdPXCtlCiRAQPL/m7BP+ST8xiTigGHOVeMB/tJrG989UMfYXUrOf3UUvvk8cdAevoHGzc8azT8dwMtGFC+zyFpEEiiGKIzPAgzF7gUSwPiOdcBbpo5Oj/SnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAH8+3i6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAH8+3i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2CE1F000E9;
	Thu, 30 Jul 2026 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785393288;
	bh=k5itimuGGvgsqBWClwf8Yp8J79JHqipVmKNYp27ljxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAH8+3i6/XLs929ZRe/d/WQm+lr5/E/cvq6ZzaRCw3zslZT8fwSBGqSZShLSpZgEf
	 l+i2V2oiWf259/nll19ZNfRJLoodF2RY02vYAa2mNVYPnBo5z9t5FgC5RRdA7qCKtn
	 D0M3CPV/sZ2G91OLYfcFWiJEpF1n/UrpwKaUvBbs5GlADlgW5ydlERqUJVUBZ75iBj
	 0T5eb+S5XKVMI2Ff/DWh+BaLN7kL9QkSVzNvlsAqB0GldGZPnRBGPKA/Mk9fNXTyVh
	 A0C4vXa8hf9E6YMHXEY9Tk0MUO+J0Au8+xvwgUX9gi/7MzlE8E+CNQxjNJRiQNgGaQ
	 DJ/1X8URsIdVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf hisi-ptt: Fix spelling and abbreviation
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260730062709.534139-4-liusizhe5@huawei.com>
References: <20260730062709.534139-1-liusizhe5@huawei.com>
 <20260730062709.534139-4-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:34:48 +0000
Message-Id: <20260730063448.9B2CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix spelling and abbreviation errors in the PTT packet decoder:
> - HISI_PTT_FIELD_LENTH -> HISI_PTT_FIELD_LENGTH
> - hisi_ptt_8dw_kpt_desc -> hisi_ptt_8dw_pkt_desc
> - hisi_ptt_4dw_kpt_desc -> hisi_ptt_4dw_pkt_desc
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730062709.5341=
39-1-liusizhe5@huawei.com?part=3D3

