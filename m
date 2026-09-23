Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2A57ED92;
	Wed, 23 Sep 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194799; cv=none; b=hqrBmXjMIuaPBPO/t6zIgdabLKgzvQ7MfjlTnL2+JWYDnMFMXwi+sqk30AC+AW7wmgqVL082B2LAtwJ+0Ss6txlGuL26IvPXOpEMT0wH8YpBJwjGB956RO7greVTwnxvdGQO3viAvwLdQ8Gq1ZynmI0QSHjHejsJ6OfX2vXbv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194799; c=relaxed/simple;
	bh=cOWdmiDvK9Xz6VZY9djRREv4U7WhdxmfvYG+NIXhvJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YS8cnw5peUcPxr9h5ihcmKTWd2ECHmfcKurg0wNLnoX8QFpL1V4EfP1s9GUTP41lGFgmseRMDWGq5idtCw7TPmazywx4DfCTGS2SMkMttxk9PxHpyrls3IJOe2Jm4k4wM7YvsS+5GV469ni2bQoDjbOhowHJHwOwnrchb5jbhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWbG6z4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWbG6z4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C5B1F000FF;
	Wed, 23 Sep 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194792;
	bh=cOWdmiDvK9Xz6VZY9djRREv4U7WhdxmfvYG+NIXhvJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWbG6z4NIlI09jAZVwkweGcldzyCCP8Arw6rPl0bV2Ssv/rijUK5wU0oGIq1rQH9k
	 WY3bmTWSXhwV9R/rDlhiOkQ/Kl1e3cXkgMH+pGLdTFpJ1F9607DawF7uSW1J01hHju
	 ShRwv/mfr7DmJAAbqpDpwugrAiZcdafHtRd+xUg2uNg3hI7+cfk9wWIdRbai09tEQ9
	 /pY7fXZRH16PDP+WC1Bb9AnWZUd0/Lwz4hvSET/gNRsbwC7jbbCKgeTK3MdNhRl7Ah
	 7s4IuTepmVHXgsUX/HWYCL6+y07WgaF3Ai2+3gkekAQYfmQcL+sPxvN6MT69B7QNof
	 AL3UsxZxgcxGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/17] iommu: Pass in gdev's blocked state to
 iommu_deinit_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <4d027aa11387a224e4e7fa2535108104384e2e22.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <4d027aa11387a224e4e7fa2535108104384e2e22.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:19:51 +0000
Message-Id: <20260923201951.D7C5B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> iommu_deinit_device() parks the device on the driver's release_domain and
> passes group->domain to its attach_dev() callback as the old domain. That
> is only correct while the device is still attached to group->domain.
>=20
> A subsequent change keeps a device blocked on group->blocking_domain after
> a failed reset, so the old domain has to follow the device's blocked stat=
e.
> The group_device holding that state is freed by __iommu_group_free_device=
()
> before iommu_deinit_device() runs, so read it at the call site and pass it
> in.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D4

