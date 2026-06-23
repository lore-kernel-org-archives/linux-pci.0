Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A873CF21D;
	Tue, 23 Jun 2026 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205177; cv=none; b=jjR6DV6+yBENOdGHawx2QgaG5UGVGgyNkmne608BlxfzOynwgBTcLbGJJYc/EwYh6ejB2h81f2Rs1r5HKuJnEm+P8nrX0bDQDSNGoTiJFvX5fqJ9+MHtVu/p5yvpmrODRcoG60Z0u9CagmieN/YnLqqOvFajbLP0PALRlG6hetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205177; c=relaxed/simple;
	bh=a2VFf50aNiQHbzc+V2W5h9d1NwSDl/Y1YaN3U0t+z9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bp6/S/h/IvoqJEJ6mHZqJdofbW1rENUNTPGVKSQL1ZRp01oP0vhI1yDyPW5GveGwmpCdvY/S6V+I93j4vsulF9ZQd2gR9xEe7lPe6j/3i1mbzDQAzPRTlt7kw89R+h12OINb/SP5Ipw7prFZ1FLks07Tq5uwH7imemvQv4l68JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7mB7IWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7mB7IWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234581F00A3A;
	Tue, 23 Jun 2026 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205176;
	bh=a2VFf50aNiQHbzc+V2W5h9d1NwSDl/Y1YaN3U0t+z9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7mB7IWDv9p6hxJbS1Pb9d5b8rcyyHHeHWRuKLARqmqYI+hD1mmUSvPuU92Q/mv3r
	 tYOIXV34LOFaKRNSF0m9toIadw5ic1MlumogwhDTJRCki+rafSwVmb7kh7gKIDQuLX
	 /0e0tf+dV/YxxHK3k36CnvTlULrSnaBZZ1AfnqAJnTX6oAkna+KUEzfiCiQ0x0JpIl
	 BpeRlsofNsOJVfXx/gjzswFh3VLuH65wGwqpO1836iv6N5q1eBczf+dunCrm0f4URm
	 pRhNdrwPzwtyGC3DyqWFrHgAY3hP/nJp6Role/wy+HBbwUrTMYlS1gO3iHzm6Ca7Qn
	 pCrRJhZKgBu5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 01/12] PCI/TPH: Fix
 pcie_tph_get_st_table_loc() field extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623085048.51139-2-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:59:35 +0000
Message-Id: <20260623085936.234581F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
>=20
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
>=20
> This doesn't make a difference to mlx5_st_create(), the lone external
> caller, because it only checks for PCI_TPH_LOC_NONE (0), but will be need=
ed
> for callers that check for PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX.
>=20
> Also add tph_cap validation for pcie_tph_get_st_table_loc() to prevent
> invalid PCI configuration space access when TPH is not supported. Add stub
> functions for pcie_tph_get_st_table_size() and pcie_tph_get_st_table_loc()
> when !CONFIG_PCIE_TPH.
>=20
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D1

