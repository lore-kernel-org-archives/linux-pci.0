Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD150AC15
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778473; cv=none; b=eADLRk76J7E1PBfqlMwbXwAtJ1ka2vXQEAV1gUh2YvPMG8pMr7C3tR+MTjlwHqf/LJLoBQF1SoTEGPpRtFi6H+BRnNdvB0ATMLdEIa+wp5q5ca0qsDwRLtVGWdh9+zU0El9PfQlzdKe8x0LZhcwyGDEhqIv2bejcULE94Rm9Cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778473; c=relaxed/simple;
	bh=W1D6UKREPFAm1U51kdxRrdCIXFvBPx+uUvpLgL9Ifc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h94ZeZbQuCjCJx9RDil+gPXEz9iGvYpE/bargjfm4XkRo3NY5sxkvSf38eBucQQ/kaHN9qU0Z44rJH85oganC0EwIscv8hcewUMCqTroIldLRP5elbI/MtaZAYV8uof6XX9v78JV9ciu4D9HgQxgmZL/nM/0+XDmLnWwAPK+lnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsbuNvWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsbuNvWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39AD1F00893;
	Wed, 30 Sep 2026 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778463;
	bh=gaOVi9pwieQX7M5XpN+zibkIqIOJgxXI7nob5snwUqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsbuNvWWjmNG/3EB8R8Jh6M9fKvbjB3WpTOSz8YQxz0Y+b1qTSLPu7365pV2ravLF
	 KI6dMpVALD+rZpaJbROc8hhnRWElmLUFAHcQEIjXjOLeigThpDtJvhRjPQCoLt0qjw
	 3DZTHKVroosHxqVrkglAGDXu1PJGowm49hsypSZUlbBTSWqgbnoi0nJ0lLcWPo5UG1
	 7T6xAGfeps8GsMnnChU8Moc8XegAizczKSv0Ozi2x0k+4OCIVfzq9FgIjP5C8IvwCu
	 ZXsd3ELsImursJguUEvxbmj4FWtL1Slv8gSMxpateMXn9cNEUVUqy1aCGQhzSGjdZV
	 BB2WaFI2TkduQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Do not mistake an absent device for an
 active link
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930141914.6678-4-fbeltranmillalen@gmail.com>
References: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
 <20260930141914.6678-4-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:27:43 +0000
Message-Id: <20260930142743.C39AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a bridge is no longer accessible, its Link Status register reads
> as 0xffff, which has both PCI_EXP_LNKSTA_DLLLA and PCI_EXP_LNKSTA_LT
> set.  The code that waits for the link then takes a dead link for an
> active one:
>=20
>   - pci_bridge_wait_for_secondary_bus(), for ports up to 5 GT/s, decides
>     that the link is up and waits PCIE_RESET_READY_POLL_MS for the device
>     below it;
>=20
>   - pcie_wait_for_link_status(), used for faster ports and by
>     pcie_retrain_link(), reports success at once when waiting for an
>     active link, and times out after PCIE_LINK_RETRAIN_TIMEOUT_MS when
>     waiting for LT to clear.
>=20
> Treat an all-ones read as the device being gone.  All callers of
> pcie_wait_for_link_status() and pcie_retrain_link() treat any non-zero
> return as failure.
>=20
> On a MacBookPro14,3 whose Thunderbolt controller does not come back from
> S3, the downstream ports of the controller are 2.5 GT/s ports that no
> longer answer.  Resume spent about 65 seconds waiting for the xHCI
> controller behind one of them ("not ready 65535ms after resume"); with
> the pci_bridge_wait_for_secondary_bus() change it gives up on that
> controller after about one second.  That machine never reaches
> pcie_wait_for_link_status() in this situation, so that part has not been
> tested.
>=20
> Assisted-by: LLM
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141914.6678=
-1-fbeltranmillalen@gmail.com?part=3D3

