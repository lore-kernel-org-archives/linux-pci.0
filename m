Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1A15B998;
	Tue, 17 Mar 2026 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762447; cv=none; b=J2wsbKqcxIbvkEqbjml2ycqZrQ5JHG3/oDlCGyDgp5DVcMpWtfIkojJhqoPDzNBn7a6OcLloj4HHiSZ7Gfpuwk/UUiXDNBDr1JNsGZa5Aoiunn1PPhFV0/6CMD2a6BGIKgR7VwoPE5xsbvfNtPRXQBHzCJcgdpNkHtE35an8dAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762447; c=relaxed/simple;
	bh=NUeW1KVz34BBMerpBTK4V1Lfy7tFDhaR4Cewl6syojM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nGMIvz3acBASRaU7i71NKAE5NO4Bps0tVjaeCNSRiR+OxKrbryNS+scGE+FDfdPrLidVqBSOC3alEnht7P464HqK/PszijnyJxU8kB4YYHlUMhqFOz9tz0UPBRYQ3+QGRBYZ9CaYX872mh9X653rTz7xgKxySIeQ487Dlg3Mhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEPq3Ri7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEPq3Ri7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A42C4CEF7;
	Tue, 17 Mar 2026 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773762447;
	bh=NUeW1KVz34BBMerpBTK4V1Lfy7tFDhaR4Cewl6syojM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eEPq3Ri7hxvmZ3KaZ6tb7oRoBdU4i7+DggOncj9k/Yg5kJ/YnQdFhXJSopb4++brv
	 wChmzDEKk5M827d8QQbBnn9JdiVT7zcHOoQnluakqXSUpBAW2xVj6XsEiUOdDcsAqQ
	 PTHca8pIrOnkBrQpRFar/8wtcJ4EDHR3lgWdbZJmcCM9S2WdIW3Gr1fjJ/RhvU+Lvi
	 OiHaOjYhnaKhvPjFOaLk9b16Si7NIvFToPRRJUJeAjPSkGunF+YSy+OFHZSBjpuUvk
	 aLkvCgwScyza4dXgEqGvUclkpRW3mm8xdxnlapvfWYk//eghk1JBHqJfIrHRfs891U
	 1h4N8WgRkvxsQ==
Date: Tue, 17 Mar 2026 10:47:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2] cxl/core: Work around CXL Port PM Init failure
 when ACS SV enabled
Message-ID: <20260317154725.GA87339@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311164145.498207-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Mar 11, 2026 at 05:36:47PM +0100, Fabio M. De Francesco wrote:
> Compute Express Link (CXL) Specification Revision 4.0, Version 1.0, Section
> 8.1.5.1 - CXL Port Extension Status, Implementation Note, describes a
> scenario where a CXL downstream port may fail PM initialization:

> +++ b/include/uapi/linux/pci_regs.h
> @@ -1397,4 +1397,8 @@
>  #define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
>  #define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
>  
> +/* CXL 4.0 8.1.5.1: CXL Port Extension Status */
> +#define CXL_DVSEC_PORT_EXT_STATUS 0xA
> +#define CXL_DVSEC_PORT_EXT_STATUS_PM_INIT_COMP_MASK GENMASK(1, 0)

Please pay attention to the surrounding definitions.  This appears to
belong with the PCI_DVSEC_CXL_PORT above and should match the naming,
capitalization, and whitespace of those definitions.

My copy of CXL r4.0, sec 8.1.5.1, shows Port Power Management
Initialization Complete in the 16-bit CXL Port Extension Status at
offset 0Ah as a single bit, not the two bits from "GENMASK(1, 0)", so
I assume this should be "_BITUL(0)" instead.
