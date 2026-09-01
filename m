Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A8274658
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223444; cv=none; b=NQr8HVCt8ofWGFT4lIJ6AqsJ8yAe7yNFVHZPbdCjeYg2oIiVWhF14MHCsD8lqNM81plaBDbhz1uolIDLbzsOfIrm47DoWxUgaHVV3XOTbls1eROzhlZ3l9ElgxnFRakjRtsHY91Peq9HiryMEsFu3Q8EVbQaQncdpiFcjYtiiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223444; c=relaxed/simple;
	bh=FjDAEzXegAe+2ca8a5UumoYqDWf/4OIS6l/uXAVWRCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqZrR5McXSgumNqz2pUag8XHpofQX6p+GV/K7ich/7Z9Y9f3D7fHt25PqhuuIDzWowemiCth8RVA81aah5ZJfvCICa5spo7UUX2/PVF5w3QEWvKGM4HglwExuAij+1G36jBpLWzImZRSU4RIxU9jcnNq0SLTM5GruZrxRWaceP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfn/IBr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfn/IBr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705A1F000E9;
	Tue,  1 Sep 2026 00:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223442;
	bh=FjDAEzXegAe+2ca8a5UumoYqDWf/4OIS6l/uXAVWRCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yfn/IBr4QrGXbsmbWSRqBNfnzhLZnS+SsC2vWmUY8hcdqURlbj83fDYoTVc2XT9ev
	 vFVTawkgMlIgzTkJLdYsVJWkcfDJ8/YeYTLBTuJMqJ2KLsCfKUMLv5wzty8Jk50V70
	 J9geLqZqlFjFKSHWJghGIebWt1bU5mf2wLiRWY7dbx1yS6CvgFzht7qX0Q83OQEtow
	 8g2Y2K+U62n4iCw7DvrT/E/BuRZmI7mZPwRqOg1niKEMROrPy3Cc8/9Dw6/n0pi7Qj
	 Al6LS1LadpfFnwz2vZuGQMFTSH+LlGhMPQ236OFVjlEZqgrYuk/Ijckt21IoU4nLSl
	 cjUtD/KaT6FyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] PCI/ATS: Export pci_enable_pri() and
 pci_reset_pri()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8076427d234c9a4dab4ddf3da3737c61d02c1230.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8076427d234c9a4dab4ddf3da3737c61d02c1230.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:44:01 +0000
Message-Id: <20260901004402.7705A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>=20
> Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
> tristate, can use them from its probe path when built as a module.
>=20
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philipp=
e@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale or already-exported APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D12

