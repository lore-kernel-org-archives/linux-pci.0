Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0842BEA4
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831986; cv=none; b=nZgm4/8zdK7/m1b17QfSCR9upHmALwFBvC/XYtt4v2BDiieJWZMZgDSzWtsO3ionJCYQ7zqR1CJ8KhINLhgrMM+vlO998+rUq7lRRrINHZGK9ROtSmgOFoyCmj4MnVeH+vvif/+zUmqUs6K+y5oUWUdQIyLEYsgtNTlsChY1+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831986; c=relaxed/simple;
	bh=4zu2vD6llHuqcvwllp38olswAM99itwaKQrZksOebws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd2GufhV2oomKT8Saitm1i+mWVuHc9oPxlTi0xR/mGLD5d6QndpUJUchYbE+QnWdFYWGA+yiGeemmIuZyqkhG7Aq7RZtlA/4MQWfJBC30SiUGWOXBw0EaRa+12J1UaWyPvdTV8mHp2V6m3WIYsDhp/m6vSx1MJJpvxS5UYL4RWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id DA4C62A87;
	Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 94FDF600E1CF; Mon, 12 Oct 2026 21:06:13 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:06:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal
 Errors on T2 SEP
Message-ID: <as0vpb8EVlo_8Gx1@wunner.de>
References: <20261010172301.12764-1-aditya.garg@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010172301.12764-1-aditya.garg@linux.dev>

On Sat, Oct 10, 2026 at 10:53:01PM +0530, Aditya Garg wrote:
> Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
> Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
> off a few seconds after every boot. He also found the PCI Device
> 106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
> misbehaving and the most likely reason is that the device is ANFE
> incompatible due to Apple's custom hardware.

Nit:  Not sure what "misbehaving" means beyond the sudden power-off?

> +++ b/drivers/pci/pcie/aer.c
> @@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
>  	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
>  	 * 7.8.4.6).
>  	 */
> -	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
> +	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
> +		!dev->no_aer_anfe)
>  		pci_clear_and_set_config_dword(dev,
>  					       dev->aer_cap + PCI_ERR_COR_MASK,
>  					       PCI_ERR_COR_ADV_NFAT, 0);

Nit: The "!dev->no_aer_anfe" is not aligned with the opening brace.

It's probably not necessary to respin for the nits alone because
Bjorn may resolve them when applying the patch.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
