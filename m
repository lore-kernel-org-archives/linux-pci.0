Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0833603D7
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860095; cv=none; b=C3eeczTQ3WeCr90LAHp8Dqy8p24z+gUlU6zrp65rsTtkmUs/7wtXl4ivUVRlJpXu4unnWu9KuVa5KNHpoMMLiiVm85gzSP4DtYiWpvDJOB1dIUWnFfc2jLRhc7uRfxq9t6i52Yh/ytPJUKXKxmV7LdAhrgYLqroUqVJGo9PY8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860095; c=relaxed/simple;
	bh=F0a0TPLADG10myLJUA4HMYXbR/f/67RFzHq4qq6mh8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0LucBCSuRiAKzDz6/rBxc26md8ds2SaKqNmeA7+fhqjUzomVLCvwl2L79bgtXpKP7wLPWvGls6cNiXvE1DvZ+kiJ3tN+0O44kZ4MKB8SWG507xv5pO+bNMwL/611X0F/XWfidQyDtiDZ7IX6Cb1UUsO137o47dlV9P9eJWbnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX43NMtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX43NMtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2253C1F000E9;
	Fri, 19 Jun 2026 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860094;
	bh=1tna02tW+aa3k2iYGVeKM9l5l/uVbE1oUO5Dr6Q2lZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TX43NMtSpd6Bzu65b3btkLSj8KVyhKoo1Tj/t54uTeKC7AOh4KDwswgg0feUZaTAN
	 /Nv5rxcatZ0oGuY2Lq/Q0kakeiFN9/YhpMCcfGnvPSQ1VnOFOomIxYP2ZAEkPNRjWN
	 odKv/Btd8U/93DMybERonNvgl5z/A6tjPK5V1+HCYxnTbviFviMrdvswBwIaGLMrwt
	 x761T+AATWCWI1as4itHr8giAfiQpRs/ocAkD/pETa1JRcVxqIX0upidPllbTm2d2D
	 pj9ZMqOq/bMntbYHAhSC6yK7z3zUNrf4W13vcZYbQ7ZZNdpIVZVgNS5ao8O43jZLQ7
	 1pZTp22xGNyXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 21/25] PCI/sysfs: Add __weak pci_legacy_has_sparse()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-22-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-22-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:08:13 +0000
Message-Id: <20260619090814.2253C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, Alpha's sparse/dense legacy attribute handling is done via
> pci_adjust_legacy_attr(), which updates dynamically allocated attributes
> at runtime.  The upcoming conversion to static attributes needs a way
> to determine sparse support at visibility check time.
>=20
> Add a __weak pci_legacy_has_sparse() that returns false by default.
> Alpha overrides it to check has_sparse() on the bus host controller.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D21

