Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195904C8C4A;
	Thu,  1 Oct 2026 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853170; cv=none; b=PiqWRim/n9cd60+OCIMvAzS8FLzep67wosqygI2Px7/w4v/bmTq2IN7LCklgxk+zzfVuXUjuZCsGqskXcaKszb3nySZD3HXxqj6yBPZu23J9jUlxWH6x7+7O53lToQdKq8howL8pWvPZqGuLVF/0ia8pEP6khPspqJhA1vJO6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853170; c=relaxed/simple;
	bh=1Y7GIJIIN6erkMG65iT4byQBoHDcedmiGbYKY/OkRz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KwomxeQbe32Qj7J9a+nWwA/X8VrUviydHT/WaesgU0Dc4baKgIhZ5OI6sFnmbi+TwNuV8g3OY44o+/dt8ttB3s0ZMZzTw2HRQXZXF/GMyAZy0wLXv5CQXDWEdaiy228HvXufB/BGazxNfWevJ7p7rnNP4AkvlbLPd6Ii2cKBk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG1zGD7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG1zGD7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7511F000FF;
	Thu,  1 Oct 2026 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790853168;
	bh=1Y7GIJIIN6erkMG65iT4byQBoHDcedmiGbYKY/OkRz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QG1zGD7AXv6yvQ88T++4BifIJ1qFVtvxiZS54OQCyVXrOp5Di3RFLjKP7frxbgI82
	 S71d5tApmqMOj6FaYIls/1Fn41L7BMU8JXF3eZJcnZQgnYhtvzVYSrUrHJlHxMn8N9
	 GsFzO7YQCGPfs0+dJb34aNQZlbRky4gmfODzgYFo/2mUQAJ+vaRIyuBScGi/GcMLmB
	 aj9NRNKQ7M/ewrTtBte5j96njiWNprn6VYLO76iU3uW0xcyMDmwY7vt+M6yoQhEZ7e
	 baWp4zVq5A1dn3bSJoGdBiaWys5nNpOzSQ99AdYgaHmYxBIu8cfoYymj5iFcozE2fe
	 bq2SxjYoV0J1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 16/16] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-17-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:12:48 +0000
Message-Id: <20261001111248.7A7511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
> control state. Restore the cached state after a successful cxl_bus reset
> while IOMMU exclusion remains active.
>=20
> Restore PCI configuration first so HDM MMIO is accessible, and preserve a
> disabled state if restoration fails.
>=20
> Tested-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D16

