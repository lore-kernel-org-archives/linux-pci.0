Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF83345CB2;
	Tue,  5 May 2026 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017621; cv=none; b=ELFCAEn9oM3jl+9/GK6hP7hxKZr5GdC9y2T/2UbgVkG62eSluVlQV2NaV56WUd7SbJ8efHRJGeXtzlQ0u895DDpJE6oGistPKvXngKCaP7mmu+r1le2yMGhfpAt+r9Eaz6K5EswNikjbHbtMB+8dknjzRCBD+JfLXDZmhNVMiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017621; c=relaxed/simple;
	bh=qsL/iknu6G3liYrZ5EdG82Vz3MNhyz1DjA+tvVEl6k8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a/BWfSdeAQ+jX/S8WIUEBbMoctHkqw6x0/2DVQ3SRjFTbW5j+2WewtZobx3msOco6bcy5/DzNRlGGw3U7sTwACObGOgo/2whzL2dpZOK4z1yxcG06vNIzd3LOy0OoEYJQOMvG8LX5m7idQQCqu+sOwL+16wQqPIY4QtHDKaSXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAIHS+PU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAIHS+PU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31300C2BCB9;
	Tue,  5 May 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017621;
	bh=qsL/iknu6G3liYrZ5EdG82Vz3MNhyz1DjA+tvVEl6k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sAIHS+PU8Ddz+furGMFG37JN1odDxUXDGvcDt7EcU2QTfC5rxzxeAjQzW1qacijlv
	 /xfkxuS/URjUCOQaAZzsw3yE1QzgES/nS8kIen3VpqlJ0G3yD750NGrSolGTbGb5bd
	 G+kUno0CISoAtk4ovFkRS8YLp8OEwItn6Ib3NLqq4z10eF683vNVaci3fen1EPj3Rj
	 USuk12fwHEa8b/ETCxNOTnTssU2O0S1vTMlznx+UTow0FGRc2vFEywIYZsHytoPAr5
	 aRWDZKCkzV6arFeHfF/AZ15kOsjjM2KWvO2GEsJ1I6BaQv/OrM11nK8W+BxsdeezOA
	 GCOMIDs7tketw==
Date: Tue, 5 May 2026 16:46:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260505214659.GA752301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430232202.GA3577346@rocinante>

On Fri, May 01, 2026 at 08:32:30AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > The alternative would be separate llseek callbacks for both the legacy
> > and resource attributes, which we can add if this would be the preference
> > here.
> 
> If we were to do this, then it would be as follows:
> 
>   static loff_t pci_llseek_resource(struct file *filep,
>                                     struct kobject *kobj,
>                                     const struct bin_attribute *attr,
>                                     loff_t offset, int whence)
>   {
>         struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>         int bar = (unsigned long)attr->private;
> 
>         return fixed_size_llseek(filep, offset, whence,
>                                  pci_resource_len(pdev, bar));
>   }
> 
>   static loff_t pci_llseek_resource_legacy(struct file *filep,
> 					   struct kobject *kobj __always_unused,
>                                            const struct bin_attribute *attr,
>                                            loff_t offset, int whence)
>   {
>         return fixed_size_llseek(filep, offset, whence, attr->size);
>   }
> 
> Each callback would be placed within the corresponding #ifdef block, so one
> for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
> legacy attributes, so behind the HAVE_PCI_LEGACY guard.
> 
> Note, the names need to be different, as some architectures offer both
> type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
> and HAVE_PCI_MMAP.
> 
> With this split, we can also drop the __maybe_unused annotation.
> 
> While I wanted to keep the changes to only what was needed for the
> pci_llseek_resource() to cover both type of resources, it would be
> also fine to have two distinct callbacks, too.

Yes, I think this is much more readable than the "if (attr->size)"
check.
