Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F138C42F;
	Fri, 17 Apr 2026 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426554; cv=none; b=kQ3cH1fq5HHaxv075tjD/+XoBIRhVBmgb7h8mbgwrsG4+ByJUI/P31L258cl4fDONykSDuV0WbtMSAvdTFJJKt165iPFTteI982Xd9HF6p3JKapM7WU7tNp04ZjRsk0WBJDHFt7h2D6WqWHpdQopN6kuL752szcbVFAMHzGTx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426554; c=relaxed/simple;
	bh=MI3uioBuwUgxsUjR1l3EmFcjUf9h5BvjSExDwm8I7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxYPq0QVMWrGnEKZdB+514aE9D5EyIqh6OoogJ9lOF+iDcD0vHIf9V+YKakNn2vNZ9QAj+r+kjJU0kSVOtee/G5wulzWDBfdpHRiXdVcC3W7FJZeyLY5UBJGXbiPQxLQjE4SEFBC8dY7mi3obmWcM6aArJL/MHDwYvT+cWcHd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evTmeijV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evTmeijV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95401C2BCB4;
	Fri, 17 Apr 2026 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776426553;
	bh=MI3uioBuwUgxsUjR1l3EmFcjUf9h5BvjSExDwm8I7tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evTmeijVDLEB6aLBYspix6gADC5LjwWgom00t6nqowr4w3aOXLvWeHsMrBUauYm5C
	 gGPAgcQeIUEHgSGU32kGesEYgbQdwwwXXPjqx7JtIeqN/22PeLHYQSCHf406lgGVZr
	 8gnXVj6QtH17T0cjEOXmlBEtq76tN23CEsgj1xYHtdE9lB4Y4DhE9u4UcPur2jR0d1
	 hG0a6P24tp3fZJJNKwyqT2g8Y3+f4QSrrys65VZmZ9KeuQW+xifnjgYlMlNU6YFY3A
	 wHpQq0XxKkzHMrvfxNiw5f97NRIzlp2iMzJTzi98fipcb/ETGn4xaF0LzDOGs3TBZC
	 KMEGe36WA60ow==
Date: Fri, 17 Apr 2026 20:49:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260417114912.GD1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-8-kwilczynski@kernel.org>
 <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com>

Hello,

> > -	/* Expose the PCI resources from this device as files */
> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +	if (!pci_resource_len(pdev, bar))
> > +		return 0;
[...]
> Did you accidently forget to address some of the comments as I thought you 
> were agreeing to changing this to resource_assigned() but I found no 
> resource_assigned() from entire series?

I have not.  Sorry for late reply here.

When testing resource_assigned() as replacement for pci_resource_len(),
none of the resource files would be made visible.

The resource_assigned() checks res->parent, but the static .is_bin_visible
callback runs at device_add() time, called from pci_device_add() during bus
enumeration, so before pci_assign_unassigned_bus_resources() runs and inserts
resources into the resource tree via pci_claim_resource(), etc.

The call sequence in pci_host_probe() is:

  pci_scan_root_bus_bridge()
    pci_scan_child_bus()
      pci_scan_slot()
        pci_scan_single_device()
          pci_scan_device()
            pci_setup_device()
              pci_read_bases()        <- res->start/end set from BARs
          pci_device_add()
            device_add()              <- is_bin_visible() runs here
                                         res->parent still NULL

  pci_assign_unassigned_root_bus_resources()
    pci_claim_resource()
      request_resource_conflict()
        __request_resource()          <- res->parent set here

At that point, the pci_resource_len() would return a non-zero value as
res->start and res->end would already be set, but the res->parent is
still NULL (not yet assigned to tree).

The old dynamic code ran from pci_sysfs_init() as a late_initcall (after
assignment), where resource_assigned() would have worked.

As such, we can't really use resource_assigned() together with static
sysfs attributes, at least not without solving the resources evaluation
order here.

Thank you!

	Krzysztof
