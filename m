Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90B566C73
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931382; cv=none; b=tX7BRT5X2G9IEzCcE6Xqi13BUA+pzDwEQgJEFUc9oR7zdPWUx7rclwx3RROPcoOLOheEyUeKyJOH/hAdmyi/nSMwO2K/q9tfOXMgdh8zFat5O6hFMrdvEJPumq972muMRES0LQtMrhdp3O0fx+ghw6KaW4Po5l/CGcsQzYequ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931382; c=relaxed/simple;
	bh=gptGc7sOkGTcT6HunFvwnJrq8BSXKvm11lMTMWp5BvY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b2n552ceUaDx2sWhVfUylVi+xzxu2ic8KymrcEvm+aJkE4g6FVrRjtzGngjJsVAC1kJxdeLUyufgJp6cWhoTL882AzF74Dzo4LQQZna0EyxByMD3Zmjkb4mDijn1rPtbR8Rn31IbiuZJ/BrphV6hxsHgu3Db36uwtqZDQRIU6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTvGMh6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTvGMh6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71891F000FF;
	Tue, 13 Oct 2026 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931375;
	bh=gptGc7sOkGTcT6HunFvwnJrq8BSXKvm11lMTMWp5BvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTvGMh6tn6QH8vKo3jnommCJ6VdU5LfkBd1yDTDLrejaH/k9PvmfxgmqeEI61UnDq
	 StQzUjlIxHLwpShBDC0Cq8hIpp+voqWPlVZy0+NP9DtUw3217qqJxk8ebcw99Sb2MA
	 +NNXqPxQoEJG+/8rnwY2ZrrmdajjjPErW4Rp9InrV7HsePqDG2O3gHT3qeQkWPxTb4
	 A/R0ocnh1ZHcoNdLPFm2eoiiWRSQEuOpmnH9M6jrH4W0QHDqm8TEA39TUzlP4DV8Kw
	 a2UwYtdkOFwl/DalqpGAQkHfP5YAM2AAQDThWn+hrW7aZa42ya7n+8bKeERWdEzyIy
	 GRX7xXTzrKsIQ==
Message-ID: <sashiko-outbox-170592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013223543.395054-3-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
 <20261013223543.395054-3-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:42:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Keith Busch <kbusch@kernel.org>
>=20
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI continue using their own irq_mask().
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223543.3950=
54-1-kbusch@meta.com?part=3D2

