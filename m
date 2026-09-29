Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5F3B7B91
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654367; cv=none; b=bTxZ99rH0M2acyMTcMApksnTDe7PsBSnXqvSg+PkMXngAmmfmwismsJfpanB2rw09RrFSvPeGfm253beggYQ8yuGe/emhdno5my4KHyJBX5Y+oyRVNM6QUjgpKQbLJTUdaZDUiIArbNYfkn62rXuuK5N901xCgSXP0e0LxSE0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654367; c=relaxed/simple;
	bh=CjNITC6lJuiIdTDxfvlGzq7sXxarLUpVVbAiUT61N3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIk7C77Yb/v8tAEYAjKVC9Pv6Sm6S4SeAbYZplkhT8r8AskfACAh2krQ9LgZzOh9CD/9D/VtIVtj9hhbmiUDaJ95GOSlDM4NUQpgt61czEiT3fzm5FEQn4b1NUjCGtHNnEdYNJaaxiVNmMaMWOjv8oiz6GF8xT2mKZwnI9xbv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMmjY62Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMmjY62Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C892F1F000FF;
	Tue, 29 Sep 2026 03:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790654366;
	bh=CjNITC6lJuiIdTDxfvlGzq7sXxarLUpVVbAiUT61N3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMmjY62QLWqiuXBCQ0jMRr2FvtjD7WxAezNK1IeAmit+gtN/kSRU9GuSX7ikQL5Ii
	 bhTbgri6UcDUwP4h3kEBwS27AGoshbsi6al5KPEde+SZ3Gkv/zNHTrw9gg9rjbQh8v
	 v2/7sJ9k2jmd26qDRS7D16597Pevpt4ZUG22K45sNgM7CgKxc8NgqZQve7rhTcD6mA
	 vEUS71MI+PxF2HA4hv0AoivKXtLzlvsPG9vGQl0mS8KlvsWvQ/jLtKv78mfvuvWrlP
	 S+0j25h6m6k00HS0n88DVSz5fBgZSHMAhuUSN4lxya9iGgmsE3+WWx/shsVhEdhKpn
	 WMfpB0sCKNM0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/16] iommu/arm-smmu-v3: Refactor
 arm_smmu_setup_irqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-2-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:59:25 +0000
Message-Id: <20260929035925.C892F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> registering interrupt handlers and the other one for enabling interrupt
> generation in the hardware. This refactor helps in re-initialization of
> hardware interrupts as part of a subsequent patch that enables runtime
> power management for the arm-smmu-v3 driver.
>=20
> Additionally, pass a 'resume' flag to arm_smmu_device_reset() to skip
> registering IRQ handlers again during resume. On probe, handlers are
> registered after queues are configured but before enabling translation.
>=20
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D1

