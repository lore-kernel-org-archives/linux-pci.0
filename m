Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538293D9023;
	Thu, 14 May 2026 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746383; cv=none; b=dKltkdZvkPXg7WSmkfOBpG7bKQPgwoR+oCs1UKzEj01aqSrU011IKaKRGcI77NIUZYVTD3PsTZpjgMrGLiGoOtWtLY8lIM/FMZjljJFggc99r1VWULUi7SkgcfXWEAE02Gbj1ex99rR1KiKPIOf1TJOLA13wkN7TjkkDuylcjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746383; c=relaxed/simple;
	bh=0FaoiUoXT987e1DSGb+y8srTS7Rpy0QVcgiD2b+Qq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyH+80ppiBvzfBM+QJarAuec1oqVM3IMVQjj0zdmI4tFEOuSAMRzAPX1OxfsRAm+sNWetJAmCzXX3W42SbOOJnYxWorNANis99UjpEqe5w7Qmn8OktXRrfcKBZQrFnHBUSrpUaXNdz1IkwRlCyAS0aGOBtRvDkWOfR8ymae4F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcDhzFcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcDhzFcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51FC2BCB7;
	Thu, 14 May 2026 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778746382;
	bh=0FaoiUoXT987e1DSGb+y8srTS7Rpy0QVcgiD2b+Qq7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcDhzFcqJVdkU9IiBOB6T8yUdp8ChsZOkYMuWKzMKTVBEyr3JIuOXkoJn84riwsHR
	 N7wAH68F+Smii6qDQAawFgOmCoes/IYcqkkEgwBwgE1x/RZWQMC3x+96RiYt4PmGo0
	 X3q29uvrzntFYaCtM2uCUkvewSH3/N9HrwfxACoa6rD40JcJ5a+mAHkmiLzRqX5CtP
	 toMLjWnR6uVMcxIdrpGmgl17fotFjVdVE1DZP00tFgAcPEtpIgYXH/c3F1n8NaTl1/
	 NytfTxd1ABXxMilEUZ6GxDQ2VRKXqZ+8JUj/J2p30vo3nyZ8l92oU0CuNfMx9Y2is4
	 vtEup0/IGlfeQ==
Date: Thu, 14 May 2026 13:42:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org, 
	skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, alistair@alistair23.me, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v3 0/4] PCI: Add DOE support for endpoint
Message-ID: <bf3jf3vdrzclj5a3r7hmq2z4ghmub5ksrfr3ggumya4szl2vil@o5kpykemzt66>
References: <20260427051725.223704-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427051725.223704-1-a-garg7@ti.com>

On Mon, Apr 27, 2026 at 10:47:21AM +0530, Aksh Garg wrote:
> This patch series introduces the framework for supporting the Data
> Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
> to the documentation added in patch 4 for details on the feature and
> implementation architecture.
> 
> The implementation provides a common framework for all PCIe endpoint
> controllers, not specific to any particular SoC vendor.
> 
> This patch series is the non-RFC version of the RFC series at 
> https://lore.kernel.org/all/20260213123603.420941-1-a-garg7@ti.com/
> 
> The changes since v1 are documented in the respective patch description.
> 

Thanks for the work! I left some comments, but the series look good from the
initial look. Once you add the callers as I suggested, I'll do a more thorough
review.

- Mani

> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
> 
> v2: https://lore.kernel.org/all/20260401073022.215805-1-a-garg7@ti.com/
> 
> Aksh Garg (4):
>   PCI/DOE: Move common definitions to the header file
>   PCI: endpoint: Add DOE mailbox support for endpoint functions
>   PCI: endpoint: Add API for DOE initialization and setup in EPC core
>   Documentation: PCI: Add documentation for DOE endpoint support
> 
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-endpoint-doe.rst         | 318 ++++++++++
>  drivers/pci/doe.c                             |  11 -
>  drivers/pci/endpoint/Kconfig                  |  14 +
>  drivers/pci/endpoint/Makefile                 |   1 +
>  drivers/pci/endpoint/pci-ep-doe.c             | 552 ++++++++++++++++++
>  drivers/pci/endpoint/pci-epc-core.c           |  71 +++
>  drivers/pci/pci.h                             |  47 ++
>  include/linux/pci-doe.h                       |   8 +
>  include/linux/pci-epc.h                       |  24 +
>  10 files changed, 1036 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
>  create mode 100644 drivers/pci/endpoint/pci-ep-doe.c
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
