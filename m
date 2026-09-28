Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F336167B;
	Mon, 28 Sep 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559784; cv=none; b=IK4HRqzhPFqih1Y5qV3CtDeQJAhvUJB+4sO5Oiz+p78NDEwMj6N0NGR6SWsFVcVa4LcdUyCW4+abhv0IepC13Ls5Zw93RZgNWsbzXadgvdWDDIF+s8XBZyRjHSjOlVfsaSnqUNdiXyy1g3gIvJ62+5htIJ/YGs0Zzc4cRKi1UBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559784; c=relaxed/simple;
	bh=HXKXb5JZRospMRUHUw+Z4H5A2vrEC2iJXWc8qpH9Stk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZMxwSEuNEKZHH27BEMYz66cJV06J5viDpbwM/FSdJcoCYgNIHZjbcIaUKSwpmrkb1ocfBOLHvwn+CvPWxNBQVXklNWZuOLpRo2FHNu1Rdg71DcjRK8TIkLSFst69wd29sSN4+buXnwun96sgZ7zucPkNyBa8xEqRSYO7kcD1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlGX0lRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlGX0lRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A31F000FF;
	Mon, 28 Sep 2026 01:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559782;
	bh=Es8dRj20DG6Vq1rK4SdzQ0T20/g97SDbXZ0T85gLATw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlGX0lRLWqgYnETjb6zXk6dcKBZiVnhr+hWaFIQfWZFnnO6N//hFpZR4zGPANVV1k
	 azCK/CVd+HzU+iwGUF+4vrwyeV5cDvsk+jmlWAS5qpMiU0S3ljZXKj9CNMJSULuGk9
	 ImttRVNUIWDXoj7k2qbtIfir14X8v04yAuSfA8nbtdXBJ/o9/FNfzWaqG3YTrGrMmh
	 GB5jAmyvgXRMiD2c0VlQxOt2iEG1vFf3cyhMrzdVoIltPpNbRX/F1/emH8TG9mAaTh
	 P2EDNJryFrbUkNwUGtvxzMtqdJH8LYOhOSgSVFi81Buna+lfWU0Q5WgtJxceRFm6pr
	 hcUcK8nucCayw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/22] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260928011123.450800-14-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:43:01 +0000
Message-Id: <20260928014302.7A9A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
> allows for measurement and authentication of PCIe devices.  It is
> based on the Security Protocol and Data Model specification (SPDM,
> https://www.dmtf.org/dsp/DSP0274).
>=20
> CMA-SPDM in turn forms the basis for Integrity and Data Encryption
> (IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
> transmitted over a CMA-SPDM session.
>=20
> As a first step, add support for authentication via a CMA TSM driver.
>=20
> This was previously discusd here:
> http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
> [ ... ]
> Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D13

