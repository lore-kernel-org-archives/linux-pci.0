Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF96303A0D
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417757; cv=none; b=sNcToYrIxxdWwdU4FKIQQvsyslDfQ3gNxsMSusxPzoxqiU2JyqlZKAnCQOzl0KQclQ7jOL3jS34K8xYaj4RqxRTf1yqYLis5eWeFytHmlxhszLkNDI1tXRauMRyoCswspXW9gzCXe/vcRIDzrdUy4EnM8ZZRGg48a2OIdSnspGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417757; c=relaxed/simple;
	bh=VFNRdDA4SJ3xCL8nap5GsWnuT52LwjoNQcxi6SKdIFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jPmRjKhkpfWUFVw291ADWMB+vJtNCjH3ScyFBpyHTqdusKtLKe0L4jW+0fjEZPPMdb+Qm8vsS9m4zSUeWKGZEsLIqfKmgpGWlD2N1ANNB/XO8ZWIcT/T05RaPdXMr23ooRhM1QN5L8j4axOhChF+gfPp/qDswVGkV06JNrJZrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhEazpLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhEazpLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31FDC116C6;
	Fri,  6 Feb 2026 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770417757;
	bh=VFNRdDA4SJ3xCL8nap5GsWnuT52LwjoNQcxi6SKdIFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RhEazpLj2Za3mEMsGXonz+jHjNPzaWNsnmrcZhaoX8zVaFN1Yix38mn/f210Bh5b3
	 fJvnobLEOzq8Zgqgw58Xou3H4oLzHD6pFzK9kuuXy/jzKAcoQyIMj5gWuzLiEtDiIn
	 AH0KYN8dfQi17RxXL1RmD4alCl0/u4qQcAzQ+1IZhecllWBCQGEewoxaCp4DR1qdxy
	 GhfDF9NsqB8uMbeqg41Bg0Qbpn8UPvxTLuE5n1Z57mHtzEXB/rntboZYE8bvW6sjU8
	 UMnLXpFsCpK7fbkqUB2pqM4mC5LLrDrIlsIxR/7D1DBrmIzA3xnSxht2B1Ggy2nQca
	 7BCtiRH3irHzQ==
Date: Fri, 6 Feb 2026 16:42:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PME: Replace RMW of Root Status register with direct
 write
Message-ID: <20260206224235.GA99608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>

On Sun, Oct 26, 2025 at 05:57:57PM +0100, Lukas Wunner wrote:
> As of PCIe r7.0, the Root Status register contains a single writeable bit
> (PME Status, type RW1C) and otherwise just read-only bits and RsvdZ bits
> (which software must write as zero, PCIe r7.0 sec 7.4).
> 
> Thus, when clearing the PME Status bit, there's no need to perform a
> read-modify-write of the register.  Instead, the bit can be written
> directly.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/enumeration for v6.20, thanks!

Thanks for the ping; I don't remember but suspect I just bulk-archived
old things in patchwork because it was so overwhelming.

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..411a0b88841e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2285,7 +2285,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>   */
>  void pcie_clear_root_pme_status(struct pci_dev *dev)
>  {
> -	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
> +	pcie_capability_write_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
>  }
>  
>  /**
> -- 
> 2.51.0
> 
