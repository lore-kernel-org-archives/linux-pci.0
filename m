Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFF3A874B;
	Fri, 17 Apr 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422499; cv=none; b=LfrjsPMbGC8+rCWifwr2x75A3RbhYtym31UyJxjYRIWwAL3WgEsjjvFr45TIKduDHYo/temQybN+STuSxZZ0UB+UzuQQEJ/lew1v4/GaQRJ3j4GJlUdbTSEdcLbkOYYSN5XhwdAoYNxirg5ElWk/4pUx7FGIdhcdhdmny42KRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422499; c=relaxed/simple;
	bh=L0GTYKccieNMJTwUsBo2lGzUOj3BIShZ21D9v4UZBhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwwqTD+byFQdP3A9G8jeGbFcObycdBGU9jDiTco9Pc9OqZSOlXAVH+NjNeqhoYOzjyb8zeOv3b/5NCMuQGboTzV6V8pDgmpMxjSUAx39kN5JECaYWIjunqJ0BnEkm8pEZ+xyaRi8Pg+9MR/OicoCkYHzFHqnEW7tsUB+ZKCvbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtPgyx4s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtPgyx4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59875C19425;
	Fri, 17 Apr 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422498;
	bh=L0GTYKccieNMJTwUsBo2lGzUOj3BIShZ21D9v4UZBhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtPgyx4sEoslirAFE1xOCCdvIzjXlIjN54E+c8UrNTbbbHeVbnL/3O7TGX2obODny
	 MJy0RbFLJn2cB1Y7/bznD8F6Lmel7w7rY8sRGAMaGrW5reJeqH2pt4DTdOTtUh5JFW
	 +bX/1in7EvNP/3fRBdmr/Nnbqt03Z09y1e8DLfOnXCiTsrsxGW7Qnm2Y7TTcdfrmFl
	 InRRB4TZ8CsrvL5dm4KFtT6uPCtuYzVThV70NnPqP27OMJcIPLoNAXwJvDzdOREY+t
	 CiK8hNtMffvkBGlAxw9Gt7NnHqErYrjGdZ9H/vbdtPN5eutVtkF2M5n2QDq18LGps9
	 3yWIZMCNnEIug==
Date: Fri, 17 Apr 2026 19:41:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 00/23] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260417104136.GA1524638@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
    - https://dashboard.kernelci.org/tree?ts=pci

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
    - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
    - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org

I sadly do not own any Alpha or PowerPC hardware, so when I was testing
these architectures while working on the series, it would be only under
QEMU.

That said, Magnus Lindholm was able to test the series on the Alpha
hardware he owns, see:

  - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com

Lorenzo Pieralisi did some testing reported outside the mailing list (we
talked on IRC), on the platform he had issues before, and while the issues
were more with procfs races, similar to the sysfs ones this series aims to
fix, he didn't notice regressions when having this series applied.

Thank you!

	Krzysztof
