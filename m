Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D743321C2
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854565; cv=none; b=jt4Vk+sGn4qZNDNu5EDkzjkEN65Tr4Slhqs8CrjaTpdVak7mWj4SrR9fUDxnhV7Z7NN5N81vqBPRyuXvKhjJO4EdXEwQ72nwEEM7lb31SzmjA5pWYdFvOFP5KAlGcLYIm0nQLkoepcmwgBE2cLcPvjZzKpvmV1AhgxKYkOBaW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854565; c=relaxed/simple;
	bh=bYKD5d2VJrInftd3DhGZlECJJSxiVE7ac/NEjM2SU+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoOgybLAp01t2SnCZx+Ak3UIxgrV81HlEZQUmTplk/nxX7xR3m7Behpjx7nf6mEepDxy5INk0qCXY7dg63Lzj4Znw8CZpZyyYMaokWcXEMB9hlj2ym2NBJt12deN79mD1rqnCeNy4Xn8Kv12LzeAlD6mktC/eyCnKy+OvmrBN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcEOeL5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcEOeL5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92961F000E9;
	Fri, 19 Jun 2026 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781854563;
	bh=oL8FXt4wlH8wPRPRv+I/izMvnp8kpqpufdLI7VUvW/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lcEOeL5kvzZF+gywn9r/SiEbJQDEaJEVjgdYvhIeL2VcQ6g157ZNP90dUQwvVBwZR
	 Rd2Vbu/PmcwdRaqNFMDDvN1USm2g5fbRAMf1lqQwGev6w1ErUwzQJuixI1z2yNIhQD
	 i3otZW/ypDYZwDvxF6wiXN0RPPWOrkb53s6S/34Jsf3i9483wghWhuCQcA8EkrdAZJ
	 cE+/9P+/eLsuso5ABiLoUnQ+dYOo4bEzyLhSMY+P7GmBuZaH2kLTJS9a4hD7NAwdFe
	 mZYaqHAw2bvjSUYRYzGonbHPuJuBbtc0QEY8wTKGBoPiW/9ZO9APNAmy4dOQWyRAcJ
	 TEu/RxO9Zzekg==
Date: Fri, 19 Jun 2026 09:35:57 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches
 [12d8:b304]
Message-ID: <brrexvadhod7xvgsksszcmabcvatz6rn5dsqdpkkeuyd2rnpqf@zlhbuhjogak6>
References: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618193030.69528-1-johannes.goede@oss.qualcomm.com>

On Thu, Jun 18, 2026 at 09:30:30PM +0200, Hans de Goede wrote:
> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
> 
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..2fd403ea3659 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6225,6 +6225,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
> -- 
> 2.47.3
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
