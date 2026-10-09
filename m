Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951763AEB49;
	Fri,  9 Oct 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563995; cv=none; b=pTotu+qh62U1kCUPfYhRIaO3hk/OiR7TXzZ7cTU62ZgIsdXPaAXqmMMLUUdW0Vf/oKWIyBS3yCcWOWx43I/JBsDFmCkuwArHwSudbbbqwWsX1aNJhLAv8jb97esTb7jnIvgkUDf/s+pCq/ga9TX5JtlbyapgCaBOsNBUw1KJAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563995; c=relaxed/simple;
	bh=kk3kOTBPrArfp9d/qnBlVWwOPwFl/PxyCQqJWfcpwfw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=kYg+/3axPGlqYZtWLdUiHQtKJnNwlOTVVdPFVgzvJQrGjRCF6jqQyn8VHkortno41oNrqRHQCfwA/kZ/LIJvFqRcUp5eD+48psGOZgHUjqz0Coppy8zbJ1FhYZRFah4bxJSTFtJy3nFsWyvCpBx/mwLKlp19mSlaChY4Jp9ikVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mzV1eZT9; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mzV1eZT9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=TwwZvgIurBDct/fGCIzm1g3CVHGZhqUQFnU2wB165kw=; b=mzV1eZT92EWRc6SpJU/8u3daR2
	EwVSbpikzGNpmvyY7INv8lib8QO4PhIGFbp1usv26p/Fbp1A8TlUTh3JldQkRJogfCWWbudZRfyI3
	K87we1OhdY71eyKlJJhqlLthyxCBazOXAPkhxZHan0fAcFYpV3KHl/+TshM27zB1jm/avDx4ucCDF
	MGxcmdQc68qp+icmxbFPqJVgiP9vMTuvH3wBgBlb7GEqUQz5rQHul74Bqm8ulxlK4U0PtlChFA1M7
	DRnwZSXMkKUOVo9l8DlqJke6HYyaHi/H6y5EehKsfxGna7jeINXhWzqhXtlGrSlhCOwFJ05aSk4r7
	rUsDPVcA==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xFDdL-00000002Me3-05mR;
	Fri, 09 Oct 2026 10:39:47 -0600
Message-ID: <91b08b3e-49dd-434e-a439-b3453c5ec3f3@deltatee.com>
Date: Fri, 9 Oct 2026 10:38:08 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-2-pavel.e.popov@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261009154034.82321-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-09 9:40 a.m., Pavel Popov wrote:
> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. Consequently, P2PDMA checks
> evaluate endpoint Device IDs against the host bridge whitelist,
> causing P2PDMA requests to fail regardless of host support.
> 
> This affects discrete devices such as GPUs, NICs and NVMe drives.
> 
> The P2PDMA host bridge check does not work in a VMware guest. Bypass it on
> Intel hosts under VMware, starting with Skylake-SP, the first Xeon
> Scalable generation. Xeon Scalable introduced UPI and is whitelisted for
> P2PDMA without restrictions. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so the bypass is implemented for Intel hosts only.
> 
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
> 
> Reviewed-by: Jim Chow <jim.chow@broadcom.com>
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
>  drivers/pci/p2pdma.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb314663..d96f44d0738a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,6 +21,12 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#include <asm/hypervisor.h>
> +#include <asm/intel-family.h>
> +#endif
> +
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -532,6 +538,19 @@ static bool cpu_supports_p2pdma(void)
>  	return false;
>  }
>  
> +static bool hypervisor_supports_p2pdma(void)
> +{
> +#ifdef CONFIG_X86
> +	/* Hypervisor hides host topology, allow p2pdma on Skylake and newer */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86_vfm >= INTEL_SKYLAKE_X &&
> +	    hypervisor_is_type(X86_HYPER_VMWARE))
> +		return true;
> +#endif
> +
> +	return false;
> +}

The changes seem fine, but one minor nit from me. Can we avoid putting
the #ifdefs inside the function?

Something like:

#ifdef CONFIG_X86
static bool hypervisor_supports_p2pdma(void)
{
...
}
#else /* !CONFIG_X86 */
static bool hypervisor_supports_p2pdma(void)
{
	return false;
}
#endif /* CONFIG_X86 */


Other than that, the core concept seems fine to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
