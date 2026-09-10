Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9813D47AB;
	Thu, 10 Sep 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024928; cv=none; b=ciC/qvB+yyPkQ0GyXle/oYSQy+kJ1c9Y3OXqR86C75Zab3ARqdriZdHhC8+1s5M0O4kSG7HVF8EY9M/2HtdHROsmagmQOwDDI6KBX1obiIbzyYfQen1+ygkAdcw9Ano+MpuVY+gZjea6pPUxylOqM79T9pwcIQ6LgkT0CnlP9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024928; c=relaxed/simple;
	bh=QhUuS0V6vur8bOmlJaxpTOpgAQHB99TyOc2Konma2DQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tridrqGs/3ZxmtvLHt5XuT7My0HbO2TbIB0ZsEUsjNYWaMPu6Cn4miPNpXKMMcE5cwbyhHXmE0fhJFY5Qi/pB6TJUNI1Ei32VoVK1wmybTW0GtVJrWpn+HxlAQAGBWbjxthN9r9nWvAHj/WxUJh3AOprDsweRPUt7xvQl+0Iglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKhCMAhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKhCMAhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFE91F00893;
	Thu, 10 Sep 2026 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024924;
	bh=QhUuS0V6vur8bOmlJaxpTOpgAQHB99TyOc2Konma2DQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fKhCMAhN4DPFsuLlhMC6tdbzjIdRelaNRTffxf1JEV7ADSfJTlNOYhTDWPWwtA/N9
	 WtOeI7bq49lx1AABlDmwgABa2nqzcuoCJuhzfqAYOXVfmhZEbq0BiUpcxHyHANQb1x
	 KrOypiCu0RRah1arAWdtYjM6Nx1JaLJfBOomTCuEkfPdF+4V5o+jNzp0A/sOiS9UeC
	 mqX9VzMTD2lMMr42u/ZDxd1bRi/+gcUrjxtXF3xSnXaR9L6lIHZ7y+VM6q+F0I1CDX
	 OPx9wsKPpGmeGG/CTFNRGys1PHafhAHiB6KOUU5fc1m3TwNSZJmSr4cUkADYhqH7fv
	 Y/pRcFmIQAoHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/12] cxl: Validate HDM ranges before CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-8-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:22:03 +0000
Message-Id: <20260910072203.ECFE91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
>=20
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue
> after the range reservation succeeds.
>=20
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D7

