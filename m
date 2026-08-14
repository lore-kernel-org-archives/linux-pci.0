Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D433D669F
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673624; cv=none; b=fw9ASMRzTWFlSeuLCqduBONj+6KxJya4iVPIhpnoGZ/8oqjpR2/TAn6eZ/NX93GmXGRjWVlvEM97gGJuCvtVg0oqxp00Q6z7iRpChS7spfB8TmD7wDTSqtwu7nHuicIR5NBtNU41Sh11ah6DnW/YcOENyX3zTMyvuPXSyuaTx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673624; c=relaxed/simple;
	bh=Th+bZc6ykm8z9284z2jsHTTHG+4K2eBEfFSm7dF+p0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRy0txBK3+L0pJo2g0to5XtjN0EL+npqVL7pVE41lPCVGd9uLtvHbDIaQIfsik7Zpfub+KFiC62NqeMbjAoZqx5uebcfSv9GaJMHvuplkhvNg/cH/rzESUHlZZDsUNlHHjCshmpkVOHI/2P3146DePcKmv8xA4S6uB7WL+trbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTWZasAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTWZasAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAED1F000E9;
	Fri, 14 Aug 2026 02:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673623;
	bh=Th+bZc6ykm8z9284z2jsHTTHG+4K2eBEfFSm7dF+p0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YTWZasAG8+w7p/22IaiHDJspZ9l27DLcUEbKT4EiYpmiRn6ZO4yHTKv3g0SCS7lpO
	 luhosdvP8cm9nbLKnpOa6+MAJy/774hPzOY5kchpibLZSC2NVdBneLAuNEl75kG7K/
	 9+vsXAbAsiir6OEVbrZKb5SKOkhYTLYvjWkhzaRgiEZ7fRsgMh3he1LVMauIMbuDA8
	 ns/8n1VGt8G7JVhlbTQkSsbd00LKDzUUVEe+TnEIN/LmPApnQP/iRnVYBayz5sT+ar
	 tJczZeQWEL7/6KTnR9KgwR096qG83tQwY44JRDB1rApaRpXEt2tKkCcAUunvIVbF1g
	 iVP/FWazYY5Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] iommu/amd: Refactor device probe and capability
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814015647.3370124-2-praan@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:13:42 +0000
Message-Id: <20260814021342.CEAED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Restructure the device probe path to improve readability and prepare for
> cleaner error handling. Refactor check_device() into iommu_lookup_device
> to explicitly validate and return the amd_iommu ptr & devid. Refactor
> iommu_init_device() to return the allocated dev_data. Consolidate all
> PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> iommu_init_device_caps().
>=20
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814015647.3370=
124-1-praan@google.com?part=3D1

