Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62A49251B
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000354; cv=none; b=uMuqsfnIHqkoS4sFb1slao8N0obgMXHezvsQCDlU64MPZTDkPYQFwq8BvUI79/x27M2Q+DRhB/RTBpul4jv+GxSgS3YpG9xzY+fpB7CLQ+p9/HRdI6z05u1lJCECALOqrlsdUKTikdL3ESiM9JG4ecvBCaZZwXrdFL8clMMUysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000354; c=relaxed/simple;
	bh=6xdZnU+Yhp2Oh8Z+VqHmj4ohrwE260pDNPtIZbfamuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=st6u6/ux7iXrWOf5H9BLekfbh2iwxIlHbkHD7k+Zsm9LZf/tGgOUUGrHcfqtjmUf1weQb3inx2SVFtm4Yf1kTXQ8binK7WwEYu0qw7IkzOJe8HyNvPoPXAZnl0U9K5j8l2Ow0sRBk2E9t3XSQFMY/mqvwGx/xULfNf3o3xbKUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWp5GCrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWp5GCrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80B6C2BCF5;
	Tue,  5 May 2026 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778000353;
	bh=6xdZnU+Yhp2Oh8Z+VqHmj4ohrwE260pDNPtIZbfamuA=;
	h=Date:From:To:Cc:Subject:From;
	b=lWp5GCrW3JWb2KTXk8GkewZIXbiQOoN9OM4FDiDkTD7UFM5f65MW4QOy0nA2d4bEc
	 k2A8am3OVgixZesPeElgVAYMN2BmZekIUIKacMpOkhOVizx/cX7tmbShqul0KJgO/C
	 i6l2qsgx1s3LkmBeJnIjyq2LxU1Q2JFitmC7wjxseJWSZwAq70e2ftFjI9b2Ssa/H5
	 v1Pf0a1Ty/rV3B9K+I1KFoN1V31r+iPg80rMXvCOeaY0jLddItGhsH1r/OIwiGdZxF
	 o5YpujrbgrFD0s6a5KXwagvVDAmM+cPVgqXA1wm9aAEWOkqEQyWsfdD0pdWcBD7XNr
	 IMA4OHlwpYbgQ==
Date: Tue, 5 May 2026 11:59:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>
Cc: linux-pci@vger.kernel.org
Subject: possible issue in mtk_pcie_power_up()
Message-ID: <20260505165912.GA738617@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sashiko noticed this when reviewing another patchset:
https://sashiko.dev/#/patchset/20260430162420.42839-1-18255117159%40163.com
I'm just forwarding to you as an FYI.

  Author: Hans Zhang <18255117159@163.com>
  PCI: mediatek-gen3: Use FIELD_MODIFY()

  This commit replaces open-coded bit manipulation with FIELD_MODIFY() in the
  Mediatek Gen3 PCIe driver. It intends to introduce no functional changes.

  > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
  > index b0accd8285892..f36a616a8b52e 100644
  > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
  > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
  > @@ -494,8 +494,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
  >  	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
  >  	if (pcie->max_link_speed) {
  >  		val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
  > -		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
  > -		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
  > +		FIELD_MODIFY(PCIE_CONF_LINK2_LCR2_LINK_SPEED, &val, pcie->max_link_speed);
  >  		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
  >  	}

  This isn't an issue introduced by this patch, but while reviewing
  the driver I noticed a pre-existing issue in mtk_pcie_power_up() and
  mtk_pcie_en7581_power_up().

  Both functions call pm_runtime_get_sync(dev) without checking its
  return value. If the device fails to resume, the function continues
  execution and accesses hardware registers via readl_relaxed() and
  writel_relaxed().

  Could accessing unclocked registers here cause a synchronous
  external abort and a kernel panic?

  Additionally, pm_runtime_get_sync() increments the device usage
  count even on failure. Since the current error paths do not call
  pm_runtime_put_noidle(), does this leak the PM reference count?

  Would it be better to use pm_runtime_resume_and_get(dev) instead,
  and cleanly abort the initialization on failure?
