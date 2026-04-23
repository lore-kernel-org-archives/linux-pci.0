Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DA3803C2;
	Thu, 23 Apr 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964922; cv=none; b=InsKoBWrOzliFRQiFQYasufkwe3OCsfLH4+d73nYlVPMa5lMSodSIGrj6rCaon8pBw5oV7NUckgHLHu1ml0oZjL2kdY3uyr7yd73YdVrFR+mLS/Sx1uRUMLkgTOn1uKkiorlZqherBglACoySGuQjMc1Rz3P0eII3q4XCkUZwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964922; c=relaxed/simple;
	bh=SNU2KfdHTvXAdhx8qf4H667RRK7ygXXE7sjFFzewxXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc0MfO7JTWwebX0GHCTbIeGGA0fzH5dC/5dgen5b8nyuKVmd4xeLku39Y2VxUOom0rgA+RdxyxWqbRbZqQ+QaN0keRd2Kd8P/SVZBqQQMS8OI3RkoggCRFpI+4+3fWbgdfv0ing3zrdtM9EdbobTX9A7Yh7WgmqHendPH4MPEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7/AC6AI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7/AC6AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40B4C2BCAF;
	Thu, 23 Apr 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776964922;
	bh=SNU2KfdHTvXAdhx8qf4H667RRK7ygXXE7sjFFzewxXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7/AC6AIR7jjOvYgpmxQ0DKFunySWwJULdwUp2Ufz01K5GW6zZV1cd5aFnsRr+Fe0
	 LXs7tEvI27ThOkOmnKiONMRJQd+gCkM8O5uT8qb8RFh99PEBZL0cz09HtTfmyuQsZW
	 i/g/owgfPgdphd28154c6XA97Y3F3Tt18s5v2befc3N+r+DYzlUp/unpkz63762nrw
	 ztFG7hFnPiv8lhJvMJBKfBx4bAwdytZxkKYimmFmInAqcxJP4L1GHY7fVwq0Hx/OB0
	 4B9W++3LEVL13uNi+eUp95pbR+928HRNdJw/xyq2vJxqFUTvqswDZrU+tEwUTMN0yO
	 3Oskuzdo5mW4w==
Date: Fri, 24 Apr 2026 02:22:00 +0900
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
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260423172200.GA2271460@rocinante>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202604231622.DgR0zih3-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/941dd7c3e16840724dc961f10b84e193d13cdb57
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
    - https://dashboard.kernelci.org/tree?ts=pci

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
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
