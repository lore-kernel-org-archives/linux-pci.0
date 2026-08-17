Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750A3C062C;
	Mon, 17 Aug 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954038; cv=none; b=Ob+BwZiQU1dHjtO6irskJWOERXo/CeufgHKjH7zcnpwjqW8jTh5f9xPD5VALto+/8H6Z0RQv1eN9fbnZwRQwiGkLGyhnsIbXTUq1EYp3WZJ6t1zMnrZvrP1gzqt5Rh1Kcusou3ysGaYBHQR3TrijXYaAXPeoJwbJ/CumdKov0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954038; c=relaxed/simple;
	bh=OUElEO9ocHPqIEIUoYu2cTvhSeHV8r+XRh/fJMHKIyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0BNrPrfWES5HIOXtSW9XlEZ0QVwCrjUs5HM6Vph2QMleMuK62pHRIW7XU4bxcZNw70TiUfs/5JFcd8h3pPkuvye6D9Zspy9UrWZ7b5Aae6qj8sMEqZ6mSgz2KbXKvV/iBm5kap10fS/JWJIrI5uxuLuhsQcXx1vZX7MkCcTLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKBVtT90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKBVtT90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F691F000E9;
	Mon, 17 Aug 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786954037;
	bh=OUElEO9ocHPqIEIUoYu2cTvhSeHV8r+XRh/fJMHKIyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oKBVtT90hpWJ7kGfJXJ0/098Vp6sZ6N1Im2l6gffF+bSuvPpvMKl1G1u13mV+GEll
	 m1BnpVpQxyiCOPCjZiVTmase5hR+ymQjMiQxNyvJM66t50rl2vOIZUxA9o8JxmdKnW
	 kixJcIW2VYYnU9wvcgpOB8BnOVyJ0+0nMtMfx9i1BSra7o3DlgwCsilBQHZy2u8yR3
	 0mA6vP9LFIwZ/zRsKHMFsKl+zG/831M8nx5on96Q+Ja0OCKc9KlNbe5jBhHpgqW/Ka
	 3IIy2v7RWdkiSJiCVD+lUo0RLC/JFmyUT1qTG922yNFOFPMPbJXOlO1XiINaMLC6eC
	 wPv5D8WTPajTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add MMIO Capabilities Register Block
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: penn <engguopeng@buaa.edu.cn>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260817075854.17207-2-engguopeng@buaa.edu.cn>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-2-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 08:07:16 +0000
Message-Id: <20260817080716.D1F691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Penn <engguopeng@buaa.edu.cn>
>=20
> PCIe r7.0 sec 6.35 defines the MMIO Capabilities Register Block
> (MCAP). It consists of an array header followed by capability headers
> that identify the version, location, size, and vendor of each MMIO
> capability.
>=20
> Define the MCAP array-header and capability-header registers and their
> fields. These definitions allow subsystem drivers to use the Vendor ID
> along with the Capability ID when capabilities from multiple vendors
> share the same MCAP.
>=20
> Signed-off-by: Penn <engguopeng@buaa.edu.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817075854.1720=
7-1-engguopeng@buaa.edu.cn?part=3D1

