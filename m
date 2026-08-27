Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207029B78B;
	Thu, 27 Aug 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839810; cv=none; b=sAwts//1bGuWFuuweIk5GIEhoZqVf8EQaqEgiQ0HOIrx/jsryuHp2xl8YsDhPb3bimCExKCXe1GnSBRMMFyPyuGV8HITiB358DWH4y34FN40hfqvseksLO5gWq8OtyN7vTLoX2lzAExKe8aE7utjwcdKg4/88wRcg67vbO8jRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839810; c=relaxed/simple;
	bh=AC0IRoHPxwITls58XXQ3zOs73Cb/oBNyHYFykvRVuqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mto3EZvugjuBak+eDpuWVApiKPbvkqNxccMTFfGWQp71MzV82rwGyoRFo56GCMVuYKHF9gaAPj+iq+9zLM3YgBCRmibSnLtaGnSL16v7/9/HUA9j9JwMP9yKTPZljcYi77YtQL+iqdpKxOkHssRr/1lTk+nheB5n9RWi9eSUPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn8ZxOAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn8ZxOAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25BE1F000E9;
	Thu, 27 Aug 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839809;
	bh=AC0IRoHPxwITls58XXQ3zOs73Cb/oBNyHYFykvRVuqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sn8ZxOAK1ElzcVbhHOfS+jSAW0un7+nUpKlzmD9cvdzEih75s0H4uro83iLFV5q96
	 isQl+Xava0lt46JOBggJeaeHObAZ6MataJx4Sa3MoF86ZCgkNeNXcOTOcJLm/vW03Z
	 RZmojqeSZxo+BfevgQXBtBT2aDAqrMIqGFrJx88uopEhXWnOsl/8PPIH/2VIj49GW5
	 4tAAbNZ33ao7uSrDXaizeMtWeLcdz9gl3vs7AakdV23iidchCe1sNitbjz2kitFUus
	 zX/yGQ9s3NgaSK50ajcQM+0b8IXk/MPuB263+IIQ93NI5/CNC6Gffqm1n12WI3Ewug
	 u02A3Q4gMG1Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260827140442.2031128-5-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-5-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:10:08 +0000
Message-Id: <20260827141008.D25BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Merge the printing of HEAD0 for both 4DW and 8DW TLP headers into
> hisi_ptt_print_head0(). This unifies the entry point and makes it
> easier to add HEAD1/HEAD2/HEAD3 field parsing in subsequent patches.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D4

