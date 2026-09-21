Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67F49F122
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000501; cv=none; b=KNM6EtSqcPwMPrDV6EX9UzA750OAF799MV9bsI3kfDQVfBD7amiE1NNx/JaHjmRvUIDQHGF+YJPJ/NIzJQodvFHWKoaGUkIKbIRDEt2FjOxnaqhr1fhPQP1HiV2kjUuHJDGwp/KTfD9vRoOO+5VhC9RpZ82+pSkjbNmqYbQUrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000501; c=relaxed/simple;
	bh=OalXOaeNEDp8/OEtxjXoIiXNrzcH2+6pxxzYN7XnaEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZZrgs/mGxnS3PQZYY4w+6CxdN/8DEdOwAC1nibCRIZJz84Lmiz5CVmoz3907fcmD1E5mvoPKaI8N5lL4W6tD8PrrqhbVA3MDMqLpytnzUOavmaLYj6cpR34/2sTV8iyqKc91GFOU14DFqLmvY2lqj0wcKZM7JRlWsbvEdLHNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnfQGCQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnfQGCQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD941F0089B;
	Mon, 21 Sep 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000500;
	bh=OalXOaeNEDp8/OEtxjXoIiXNrzcH2+6pxxzYN7XnaEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KnfQGCQCOIfmHxHgOdn9aTyXXEXAiiAw7Iy3fu23Qh9RoKaReDaAtOzyS0UqoijYc
	 Mpaxp8uhU0bbmfBv/4giEte0ho2o+C3T+lVEks1lvv4vYOqPHHjJNrHbujzp/Mfgjr
	 /hsLjS7Teg7V5iddGDJfXq9va0Y37OYR2vZGaqUNdmw8WkKCnxfuuKGxy5LU6v+IUe
	 HLf7ps0PPkNSVrq0CQAgpAYqlGcTvF4+bjhLX1iqCSGNiKWEwQv1HjYTFO2JBYgbJz
	 qvaTzyzP+i4fIMiTrfvn5ByCSlkZSExkPpjomN29IbbCOAz2IZUF7OkReS6nDTByyi
	 vexSx6nrcFpMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-3-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-3-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:21:39 +0000
Message-Id: <20260921142139.DFD941F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the VMD CFGBAR initialization code to a new helper
> vmd_configure_cfgbar(). No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D2

