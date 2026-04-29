Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6B194A6C;
	Wed, 29 Apr 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492257; cv=none; b=my8NNPAzJ8O5fPaDor7cL6CALuHj7w0D4RVEzzpuZperQRA28k0GADsPZaXk+3+Dmqx3HnLPSR54HLkIYQIMB1ma1kzxmTHCw3uK0/T0xTW/+26ex3pDv6j65fPT4HgcHiOWdGckADofAl1SHyJcrGtRcPvePzy3th+9Ut8VTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492257; c=relaxed/simple;
	bh=KV0jOqo91Nc5X7Pf3+Y8ZL1SPzxDfjq7fwMURhV0piM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z/XDaXz3wfxx1gTs5eHM3XFozdKpHsrUdrmwPLWc/YRaI+eznK4NLRJmSp6lhc4CKJqLr7fY5kRvnOE9F9n0WXFbwZuKSqVAIlaZdV5uajb5Z3H6YkJ+mYsBDoZN5tCED8YS6jH4FOsX0T1lShFkubhbzCyBzo2Lq9Ytax2wWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEwvBJq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEwvBJq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F602C19425;
	Wed, 29 Apr 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777492256;
	bh=KV0jOqo91Nc5X7Pf3+Y8ZL1SPzxDfjq7fwMURhV0piM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NEwvBJq7WK44M3W5Zehz9jff7Syq93gIaLa34rIEJ7kqJgreQpIc/bigVkpENOlov
	 f9U7oGNP9EVqK5hok1xeIwscY0arcT+jqEPyVKDDdbfoAKEdUlunICYRCNFxhtJRvq
	 HAaSrXYtgB11Hhix5he+GW0cB3lS7oMpNJdcm/t2LTGeL4t7+otLTbxUpGr7FJCAt7
	 Iz2bhvjeKsj6Tx0fPPh2grltl4vPcYLHHm+hecuJ84O2oDI30VaXgfdVM/OnhcJQt+
	 /3Z7K8IBXmGIHP3Wlr0Cuw0gLXdJdihkesJx3urvU8wKPCLiIT0+tlfmqfn3uyO9Gf
	 4jQDfKAfRS8gw==
Date: Wed, 29 Apr 2026 14:50:55 -0500
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
Message-ID: <20260429195055.GA312811@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422161407.118748-5-kwilczynski@kernel.org>

On Wed, Apr 22, 2026 at 04:13:47PM +0000, Krzysztof Wilczyński wrote:
> Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
> so the default generic_file_llseek() would consult iomem_inode for the
> file size, which knows nothing about the attribute.  That is why this
> custom llseek callback exists.
> 
> Currently, the legacy and resource attributes have .size set at creation
> time, as such, using the attr->size is sufficient.  However, the upcoming
> static resource attributes will have .size == 0 set, since they are const,
> and the .bin_size callback will be used to provide the real size to kernfs
> instead.
> 
> Thus, update pci_llseek_resource() to derive the file size from the
> BAR using pci_resource_len() instead of reading the attr->size directly.
> 
> The custom pci_llseek_resource() helper has been added in commit
> 24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
> entries").
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6783c6168445..73a9ae9d289b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
>   */
>  static __maybe_unused loff_t
>  pci_llseek_resource(struct file *filep,
> -		    struct kobject *kobj __always_unused,
> +		    struct kobject *kobj,
>  		    const struct bin_attribute *attr,
>  		    loff_t offset, int whence)
>  {
> -	return fixed_size_llseek(filep, offset, whence, attr->size);
> +	struct pci_dev *pdev;
> +	int bar;
> +
> +	if (attr->size)
> +		return fixed_size_llseek(filep, offset, whence, attr->size);
> +
> +	pdev = to_pci_dev(kobj_to_dev(kobj));
> +	bar = (unsigned long)attr->private;
> +
> +	return fixed_size_llseek(filep, offset, whence,
> +				 pci_resource_len(pdev, bar));

Is there a case where using "attr->size" is better than using
"pci_resource_len(pdev, bar)"?

In other words, would the following be equivalent?

  pci_llseek_resource(...)
  {
    ...
    pdev = to_pci_dev(kobj_to_dev(kobj));
    bar = (unsigned long)attr->private;

    return fixed_size_llseek(filep, offset, whence,
                             pci_resource_len(pdev, bar));
  }
