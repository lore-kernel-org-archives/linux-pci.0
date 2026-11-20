Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183026;
	b=c/7dKF4RyT0HyRS+/pFebPVYPwl7PvsXMO9s0+H1jSafTUbzk9UTwKonuBUvI9y+EupB
	 ndiCfQgmC4p1WAAArfs+V09/SA1anPXh+8LDsJLCtoL6dp1mafFq9vNX0DkhWYqwAmMNO
	 yNp2ySGYJMKsVPQSqZLTSVy/s0jsfknIUc4eHf7OUn9mw22EeNzRJKWLz4P+NvdrDxCd3
	 grhGp0dIpNr29z+zMebFNwSjqMtlAk+Zi0hhlz11woBoSJZvn4jeAV/bPf+kN5XjBM+wY
	 FaxIMquNVV6C3vE0DbL9PJVKP2ILSQ49mZOOBtjDM165IvMZHl3mr5craux+uX+Gkew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lvaABbLBz52X+RxifVnreCSyDpaBzO3PfZJZdU0OKwc=;
	b=UGCrFTbM/nmnFY2MVSRc2JTZZnYHMi2UHpnep9c1mjVABwaj/ckYThimcbA8Mkkkn3Bm
	 BRoxk601mYnnm0vzdz/8UQhFIIuC0e0RTdeVn6A04btdYfBuRGTbHn5zgHa9wO4lY3nGt
	 DgCBekMEhJKEs7vYKTGltN8CThn8QjaaMU28WSQ+XuDJoTB1jyPsWcAVTywGWukEHGgO0
	 E396SRLSV9vUZFEAG+cmYDkWJBhq31zcxBUrWDXxdPUUfree88zvqQg7sjvDWLMtJXDfS
	 MK0G159t34BU7ZedjA0Yl+Yk5RDO+btrOupYluGAyGZ6wGFv7rhTvSPlKCr5O6orErQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsDVINQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B572606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsDVINQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EA1F000C4;
	Fri, 20 Nov 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183026;
	bh=lvaABbLBz52X+RxifVnreCSyDpaBzO3PfZJZdU0OKwc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CsDVINQll8RXc9L+9Phprx4RNvCQTxyO3ngG9meCMjYZh9mvh7HSfoRs26u+zson+
	 rmJ6UyuPunWDidmCUMPONOj1bO+J5FsOPXzTK5FE3LBd4Xa9TXXG2Dd3K43Su6iJgb
	 fQY9ee9rm+94Q6QYcg/1f0uOUhiG7oYSxUG7jSDKHdpjJPP3kS9RAagftP6NJ7v5Pa
	 kxks3ZedhFsZM+/4bj2t0CkODkkQWHGO9mmeEYX5uCFD8v2xSUw8sPucTGqsBVh11w
	 mqFoebzKMim+vGH8W70z43sVk9X3NzFrRAy//cs/Snm+22c5KeEyuPGAuMEhqS1l/y
	 hM60CZJXwx5AQ==
Message-ID: <sashiko-outbox-225307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] PCI: ftpci100: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-15-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:57:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The ftpci100 driver attempts to assign bus resources using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be a no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D14

