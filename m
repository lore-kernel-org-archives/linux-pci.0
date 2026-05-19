Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7F39DBF5;
	Tue, 19 May 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234483; cv=none; b=TRiNmStpXzOl7IXsQSO+hqib+fS5V9u1iqbVRn0U/sDtCa0udXu6S26uQ2QgvfoauHLVRMFZQ03nQqAW00uS9fhBtGlo0XBYFKlXJigYjcKstfcfPBT6K4ARc1QMC3ldaocuj2QshxsKLkINJIPuqhuaRofDFgxQOYo2//sa4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234483; c=relaxed/simple;
	bh=JZUl2Vu4zrorNA6MbY6ToYYLKu2eLoy/Sd+ZWX68mhg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gCyYMKXCfRj2Z+3ziXMl1IXA6IRH1lUWPQQeFVqDPsqgDf/Di6G9b0gHmcIgfg9FlJWRFrAXjy343U2LZGCmuP0gNESN8cnhW69b9yM2L80FKiyBUOkZCGfvL/28xbjPqsMfZL/3oiQFBdXJ1jX+NvihKfBDvfGgvjy2zAnMs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo+ASq8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo+ASq8M"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 802651F00894;
	Tue, 19 May 2026 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779234482;
	bh=A3TVSBPvTAzpV2lCqomUSYCy+B+r1WiclbQNPvmeu/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Jo+ASq8MQQkL0btOV+rJ+HkyOcuSKCJ3DLbkOFiSfw2YluJRoDhtsj5UlnYvYPwyl
	 X8uyn4Kd1akU10ybHGTD6IW51YDdieEMFZBWHLgh0WNXNCyEawuolqXlPKiISRSYCw
	 tIKunDq/m+idi6xvgPd3gM1/KiF2oOMXwdwpHyMPNz6LiomcgqhTraZHSbtMjZ3wZb
	 IoVsDI36WfhRVgHTEidmxMu2KiQZHs2TXgpGN7U3onWJ77zlqJWDNh/PHCzU9+xnz6
	 JPS4oSKunk1vihItQbf18owPTLVGyeyRv818f2sFhWze0lq2DYemPQyC9RxGM4E9nl
	 HG6wtL3YANpnQ==
Date: Tue, 19 May 2026 18:48:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260519234801.GA21369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519222335.GK3602937@nvidia.com>

On Tue, May 19, 2026 at 07:23:35PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 02:36:49PM -0500, Bjorn Helgaas wrote:
> > One motivation for putting this in the PCI core was to use the quirk
> > infrastructure, but this series doesn't use any of that.  It doesn't
> > declare any fixups, e.g., DECLARE_PCI_FIXUP_FINAL, and it doesn't
> > update any state cached by the PCI core.
> 
> It works like the acs quirks that are in the quirks file, which are
> also arguably only used by iommu too :)

True, although ACS has a lot more PCI-specific grunge in it, including
all the "pci=config_acs" and "pci=disable_acs_redir" stuff.

> I'm not keen on spreading lists of device ids for PCI quirks to iommu
> files, but it would be OK to move pci_ats_always_on() to
> iommu_ats_always_on() that calls the PCI quirk function.

Yeah, I guess it's fair to collect the device IDs in PCI since this is
about characteristics of the device.

If we leave stuff in drivers/pci/, I would prefer that part of it be
named to be purely informational, i.e., "CXL.cache_enabled" or
something similar that would also cover the NVIDIA devices.

"pci_ats_always_on()" doesn't sound right quite to me because it
presupposes the policy choice that IOMMU is going to make; that PCI
function doesn't actually turn ATS on, and it looks like the question
of enabling ATS depends on how the device is actually *used*.  E.g.,
if Cache_Enable is not set, is ATS required?

That raises the question of whether this is the right test:

  +   if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
  +           return false;
  +
  +   return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;

That just says the device is *capable* of CXL.cache; should it check
whether CXL.cache is *enabled* instead?

Bjorn
