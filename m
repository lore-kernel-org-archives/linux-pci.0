Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3F443AB4
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148715; cv=none; b=upydLDg3o9NxIAr9ELLi00TTOpCVn5Yv7fjyePPgNjZ6eDGa4sqhjM0hcjlimKiYtyv4M80ZhMaLHzi9Z+sIm7V8ELPfnk4sBnGRzklScDcg8YKGhOBFUn8XTj9NWSYK34Xv4fcWlScLWgDxTB/QbOn/kk9VMID6zR4nhw6NBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148715; c=relaxed/simple;
	bh=I/OwHpwoxg8zKrMqUjfL0iBlDi6Ob4Njvmx2F2GBaVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tVj+m0yqiDwU3nRGqvGpzza/WH/gQxFAoPqU3JeAHztFnMWbxwKrJfBMPQ1i0686InY7iWDBQfVnd49Nnk3phB0suZHdqrOddKkTzlpIFu1i+vUwDuzA434m7Vgiw10ysobyHeHvlC8SFZCuCDOPZpOiObSvHJKXq6UQOeM76xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0AZgTBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0AZgTBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D801F000FF;
	Wed, 23 Sep 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148714;
	bh=I/OwHpwoxg8zKrMqUjfL0iBlDi6Ob4Njvmx2F2GBaVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a0AZgTBUVwTZzfooEqlcj8rgwdcVtM75rVFgL2BMgrxQ/QOXOIaXO1pMDOJS72MXv
	 6PqSx/VtvwvhFHtkqDAfahTSWJSGlIj7iU7wio8+7Jw0ZQuQxDFRYhw/hNmeRqDqtO
	 LXx7BtexSDwTn7y7xYwe+PM6FWLTri/fMDqt8oCaZIgl+9vCu9MWZgBNQtMhR5bmXi
	 dzaEK4+1ykSE153Bi2/myA3afyOWE/CSOz4r1ceuQHNaCBreR2NXgSZS7bHS2Jge02
	 SfMdQxUl2Wg9nfL2pnLTs/NU5U/IrjsIloUcx2K/mhxjCCqqaeeOcnhQaojOJI7AcE
	 1KHmvFN3sJm7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] PCI: tegra194: Use FIELD_*() for register fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923071706.1134320-3-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <20260923071706.1134320-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:31:53 +0000
Message-Id: <20260923073154.24D801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Several Tegra194 APPL and DesignWare register fields are programmed
> with open-coded shifts, which makes the register programming more
> verbose than necessary.
>=20
> Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> sites where values are shifted into fields. The LTSSM state constants
> are converted from pre-shifted register values to unshifted field
> values for FIELD_GET().
>=20
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvid=
ia.com
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923071706.1134=
320-1-mmaddireddy@nvidia.com?part=3D2

