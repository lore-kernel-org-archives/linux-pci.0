Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB63CFF44
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491728; cv=none; b=FNirynUQ38qMmGfjZChJRFjKXEXd/R89zZ9Bz/s4zDVEg09DxySxugnFS+apbT1uKaV34Z6q0RljCSqDslbCjpDSShbt+g5C6yMptlfP59BWNjHO+jiVtjbdrFDIO3oedXb6CXX9vfs+WoWih0zQR1uHGdyj3yz/YAU0ec4hxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491728; c=relaxed/simple;
	bh=Fu7Dyv6K+2eHhEyzFwp0cTv1PE1f1PjBl/K+G2NWBQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdHzYahrKDirkOeGcNPSXulDoOW1VpfA8+A71HQY99vZ9AnvB60FUXIn2RVv7oEI1bM5w3Ab7eEZgZoUkqbhlhycAUby7VwcAxMEl0sA+PtvocPZJPDvOqhEwACt2Ys/n1FNlEppg+pRnkN9FBIR827Eks701i+sWMM+GwbGR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTLV3Ylq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTLV3Ylq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB381F00893;
	Tue, 15 Sep 2026 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491726;
	bh=Fu7Dyv6K+2eHhEyzFwp0cTv1PE1f1PjBl/K+G2NWBQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTLV3YlqDcdSXr7WuPFKKXEA0FJrL1RmnnFlqLJS7XJ4/YmgOvSbvU4fWM6teIfCK
	 6bvGP+higykGoO45r5PaWqMDzo4KilGQb/Z+L96xf6uMRL4Ajz7tZNItq0jIxW+Cns
	 Gukl2UaS7hHEIjaHFe+f2bnm/DoNRIP4Tlxfv6utADr99sHmVyA9DypfJ0PuqAuJXS
	 y7eOt5FoquGO9IWWQX+v2OdNxLSdyovid+2V/ofw47S9NOGw3fYETEVOApDIKCEc8H
	 8jom5SoKx+bvwgIIynw8+2zyjulwvrEhby0fOQoJXb/tmXl0SGDhigGn8Ge9bLIkpA
	 SVyZVTsJcEeIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/15] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <45d72c3be850a5dc29f7695b244ce0da97f97f9e.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <45d72c3be850a5dc29f7695b244ce0da97f97f9e.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:02:05 +0000
Message-Id: <20260915170206.3DB381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Malak Marrid <mmarrid@nvidia.com>
>=20
> To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response=
()
> must issue a CMDQ_OP_PRI_RESP back to the SMMU.
>=20
> Both EVTQ stall events and PRIQ requests reach the IOPF layer with the sa=
me
> IOMMU_FAULT_PAGE_REQ, but these two fault models are mutually exclusive. A
> stalling master holds a transaction until CMDQ_OP_RESUME and has no reason
> to send a page request. A later patch rejects PRI for such a master, so t=
he
> response command can be selected from stall_enabled or pri_enabled.
>=20
> Note that a CMD_PRI_RESP.Resp encodes 0b00 as ResponseFailure (a permanent
> non-paging error), 0b01 as InvalidRequest (page-in unsuccessful), and 0b10
> as Success. So IOMMU_PAGE_RESP_FAILURE maps to PRI_RESP_DENY (0b00) while
> IOMMU_PAGE_RESP_INVALID maps to PRI_RESP_FAIL (0b01), following the codes
> [ ... ]
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D7

