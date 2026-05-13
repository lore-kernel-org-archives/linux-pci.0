Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB328136F;
	Wed, 13 May 2026 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679093; cv=none; b=k9Q+HGIb+8LQDl8xRWTR6bHum1WfdvPK4MwRJ+Bv7Z/R88htqHfXhSb4YvE3AUf0NaB+1cN8lHy0KyA00LlUEWHXIkoRzy8cWQBY4O4L9LswY7pLM/xO3eDyBmEPQk9Mk4FThg5sLqsZJWAwzOrUocRSquByuy1+4x1CaDXpypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679093; c=relaxed/simple;
	bh=6mAKEgLgpZ+5k4w4TKPXW22pRH1yfidthSFNEbQzbb8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IcbskN24I1LPLCeyo5HjHAeaGTV8hWKqqzjDlNi03w5rI6o/fNfssJDtkOjhnHh9WSGyzoBsd5r82vlSQLlFLHz9HG8DmrhvQlQqSj53lvqdqBSp6HA1JUT0n9Jt5+LdPPH78GNA9Ev17fs4Q1F6y54cziVb2kQ3GtCjL3Ed0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=T+fLBrSM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tI3VY/Ws; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="T+fLBrSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tI3VY/Ws"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 21B2CEC01F3;
	Wed, 13 May 2026 09:31:29 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Wed, 13 May 2026 09:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778679089;
	 x=1778765489; bh=xb+VuXdX+Y9hjQ+T925tr2yq3MyNGh4USiEHA2WGkvQ=; b=
	T+fLBrSM8htrRXAXKiTF3dZtDXybwuX6jQ+hQ+AWM/HQM0bMy60ijCISQgNAYXH7
	Kpa/jPMB/MF0j9OrJ9rfljQL1PKUBhst4tlFam/B/xziPEZB4Nn4Nj7SukvVNuey
	hPNVLJnMawcIg81ggFAH1OuyT9Z+0mMWQT4fQgONeH2VVm5dgIs0dxqOZlARLR5Y
	fywx+d5i2pje3hI/yDLJQ3zEQJT5ZlTv4EGin6+Vz1s/iBjBpBws5net+PVwJsoG
	9oFaSD4Q8wB5KXE1/7kDqxLZhRX3t9R2/q+NCbh+p9SR0ERY6dh+zLC67kZjfoV+
	QKj7vCEXyeqyq/wL1aNRVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778679089; x=
	1778765489; bh=xb+VuXdX+Y9hjQ+T925tr2yq3MyNGh4USiEHA2WGkvQ=; b=t
	I3VY/WsQDnsmVikIgjxPRMPvvpTVWVTP+I1uStaPQ/VP9w+bDAKsgTiGUsZPu/jv
	2e0LCCC+OMV+u/yCjGVhmV00dH+zTlfvDysQKCFDJSbAWFs3j00HFwNrl0aq45f8
	33Or8qciwPk3xfn+HEWuU/AW7lNg9ZpHR3Q38Bg2VWNjt4wK2qbTJqzNMlerZgx/
	lM3dts3UnWlK4BUNqLt5OYkenhOSVZ/CPOko4QF47hT6gfF50lj/F4zlC2rggZfO
	QrBWQ3Z0xfNMcsQCcRpbxfg8fbzm1BEczfDIYjgbCMq2fpx+EhGKNqrPThXBiFwM
	0JQAPErwdEeeYqPqfgRVw==
X-ME-Sender: <xms:MH0Eau6CI0MbAoIxeA6keTyUrF7WsRH_onf5HGh7m7VFgb6MsC-wrw>
    <xme:MH0Eaitnt3DjVSRZxMPrtwPKHOhRi9BbmVq2MRrnCDkbKYtddW1Un7_EBvbJwwTEX
    4F8t_M3TOEw-LhFyoJN10rjvIlzEHKzdtym5UZYlL2X8n-iZNKgyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlvgig
    ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpefftdeggfeiveejteehhfeuffeggeeiuedvuefgieehjeegheeugedv
    heeltdelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdho
    rhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhtohhrnhhoshhm
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MH0EalgL22CWsenOqM8z5r4TGzXZHpZ_opsFIUQjC3GkUau-mjUFLA>
    <xmx:MX0EalcyKx3OlflRFDxgYOeqg4nAvBLMGvUdPaPotH_FKVawzirQ_A>
    <xmx:MX0EaomsvZxqnCcyuKBz1YcQAJ1bKcglaaJtzyaamqel8FX50R1MGA>
    <xmx:MX0EautyPh2YcTbADs50I0RzZw_koGRjx7fGOhyxKtzOB3nLuYgx9w>
    <xmx:MX0EagdCMj6QaWOTL0mUHjebXZLVQXXavGAS11EA0cTZDIOy6iofr8PL>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E240215C008E; Wed, 13 May 2026 09:31:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAQk2_-bpYfJ
