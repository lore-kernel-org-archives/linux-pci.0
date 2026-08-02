Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59B3242AB
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686562; cv=none; b=O/O2ZCih3OHZAvkKSw78rbLLBJCkgqZ1wNjalJOn6YdNPoU9XZVvWuRJC4kHHEkjA5SydMmqJmEvmoHCEvO+sRMCfuqdOJyDu8Z2Cv3LEg527csQxjMlJjGArkhgsRxKjmonsqnONAGwzasqKyUZwFd+yCWL0rrdPhMKAwaN6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686562; c=relaxed/simple;
	bh=nbJvDHfk85lQ6eylBdtuPmzCArdgTh9ZVobOc0Wt2L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYaiZ5QcTHhbmr3wo1k5nCEsRgAY+UM6uykyIWgmd8QjyzyczifkqX8XIkMGgxJ1PzOuxUXHrKqWI3uvVz/Yz0c3Vbt6XCVM5yN7gi+4/2udxbT9zt9BmsZwRsgpGJqgp9bmn+ZVxmQ4mxe8AWC9ftqU++vyqPGOWQqJlsUXlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXzAyxpm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXzAyxpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA51F000E9;
	Sun,  2 Aug 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785686559;
	bh=on+conbOYYmUloARQwTTppupeBpF3BN0yfJ22wTVq9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXzAyxpmJ6RxaqLjwDuCaHnDzR4rs0cq797XDUmEb8ccK3BwZoyfpH97wLMATbSov
	 rbLOJjphIFu0bwe66yW5hsBfb4uTvPFAW8wAlve7J5Ee8lPflI1B23DwUDTJuHsPwz
	 /o5LK8eyCqEvr5uATAhdFJ3FbKl4vhzk15uWgXbTWRM++Zd5432mPy48yR6QkQX/0n
	 d7KYxgoO8ZbDIlVgiycG8+xdJEFQz8fdbSnrF5Z7nLixcEbsAVABqGOsQIFnSuMQ6I
	 Q7noXbenlUwiT54mnOEviK2MARQ+2EHAN0QFkpai81gpjuMJRPHL6C+LHPcxMtCKN/
	 NnMX/gi2/0Grw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] PCI/P2PDMA: Add KUnit tests for ACS routing
 decisions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-11-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-11-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:02:38 +0000
Message-Id: <20260802160239.5EEA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Add a KUnit suite exercising the ACS peer-to-peer routing logic:
>=20
>   - pci_acs_p2pdma_decision(): the full PCIe table 6-11 truth table,
>     including the Egress Control Vector branches (bit set/clear, with and
>     without Request Redirect and Completion Redirect) that require a
>     switch implementing the Egress Control Vector and so cannot be
>     reached on commonly available hardware.
>=20
>   - pci_acs_egress_port_valid(): the vector-size boundary, including the
>     "size 0 encodes 256 bits" case.
>=20
>   - pci_acs_egress_ctrl_set(): driven through a fake pci_ops returning
>     canned config space, covering target Port Number extraction from
> [ ... ]
>=20
> ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 \
>     --kunitconfig=3D/tmp/pci-acs.kunitconfig --jobs=3D$(nproc) pci_acs
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D11

