Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650849;
	b=Z+sDEE9M8pdC1rm2WEXUnu4q/wDwDf23G8a48CdH3pOfcHKYaBCpiiAmKkpHAB7Ys+1V
	 U8E5VdJGokdkXPOiLueYs6iJ2yP47LQgbMKSo7XKIxfthyPfz0wh433KxT9RJD2tp/I7T
	 Ze3VfRsgHj+4V391cJ8AdqDXSbe1t8Gm77iVSSl5mWoxe3Tc2ujR6Eoz9pLJZzSqwq3J2
	 PynWNwGhwIcCrY//WRecflFdOCIlzKCRooMMJpDGTBbVo9dxTUB+tEORraH66UESyOwEt
	 M/OWTx9OA4qhFoWS0K53PaVvOjOyqn8WeuNfnZVzDAXmumBcvcBD6wrmwzAXg+Yen5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650849;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OTRmHEj02TtZoL+kyiWN5B6jSVLuuf5zLZHpzWRlffQ=;
	b=WXWa7ETrbFD2lwgHlgIdfM+3H+PEZPE3Y8fPpQ8Y68iPWiHpB55Tb/ILLBNs4ZzB8irU
	 ExqHgWI1QriqgSNuVvVE3Riw63UT8jVlqtuA/i6xtYaUT7voek9s4Yns8Sn/TwxKDtKNz
	 Bv87J8eZ5HNxiTvYx2e05K0qNStkRF5u5izvUVHt8HgozYHEsasX9LsjEm1Ge4dTsLPN9
	 UcF69dTOTZcbstRpKAA5d9n6Os4ePKE5qaWk4PPEfYl5WbIXKXQLXPqNP83RHyMOAV6Dk
	 ggXV4IQjnQL9cBt5SYYI05RdkZK71eJUZEPXmkPoiu9lwaDUGFxdWi/Em77NO0DV9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47C606A324;
	Mon,  2 Nov 2026 20:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC47C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6CFAA78C3;
	Mon, 02 Nov 2026 21:20:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 59103610CD9F; Mon,  2 Nov 2026 21:20:39 +0100 (CET)
Date: Mon, 2 Nov 2026 21:20:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, terry.bowman@amd.com, kanie@linux.alibaba.com,
	olof@lixom.net
Subject: Re: [PATCH v15 1/4] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Message-ID: <aujwl45XrkVT-zUx@wunner.de>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
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
In-Reply-To: <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>

On Fri, Oct 02, 2026 at 02:18:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
> so default to native handling of them only when CONFIG_PCIEPORTBUS is
> enabled.
> 
> Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
> defaulting those to native regardless.
> 
> [bhelgaas: commit log]
> Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This is now commit 6347fd9aee19 in Linus' tree and I think there's a problem:

> +++ b/drivers/pci/probe.c
> @@ -658,6 +658,8 @@ static const struct device_type pci_host_bridge_type = {
>  
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
> +	bool port_services = IS_ENABLED(CONFIG_PCIEPORTBUS);
> +
>  	INIT_LIST_HEAD(&bridge->windows);
>  	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	INIT_LIST_HEAD(&bridge->ports);
> @@ -668,12 +670,12 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> -	bridge->native_aer = 1;
> -	bridge->native_pcie_hotplug = 1;
> +	bridge->native_aer = port_services;
> +	bridge->native_pcie_hotplug = port_services;

The commit is setting the native_pcie_hotplug bit up front based on
CONFIG_PCIEPORTBUS.

But there's an if-clause at the top of get_port_device_capability() which
adds PCIE_PORT_SERVICE_HP to the port services used by a given PCIe port.

Inside the if-clause is code to disable hotplug interrupts if the BIOS
left them enable.

Since the commit, if CONFIG_PCIEPORTBUS=n, the if-clause is no longer
entered and so the interrupts are no longer disabled.

I'm amazed sashiko didn't flag this.  I didn't spot it during review
either, but noticed it when rebasing my development branch.  I still
have a patch on that branch which I developed last year but which
was ultimately not accepted (for good reasons).  Back then I already
noticed that the interrupt disablement issue prevented simplification
of native_pcie_hotplug initialization.  I forgot about it but had to
revisit the patch when rebasing the development branch on top of your
patches:

https://lore.kernel.org/r/5eae82776d695e589b89aad500d8208b980347e5.1752390102.git.lukas@wunner.de

Now what?  The offending patch is the first one in a series of three.
Revert all three or can we somehow salvage this?

Thanks,

Lukas
