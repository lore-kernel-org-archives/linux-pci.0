Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2583546F0
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759828; cv=none; b=VFktCHGf4uRAP4MqRPsAvt9HxcpPXldvJle3YgfPJGpV3nOrFcW889K/xNKuBoIr9K6U5czBgDDr6R5sAylQa/3vIXVXH0aUV9HkVSIf0EdjAtemVALmTgTvyIGzJtjvbl+LKP0HBkaTpHDjU8QpiX93ly8PtnehYUNwUXeFelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759828; c=relaxed/simple;
	bh=ZVEwG0Kolx0YaebIkTfHeP7DDQ/Q0DmxueMG5df/PPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NNd/BsZ7M8+wFw4g7PHuY3XC4Dp5p01GPFK5HeK7kzVNXUAGT7eCmhAi+GObMJHJuEDvPlBGeNjDVmpg//zc6G6VHENe+Qg0qs9+c18xZZqmyw6jVWIdZt2xp83OgQsBQVxP5nS4oEbPaVe60BAOBU06PPNdKKQa+W4cVyMhJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8xwgVYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8xwgVYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2995E1F000FF;
	Wed, 30 Sep 2026 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759827;
	bh=ZVEwG0Kolx0YaebIkTfHeP7DDQ/Q0DmxueMG5df/PPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8xwgVYUMPAEf0IaglP/ANBwiLjVh7m/kokHewDZHnhJ1DDmVL8M+5pTFkCVBhAEK
	 GSLDsfYhULMRdYx/53bzdls04wBNqNThoMMsuvEFH3I964Zu8lHmRuIDcU8rIAKYHD
	 PM2QXZI+ZOwR9Va119l4P4uO1UCs7c9Izmsa9kD6XWE8a5SFmvbZSWKNXpBkIPxJk3
	 YErjPL8bsbHuV0Ic73gVOdj18Oxs7HTBVZfLqRTCY3SjmaOeH6D9hozdrWz4hLDGgC
	 ovTSimMJPi6/PppPARPNfU5Ug9eFuHRs0Wlm05w4Mdlc31ePVfazz3PSY/E6VuZBzS
	 2mGWSMBDHwLzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: Rename pp->irq_domain to
 pp->msi_irq_domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790734930-217000-3-git-send-email-shawn.lin@rock-chips.com>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
 <1790734930-217000-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:17:06 +0000
Message-Id: <20260930091707.2995E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pp->irq_domain is exclusively the MSI parent irq domain: it is created
> by dw_pcie_allocate_msi_domains() with msi_create_parent_irq_domain()
> and is only used to resolve the MSI child virqs in dw_handle_msi_irq()
> and in the keystone and dra7xx MSI handlers. The name gives no hint
> about that, in the same way dw_pcie_allocate_domains() did not say that
> it was only about MSI.
>=20
> Rename it to pp->msi_irq_domain, matching the previous rename.
>=20
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790734930-217000-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D2

