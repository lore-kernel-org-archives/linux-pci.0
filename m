Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DE219FC;
	Wed,  4 Mar 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634157; cv=none; b=OVGpAyQwpjUf8w6oIWozeIa2JmBlqDYuVrCJbg0uZuxmtumL1VW88krdMg0LLnnRoDJe/b/QButYGdyK7WR0I8SnRamd2elV+n7eyEhFexRseeUd9vYYFuVtIlRE6cfRBmClrvCYZ1q3Rkt1yzbKY41xqwyaaATOoVP1qm0yJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634157; c=relaxed/simple;
	bh=XKm6moUyJlXTOOVZmPNeLBVPA2JMRFGrzzFR2xdojII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzjo6ePN7xdBLBamaxKTWKVKeO5tD7vocGYp1Pg/GqNbW+8f0nGO1GFMknkVnFD8eQDLx9O3yQunNy137NkYuuOuq+lqiHcZShRjVb+ZUNFFMV97AQqZsV324u+e7pYhYT5nKYH3zOjLOgO4d6tVK+62LsYQK2gzeFl5wLyJRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icj4syoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icj4syoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDCC4CEF7;
	Wed,  4 Mar 2026 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634156;
	bh=XKm6moUyJlXTOOVZmPNeLBVPA2JMRFGrzzFR2xdojII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Icj4syoo9HIw5PdWpFz83ztd/Ejz3d/63vXqNdecYSQuq6dV5ZLsI9B1IgU3ECLCx
	 Z0Ii2xnYl3585A7+ZmDnSniEuzEZ51yazRESvS+OWetHv1y+X3xQm6b3Zfj2ns6ipC
	 m85blEzI12GXzVcRGR6jmBsYcJZhESBKwG8VGF9/fbpCKwQ4Z2y0fctvdcEh4UaJkW
	 oVRRd2zN2BGNhBBch35/hTT8St+5vnnxtifDOG3Zgj/yHO+rYXTgbU2m/rptfetO9f
	 7w0xFp6mE/XoZP0IZX6Low9M8aWC8oqS0uj1Go7P3MTzZOIeJATPB9t9j6nV/FEUcL
	 PRmEHIMbbCeGg==
Date: Wed, 4 Mar 2026 19:52:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, cassel@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 0/4] PCI: Add DOE support for endpoint
Message-ID: <26wdt7pasned57ghi6jxgei2ho5akhmlwpycihygd77j5hwne3@tponymt2vudp>
References: <20260213123603.420941-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213123603.420941-1-a-garg7@ti.com>

On Fri, Feb 13, 2026 at 06:05:59PM +0530, Aksh Garg wrote:
> This patch series introduces the framework for supporting the Data
> Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
> to the documentation added in patch 1 for details on the feature and
> implementation architecture.
> 
> The implementation provides a common framework for all PCIe endpoint
> controllers, not specific to any particular SoC vendor.
> 
> Posting this as an RFC patch series to get feedback on the design and
> implementation.
> 

Just left some comments inline. In the next non-RFC version, please post the
EPC and handler changes as well.

It is OK if you can post them separately so that we can merge the common bits
first.

- Mani

> Aksh Garg (4):
>   PCI: Add documentation for DOE endpoint support
>   PCI/DOE: Move common definitions to the header file
>   PCI/DOE: Add DOE mailbox support for endpoint functions
>   PCI: Document APIs for endpoint DOE implementation
> 
>  Documentation/PCI/index.rst      |   1 +
>  Documentation/PCI/pci-doe-ep.rst | 297 ++++++++++++++
>  drivers/pci/Kconfig              |  14 +
>  drivers/pci/Makefile             |   1 +
>  drivers/pci/doe-ep.c             | 671 +++++++++++++++++++++++++++++++
>  drivers/pci/doe.c                |  11 -
>  include/linux/pci-doe.h          | 107 ++++-
>  include/linux/pci-epc.h          |   4 +
>  8 files changed, 1090 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/PCI/pci-doe-ep.rst
>  create mode 100644 drivers/pci/doe-ep.c
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
