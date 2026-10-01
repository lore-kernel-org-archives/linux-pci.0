Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC34D2EFA;
	Thu,  1 Oct 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850233; cv=none; b=lsaOIAVl5O+4wobxEKGnzsq6ILUQn5qCIHYc5Ya66OeTWVrwBaDdbpvlbAPMN37WrVCjfXw94jM0+7u+EMZ8aibeCM1J567gq1T4II7ttnD/zlgZ0sLhbuPKgG8cV7IqrzvUOwH7p+WBJjMXBuFYSH2f6LuSG3NTwMw2Mc23yC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850233; c=relaxed/simple;
	bh=lCu2plBwWL0SMjuiafP8Z4r/eVGgIY3Hdi7NhbucqDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhtViRl71C/uwZl/Ehxi/F8B4XEsubrW+eWS0WYRele9YCx0rbXZLSHmCHd2C62w7WLihY4Mv7FxbjtgHV/vIwslmvejQutEsKU3xySMqxnY8OHFP1L15Cd+6nKzCol16jObNvfHYvLN+bo5yUmWYpBNtSR6/AZkSqPuqacVkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVbVXFNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVbVXFNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED19B1F000FF;
	Thu,  1 Oct 2026 10:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850232;
	bh=lCu2plBwWL0SMjuiafP8Z4r/eVGgIY3Hdi7NhbucqDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVbVXFNWS/Ekzb3J9MUev7E1h4wjXYFdhyIUheL8RuCv+TfUx5Wc2Wod+P3C9N62l
	 bXI5rkpMeh6rUc/ZK3JhVeuHrnus6j66WvszC4IerjsCDtw6dnrDflVJvRTXQScKlC
	 puaiC/M7/YEyQCzFfk749MIe/FJpZYR5dka48arprQ7L25/BuOMWH0fq80n4Th6Tvw
	 mB7MQlomBGQD100Hu4DGwNsLuM7bLzIieLKHkYzKvetAEHnjWhuDzoBdZjGcEvi11K
	 WBwcGq9cR0L6JCtBl04v8fKDxo+c3r6xS890J35VmiACix2uAhCZUcmasz64msHIuS
	 AjQStmkqQ3Rfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/16] cxl: Validate and synchronize HDM ranges
 around reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-13-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:23:51 +0000
Message-Id: <20261001102351.ED19B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
>=20
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D12

