Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41701C84DC;
	Fri,  9 Oct 2026 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522174; cv=none; b=Abp7bdO5PLarnN7BJCpLuBI1uc0K01T71OJp4nN5qG2mfSeFq1Zr1hj18gvK8gPQjvRBFeHnHV1hJtklhu8Xnstfu93RGqo0S3nEZYCh7TTiXy4G1LWXpc7DbVB+TE8zQWDzdVBRAyiwgyJNFFecPkLIqA3Pyokr4LJua7NGu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522174; c=relaxed/simple;
	bh=bjgcfb+k0br43t5EneMZPOp4+c5Ixw1w4JpZmnlAhGA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oTG1+50ie0I0Ww2BLm9LN7DFBh8AomdhR7R2861G8mGszhTvZevaYxWal5GacDUe4/1Xd3h5WKD+TTPGPqxdCBZcbGKduqVvjI1Sb1NOGdIkc+asGi/KZuJE7Ef+4yUZUs+rnua3warfelXHEQMEtEDUsJS6leYmIOPDm6d7y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRolQxyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRolQxyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361411F000FF;
	Fri,  9 Oct 2026 05:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522173;
	bh=bjgcfb+k0br43t5EneMZPOp4+c5Ixw1w4JpZmnlAhGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRolQxyIHTyNEDUQLLkYUO2G5ABV9xN+Z56AbWJ/bOJ+1pgKCc0Pb9e0Jdhg7hy8z
	 UBgDFaA9PVaUEaALh0TDjW33YelV3IYkC8K8Nc+ofagIfj/cJPZLKYRNeGNu1X9JKz
	 4OHMRS4+G5sEUixrOskZYbZasOBcPfjTKCebMQyaMu+i0ipOU5jZes3y5u8xfmquIK
	 bfQPHY2nH6Z++7zBlWvMIMVT3DL4tUkjsVplqZsZ0Hiap534BlDg4vt/kte+KkDcVd
	 BXL6zw6XMgqyZv+3iLtRqyT5zGW8up7d9vrZBOlyEsOiBhW3V8zBk0Jwr/LTQPR5hM
	 gacej/uTVz4TQ==
Message-ID: <sashiko-outbox-164864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] cxl/acpi: Convert QTG _DSM latencies to picoseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261009045452.1107921-4-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:02:52 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The QTG _DSM expects read and write latencies in picoseconds, as
> specified in CXL 3.0, Table 9-30.
>=20
> The code base originally kept the latencies passed to the QTG _DSM in
> picoseconds in effect. Commit 51293c565cf4 ("cxl: Fix incorrect region
> perf data calculation") normalized CDAT and host bridge latencies to
> nanoseconds, but did not add a conversion back to picoseconds when
> constructing the _DSM input. Firmware can therefore select QTG IDs using
> understated latencies.
>=20
> Convert the latencies to picoseconds when constructing the _DSM input
> package. Multiply in 64 bits and reject latencies that cannot fit in the
> DWORD inputs defined by the specification.
>=20
> Fixes: 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009045452.1107=
921-1-den@valinux.co.jp?part=3D3

