Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDF2E4257
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812580; cv=none; b=WTQ6Gerwf6c4G2hKVOgz7se9e5kpaa52zI1ixSvaq6vbSMBDrPD3M/eed6wwI/hbQ3TvRmmjY5laJ6Kv0ARVKwQuROjU5K5wWjrDpeEfyZ6jNvpB62oWYDthjy9gkFnu67TUQtbsvBJCI4Gr/a6KuU7TVyZjt6cqb8vTYp2GWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812580; c=relaxed/simple;
	bh=PFTS8mHfDHAsne66pr0YFt1QlUUFCw3UZfQcS507oBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQB+HSz0/2y55nzkg6sJ+hzEPOS4AdfFbjBqouRy0Olvc4qvHue2joF5rQmHZj3WKO/MmRqaBBb3pvDCShIT4GbjAw/THYVLRM/8RiMPr4SuMtjF6yI/qa1ttTXQWn8Lv2TFjF5k3NCmxNOklzemetus773v+zyHsumAHQh64ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfPqh0ew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfPqh0ew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338551F00A3A;
	Mon,  7 Sep 2026 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812579;
	bh=PFTS8mHfDHAsne66pr0YFt1QlUUFCw3UZfQcS507oBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EfPqh0ewyhJattMUhxTbC+YfbprgN+GmZCUy8VwuTUz+JhpKcN+kbD1OPtzEgZnH4
	 EYSbaLj6yqgPFVjZ6qX8Yrbk+ylCrxNc4gN697jZzG+IYzTuoPVEguiWI0mfsK2FV9
	 nEOPDRjjjP+h3ywup7eQGShYdlzW+mBACc4zZ6iE4b0GQg/NVkcqOEfgprRowqavEs
	 Y8JhJVxvSCpa8nG02WCiOzkj0GyZhLp8M28ydlZY3MVFp8cY3n+pB45CLCTpndo9+P
	 EDULYW31lhoX+h2yRqHwcqOi1B4btacB2UfSZbcYIfv15sjfvIpUgm57cHdtBh7U5u
	 +DIyzLXcxxNAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirks for Broadcom BCM57412/57416 NICs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Chan" <michael.chan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260907202020.2525301-1-michael.chan@broadcom.com>
References: <20260907202020.2525301-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:22:58 +0000
Message-Id: <20260907202259.338551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
>=20
> The older Broadcom BCM57412/57416 NICs may be multi-function devices.
> While they don't advertise ACS capabilities, peer-to-peer transactions
> are not possible between the individual functions. So it is ok to treat
> them as fully isolated.
>=20
> Add ACS quirks for these 2 devices so the functions can be in
> independent IOMMU groups and attached individually to userspace
> applications using VFIO.
>=20
> Signed-off-by: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907202020.2525=
301-1-michael.chan@broadcom.com?part=3D1

