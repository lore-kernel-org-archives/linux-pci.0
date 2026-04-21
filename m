Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853ED323416;
	Tue, 21 Apr 2026 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797026; cv=none; b=dAo1Shoutuo2Igi1ZBVqYN08LzOMs1VRyVRmha4FJuy6gV7psHwfEoEcmPhnRcwaBgRvRaxXiUYD08iuAesWTMFxahaiHnkKstERXlbPfR8gJ/zn5dVQDVuXWVsI7WFTML7ANXNvnS2rDGndJcXRL9Er1ttUBc2a6KdfbPiMYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797026; c=relaxed/simple;
	bh=BFCiiwYB2BfaBR4mT2g9t7Kw8VFChQxWQ4H/FZPW50M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glSIzKulVNg3AfP5tAWM1vwiRlMVWiQi0I5w+VTUDISMKtaOHAlEGYjqLurp3q7JICUi64qf1KT6a5uCUfFw5Fn2pUfywIw6ohEpEe0gBaXtboOXEsbpysK0kupsPSqcLxpZyJUOPgQGQecpi7YiaWn7LPQHKaQGaKm7wLxJaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJitTr6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJitTr6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69228C2BCB0;
	Tue, 21 Apr 2026 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776797025;
	bh=BFCiiwYB2BfaBR4mT2g9t7Kw8VFChQxWQ4H/FZPW50M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJitTr6ITExrD8mrJxI4gAOrG22qGPHzGF3Q98prdiK9OcWdRTzFPi2Z4y355oNbp
	 M2V6HDlHOM4FTXgdbd5mpp5ypWI7taXeUErXVwTYUGbZyAWwrK5mQi2YPoPMiSbHkD
	 6HAzLufn/FlvD1QDS0rIeYUCA+MLi7lzgsdsFe8kMqF4D0zwy82Tz6fILBvxXa54eN
	 WWmY1oXBcGAxIa4330SI+9lEKMadaxKm1CJd3wzwR80jgllgbMxEEyAd5vw5WwuIMq
	 dpQ531CS5BsdnUWYzAZk/h+xHZbc5JAh5x/JWPr7CayOcQkhkFqy9fJ7YvOUo1q/nl
	 5FTO+oqknr1Sg==
Date: Wed, 22 Apr 2026 03:43:43 +0900
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
Subject: Re: [PATCH v5 13/23] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260421184343.GB1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-14-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416180107.777065-14-kwilczynski@kernel.org>

Hello,

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and pdev->resource[].flags accesses with pci_resource_flags().

Will update the commit message when sending next version, as the
pci_resource_flags() was replaced with the new helpers.

> Also, replace open-coded res->flags type checks with new
> pci_resource_is_mem() and pci_resource_start() helpers.

Thank you!

	Krzysztof
