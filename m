Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC7418A4F
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056450; cv=none; b=d6dCw2oa7BpTK4kI5d0uCC32GO7H55FwXV48e5+Dxs2wX+4UGyV9aLDVuqnbDO8PrV/wZYbulYR/i/FtMoLxLN65ZDO0OJ2lorqG0DcxpfMDmEUIl6z3jZAfCP6GqwMBc89fHJUjGf/cMut2mDpF7q20M/hi2SWV1eTlVgCSf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056450; c=relaxed/simple;
	bh=M8znJKG1zlWmAXPPOgzn7ItbedUpKz5t2DIjdTtcfWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HERfJAIYhMsNNSqaAWBhHu5qZOc23BIIZSxByT/sypSTNGkTLzsF35sjMalyszIAGkBQcmoXkTZ7eK1RImhGq0fg0qh4ojgQfABd4MBoK30y1i2o/6wTApWNkwf2DqK0O6/ixgrHv/CvmfC3q7AqVYARiCdSdwGH4gVuzUygPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwxG3TW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwxG3TW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A821F000E9;
	Tue, 14 Jul 2026 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056449;
	bh=M8znJKG1zlWmAXPPOgzn7ItbedUpKz5t2DIjdTtcfWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwxG3TW3B5aJuIaVpqDlUmncduWkZE/zYYGAED9PyO9tktOxFTWodTTOJAtmlkbje
	 o0m9IUX4g3w48ZyNFwzA4hMfmqKSvij+/QFf8xVFwbFktqanZiSIeesDU0hoJ3ZEsc
	 7MfS8eyys4jtMSuUlzBI9UdIKMqTsIAwVbe6WKOe9PyoEjAOh0Bt/go8mzQ3NV5qAv
	 UKCsCbEZ2qmrc+PT9DE+9y1p7f30C0spR1EoOoUtpG1zm4dt1GWO3n0ifsscfI9oDk
	 VaygHg3UNcbMFSf/m2yWuZMqRNDe687/JSYRiWpV/58ypQKb99TYxzRp8pVVBreJhS
	 M2wy78sX4BxZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] ACPI: utils: Introduce
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-2-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:14:08 +0000
Message-Id: <20260714191408.C5A821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> There are a couple of users that open code functionality of matching
> a given handle against ACPI video device IDs. The current approach
> duplicates ID table along with the matching code. Consolidate it
> under the acpi_dev_is_video_device() helper's hood.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714185915.8653=
96-1-andriy.shevchenko@linux.intel.com?part=3D1

