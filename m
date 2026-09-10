Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C03AAF68;
	Thu, 10 Sep 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024837; cv=none; b=p+W5HgkedMo+BV+CkJ2+uTDi1w50K5RLU6myNcIK6XmuYG++bcNMNrk5iJSWnz9eGZlLWNl3c54W8ACZgNR47jxDA+IfteCdXu6uts4MF2KdDRg/6j7O/D9qMcq+5bhFcX4m46UtzPS94V+Vx46peVMQCp46YDHUaLs23Jl92Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024837; c=relaxed/simple;
	bh=TZiq4RA1LHWp0Wl4dlNS0ZWnn5bfDpWVyGo8wIHG+vI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQ8GxIRkxJIkP3BVKy+JnoJZm+5hVXPT8B5eegO8drY089PO98tfkLX5H0ayD6J8YWFEZs/7frDLcbJlHjnnupI/qfkIrzdqIIilBB9UvnHGzqgdp8oN9bJB3qCFrhuCR3cM2gsnJLivzCT+RQZyhm+3UayJbXT4uJ6Idu+RAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO73ax9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO73ax9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98BD1F000FF;
	Thu, 10 Sep 2026 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024836;
	bh=TZiq4RA1LHWp0Wl4dlNS0ZWnn5bfDpWVyGo8wIHG+vI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gO73ax9bN7kMKF/wbTKmQevoInnhNizH9ZPeAwNii+FqBpNCocNC5tEV4TSVksws9
	 tOuYpelvaReQrkOd5wPNa7zebMVdmJ36dC5KF3sxR5VoMoYL+pM/8YY14upGPhffCm
	 1DOsNXsP4EX6fDoZwzo1UByVwObb1s3MgjSC1gr0JscRVmGesfiIVEQs/ouLu59K6F
	 sp+hlsRZ0ueKQh+2+nhRBtKDP28CpJEXsfcBC8QTDQ3s653Jepbpct79zY7taoXSy1
	 4yBN4Vsex9/99RI+qiMyfuHFA4e89WZHansDBMr/ITlrdoQ67CSWyfcXn3o4CgibtJ
	 HCNSkbCPWytBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/12] Documentation/ABI: Document CXL Reset PCI
 reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-12-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:20:35 +0000
Message-Id: <20260910072035.B98BD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices
> and its reset-safety contract. Describe generic PCI driver quiescing,
> exclusive HDM range reservation, cache and IOMMU handling, function-scope
> restrictions, and state restoration. Clarify that the method does not
> offline memory or revoke mappings, and that it requests CXL Reset Memory
> Clear.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D11

