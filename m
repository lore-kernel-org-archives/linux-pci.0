Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE442EEB0;
	Thu,  5 Mar 2026 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732692; cv=none; b=iJhK+C1vJ10kVwkZmqhPx0vTe7eAL86z0eFvueDDCIsOW2bW5dY6mHudGNPTp2LzcStFDE3KFRLJYxywfmPIMLaZJ9ig8tWgk0wNby2nGqbEALSnyJjl+2S7f4HHVkaIxZjTY9EFsWusuDqVNwqwNHbdFzGkLc718AsUOWKBqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732692; c=relaxed/simple;
	bh=ck8+DjXKb2F4QyqZhW7/Peilix4hvCClIFhFD/P2p3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JyCTpOF5fLNdixF3sIZaiQNIQ6D0NznbmrpUMoxjso4oFpbQlqcfVUKDkm/VBAAe9lTkU+9t83moC49rX6TxEq5WUzWgwpKz88gNlVq9gLiOl9Q5ctvSp3njZnS+9QTAE+KeWSR3UbvQBVjeQQmTBvB8Of/07ZAYj76/zRMtdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1MbpKgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1MbpKgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E491C19425;
	Thu,  5 Mar 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772732691;
	bh=ck8+DjXKb2F4QyqZhW7/Peilix4hvCClIFhFD/P2p3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T1MbpKgd8Q8mJZ8Ph4BM6FwcvM+oi+KRd+UMrzYrENNQRp3k8AegzySoK2ZcvHyLM
	 iKGAlaJXeKN1dNrhJF4k2SIe52QOKh1MLhfmtcOK6Fj2QR69s3XhMGsDN0qUXPDgzj
	 i7X6+3JFzymuP+rVo8PYrVsHlVrcAGdb1J44u655Ut4oPhNsdycEUFAP/SkqSV2y0C
	 Kc4xRJhdkW17QNfxpNyNws8XDSbnEtBQ2ABDorJsqS4DZZvSNmbXWCi0Wulcm/Sx5g
	 R+zD/BL2fbpvaqhjJBawPnfzr3c+sbD8xKdaHmRFxShSnX7RW789sVQlW+UCZRdClf
	 IUN8T2K2y124g==
Date: Thu, 5 Mar 2026 11:44:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing maintaner, mark Altera
 drivers as orphans
Message-ID: <20260305174449.GA70139@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305171852.3114177-1-dave.hansen@linux.intel.com>

On Thu, Mar 05, 2026 at 09:18:52AM -0800, Dave Hansen wrote:
> This maintainer's email is now bouncing. Remove them and mark
> the code as an orphan for now.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Applied to pci/for-linus for v7.0, thank you!

> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c32d76a949979..d010689fa91a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20121,9 +20121,8 @@ F:	Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
>  F:	drivers/pci/controller/pci-aardvark.c
>  
>  PCI DRIVER FOR ALTERA PCIE IP
> -M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Supported
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>  F:	drivers/pci/controller/pcie-altera.c
>  
> @@ -20368,9 +20367,8 @@ S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
>  PCI MSI DRIVER FOR ALTERA MSI IP
> -M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Supported
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/interrupt-controller/altr,msi-controller.yaml
>  F:	drivers/pci/controller/pcie-altera-msi.c
>  
> -- 
> 2.43.0
> 
