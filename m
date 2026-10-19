Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5F47F3C7
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399426; cv=none; b=o9GMLPo8SAYJUIAs/1Jv41KIyV7jdxKB7FuIMSAjIvDFw3H3FLy/JsYddfDZmxaF07YSoQ5FgFruH57a97i69gS+jhXYExTo3kN3TVULJW+GotJQ7Ih63ayYbN/IHl2isaEZ5k31VlprFAqJjXb0dYg0Ex5Uc4FzjxEX6E0U9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399426; c=relaxed/simple;
	bh=n6AN3kvWxhaR8s118RYRWcqwYFsE9/wJd5wVSKMgjps=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=hjQmdNdbiiFAsjFjJm5FEvjCpCdAQ+zhJuplKxYeUnePLrqeHbsc5z/+LORpaijBF3sYFIco9YGMn1BH2eebpDzD237tuQ5RA7xgxsRhoZRp1KNxu+jV/mDCSMK8C6mZh0BCa4YtFg0OQwthXFVkqC4SqdnyhMEBdux/wqdc/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkz+mRwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkz+mRwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22C1F000C5;
	Mon, 19 Oct 2026 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399425;
	bh=n6AN3kvWxhaR8s118RYRWcqwYFsE9/wJd5wVSKMgjps=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mkz+mRwMi+xx3+IwWzB+lGWdS9gOyPqb2fZ8dpcwqD48C1LnJheyPOwERjHHched2
	 RFveRkTEK56+zjldz2nLX+TRWRGv4YbaoPjBjoPl2JudlW5Daf6DmyjJHl0A8ha8+3
	 jLJen2u3vAcSFDmx1IbfQeWG08RL2o6F/Ozj+Hh1lAARAiCSC4RdpEEsMuqF+J2+pS
	 JdRePR+oSsOVPK8BWxj23wQGPUZe5CeHTRlBvkQBe+fiIoV0n619jnjc8lY81B2SCP
	 EZf+o9ARH9uDAjHEyoV5x53VOa3xjbQP3oM8zAzSV2L8Y1IvzrYimxCeG+5l7ERf4j
	 xtwgGL4JhiDvA==
Message-ID: <sashiko-outbox-176829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/13] drm/xe/pf: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-14-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-14-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:43:44 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> xe_pci_sriov_get_vf_pdev() implements its own VF lookup. Replace it with
> pci_iov_get_virtfn(), which also takes the VF's bus number into account.
> Previously, the VF was assumed to be on the PF's bus, which is not always
> true.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D13