Date: Wed, 13 May 2026 07:31:08 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2c4dbba3-f9ed-48d9-a0c4-d590904f3fdf@app.fastmail.com>
In-Reply-To: <20260513122349.268753-1-jtornosm@redhat.com>
References: <20260513122349.268753-1-jtornosm@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 13, 2026, at 6:23 AM, Jose Ignacio Tornos Martinez wrote:
> Add D3cold power cycle as a general PCI reset method, available for
> single-function devices. This provides a more robust reset mechanism
> than D3hot for devices where a full power cycle is beneficial.
>
> The implementation uses pci_set_power_state(dev, PCI_D3cold), which
> automatically handles platform differences:
> - Platforms WITH _PR3 ACPI power resources: true D3cold (power cycle)
> - Platforms WITHOUT _PR3: automatic fallback to D3hot transition
>
> D3cold reset is placed at the end of the reset hierarchy as a last
> resort before giving up, since it provides a strong reset when other
> methods are unavailable or broken.
>
> Reset hierarchy with this change:
> 1. device_specific
> 2. acpi
> 3. flr
> 4. af_flr
> 5. pm (D3hot via config space)
> 6. bus (SBR)
> 7. cxl_bus
> 8. d3cold (NEW - power cycle with D3hot fallback)
>
> This benefits devices that:
> - Have broken or missing FLR
> - Advertise NoSoftRst+ incorrectly (blocking D3hot PM reset)
> - Have broken bus reset implementations
> - Need power cycle for reliable reset
> - Are used in VFIO passthrough scenarios
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v3: Implement d3cold as a general PCI core reset method instead of
>   device-specific quirk approach from v2 (Alex Williamson suggestion)
> v2: https://lore.kernel.org/all/20260508145153.717641-2-jtornosm@redhat.com/
>
>  drivers/pci/pci.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  2 +-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..6da8feff7ccc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4491,6 +4491,46 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	return ret;
>  }
> 
> +/**
> + * pci_d3cold_reset - Put device into D3cold (or D3hot) and back to D0 
> for reset
> + * @dev: PCI device to reset
> + * @probe: if true, check if D3cold reset is supported; if false, 
> perform reset
> + *
> + * Attempt to reset the device by transitioning through D3cold and 
> back to D0.
> + * On platforms with ACPI _PR3 power resources, this performs a true 
> D3cold
> + * power cycle (actual power removal). On platforms without _PR3 
> support,
> + * pci_set_power_state() automatically falls back to D3hot, providing a
> + * D3hot->D0 reset transition.
> + *
> + * Only available for single-function devices to avoid affecting other
> + * functions in multi-function devices.
> + *
> + * Returns 0 if device can be/was reset this way, -ENOTTY if not 
> supported,
> + * or other negative error code on failure.
> + */
> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +
> +	if (probe) {
> +		if (!pci_pr3_present(dev))
> +			pci_dbg(dev, "d3cold reset: no _PR3 support, will use D3hot 
> fallback\n");

This fall through is invalid, if D3cold can't be reached the reset should be handled by pci_pm_reset() where NoSoftRst is honored.  pci_pr3_preset() should be tested in all cases, not just probe.  I think we also need to test device flags that would prevent a D3cold transition, like pci_pm_reset().  Thanks,

Alex

> +		return 0;
> +	}
> +
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	ret = pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		return ret;
> +
> +	return pci_set_power_state(dev, PCI_D0);
> +}
> +
>  /**
>   * pcie_wait_for_link_status - Wait for link status change
>   * @pdev: Device whose link to wait for.
> @@ -5065,6 +5105,7 @@ const struct pci_reset_fn_method 
> pci_reset_fn_methods[] = {
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> +	{ pci_d3cold_reset, .name = "d3cold" },
>  };
> 
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..1ca7b880ead7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
> 
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
> 
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> -- 
> 2.53.0
