Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825988;
	b=NRXoDBkDgnPvhQ5AZepCY0wXyxwFTPc6Oal7HVhFVg56Q9N77VCMovR5DzYBtL4Jr7w+
	 CGWYt/8SDMFvG9hoNrqc4LC0v90oaOJLJrq9+tNfk1I0SLvi7t/BgKsSZhwiPN/V4FIIi
	 j7kAOKGSdRroobs6w5rYpcKDurQVtAXYEKWlVwe8aT8OWJvqLczmSibAbjciKthwm5/la
	 6/Rf1RsnRTbjtNqaFfVryRZxg4927BhJuIRBvcm+24kT2dT7xBzGUG+b465LOcawl0sOF
	 BlMGqkdO1qIQdYcpt4kDb5/i9MxI5QAxaXW9fsXtu6AhcFxFnRLXtX/hz/c0YNB1UQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825988;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SU/NW+fG/iJQEiZVhnxb+GxRVp9K5JtGaSpQS5e42mc=;
	b=zlqqfCVb0wMiAM1uRjk5hLJJqCW6aJLeXFMIq76ND9JIhj97b559rKlsqJyov3myYums
	 Q1GZZakS2FvSkNAFmb2Y85Da+XFxUUOvFu5oBEre69uHNODI73WIufHGM8lJJJiRUSR9e
	 WMLUQHUj+HNK1jjJCSifvR/VeQG0j53e2udjmoRBfkTxfs+2VGu0Pm04I8k86tXZEu4V+
	 eMLWMmoUlI3Ecgnyo6ulKwXkfTHB9KtHSZIjoFmBm/+UcTmSwUS6Q+eN2TW153JnOqctK
	 ha3fRZ6V9Lcn9nYVjcfeBpW6feJKL9/kIvzaRf9scJsww7naiAo5OD+PrlII0Geehtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D59606A31C;
	Mon, 16 Nov 2026 10:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7BE0410615;
	Mon, 16 Nov 2026 11:46:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D6D5602180C; Mon, 16 Nov 2026 11:46:24 +0100 (CET)
Date: Mon, 16 Nov 2026 11:46:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add quirk to mask ACSViol on XHCI on iMac20,1 And
 iMac20,2
Message-ID: <avrfAD_puIZm1yR1@wunner.de>
References: <20261116010835.1191-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116010835.1191-1-atharvatiwarilinuxdev@gmail.com>

On Sun, Nov 15, 2026 at 08:08:33PM -0500, Atharva Tiwari wrote:
> On iMac20,1 and iMac20,2 the Thunderbolt xHCI (8086:15ec) triggers an ACS
> Violation on its upstream port whenever it is runtime-resumed from D3hot,
> e.g. on suspend and shutdown:
[...]
> +++ b/arch/x86/pci/fixup.c
[...]
> +static void titan_ridge_xhci_mask_acsv(struct pci_dev *pdev)
> +{
> +	struct pci_dev *up = pci_upstream_bridge(pdev);
> +
> +	if (!dmi_match(DMI_PRODUCT_NAME, "iMac20,1") &&
> +	    !dmi_match(DMI_PRODUCT_NAME, "iMac20,2"))
> +		return;
> +	if (up && up->aer_cap)
> +		pci_clear_and_set_config_dword(up, up->aer_cap + PCI_ERR_UNCOR_MASK,
> +					       0, PCI_ERR_UNC_ACSV);
> +}

See this discussion:

https://lore.kernel.org/r/CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com/

It's an LTR message with a zero Requester ID.  This needs to be fixed
more generically, not with a model-specific quirk.

Thanks,

Lukas
