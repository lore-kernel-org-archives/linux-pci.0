Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30C3B3C13
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744193; cv=none; b=RCOb1pWZegCeUdIOfWGt8ZRkWJZ7ErqdGUfMzLgZv663JtytQVxbDqYAE3Ii5og88iDxG/g1PRjPQOv0hE8+rjPvbM5xM1GMWIvev8lxomlrPchmsV5XrywE6GBs9OIW8Cf1Uh1sKiCcjbfHRkA7hqnegOEsUK+fyIbMJzSOckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744193; c=relaxed/simple;
	bh=096e0eJY2o56uP4yEhYm2vpgTaKrR3TF6VWbzp4jr2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F8EBticXDW7iOo3C8f6I4ak55WIHOUxC6lf3orPe5OblyoQ8V+EWMp/Zo6biVcs7OyKpEGGd33Q6q8MNo9WBZd+zbGEm8+zPzGXL57rESQBUDHc9MzNt9jNTXsbeyzpD3eFfEviMBKEMkitCNtIYePwiqz4wnR4ddHr+GbPgRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk+x0wtA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk+x0wtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7811F000FF;
	Fri, 18 Sep 2026 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744185;
	bh=096e0eJY2o56uP4yEhYm2vpgTaKrR3TF6VWbzp4jr2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk+x0wtARdk6atl04NZe2npN+1EDGKS2T4m2AZC3O2bEZ5HP1CFroiekhlZSgPk3B
	 0aFHak42iWTpJe7LjeCvjpTlqy11MYMTMelk8HKEr0R2O5q6k4h/stxGZ4xUxrj55B
	 8plpt4BpFw2UQDgEgDipiw4MZsqXESl9Lg09my5aiaSSeYKXFQ96kd1WfAoClJ5433
	 wcAya+fKdQlt8x9R0ZryO0VRaw7AomL5VV4nrJcVQDywz6tL5701n6Qew0GTj8PTWS
	 9kzz5wtLuH9fATSRajgzYbGwOz29TntdMaTZMg0Ivn04YmXnq/+C3wadGBtT8szUEy
	 RdhhHcZ2iCCXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] PCI/FLIT: Add trace event for flit errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-9-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-9-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:09:44 +0000
Message-Id: <20260918150945.6E7811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Emit a trace event for each flit error logged from the Flit Error Log.
> The event carries both Error Log registers.
>=20
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D8

