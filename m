Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F642F8EB8;
	Fri,  8 May 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260594; cv=none; b=mrQ+1JuxMiz1p8mJQ6yme9uE3kL8rdlIuzKF0KvHUKMhKIpkyR1ZHBb+eEgDWqa/rBECA1lcLpu2Qh/INIovD5a93pwaowtuJmRuXbdHb6v+Va23ERwuUdc7DuEFkDlSZfu+X/6kSwCRVJ5RtCeGgZbEVQa9nts3nnG5KiJmrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260594; c=relaxed/simple;
	bh=CKY8MtedfFKR3eZ2qjXZejpi+wTKyof4SRt5glHxP6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYTrWt6Uj2bl24aR3ulPInB0/zF7xEhLJa9Z9OSzLyvRXBaURM4SqibMj10rGSNKekHR406ADIdkpUxe9LO5B2PxPZE2SngV5cT/09CexTblcnXvuJHJF0nKWXHxu3cFJjE1ZMexYAxFt9XzqOyJy6x/r5S50n0CiPB1Ueqz+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=O1sZOaDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJxX3h1e; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="O1sZOaDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJxX3h1e"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E6C83EC0073;
	Fri,  8 May 2026 13:16:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 08 May 2026 13:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778260590;
	 x=1778346990; bh=KZLIH5uuK5L2ZLEtxa/cc2CTeS4FicC3l2Fx3x2XTqU=; b=
	O1sZOaDTOIKyJZJ2zAElw5KPMYeV2hBgRdPZFh71hYamGpqrC8zQGgGB4Wi+pRJj
	LmcltU77JdOj+D9E+JeV0+D1jSCO1bIK0lHl9kNOXs/nieF+6pxZ10RT20Ksg0OP
	RTMZznYfByYH54KdCnn9yNzlardgbPN+NHKcPv59GTpM2xinO669cpzITWuEDemG
	/yHf892V7p7l4gZy+x72PL3E3GWDnRXqAUflSCR3LeYlxQNgNboDm2eUkWkPRe8E
	8Kr+gRVqqGRJH9Kw7xPhmhGexlDCKQtOkOWKz5JdbSVx76/XLky9lsE8SxvF1Ano
	1I7GBUpnulfTMfGF5GjL/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778260590; x=
	1778346990; bh=KZLIH5uuK5L2ZLEtxa/cc2CTeS4FicC3l2Fx3x2XTqU=; b=c
	JxX3h1eBXjNj3NKGNv9yV1+8gdbE7yjpF9Mf9RlL6fxNAiWNMtJ9+5MJwY9YAU3j
	iz/gZLLng2PmkUYlKSii3pTIt9GCRZrw9RUYYjRInal9Y42ZYZBFLONoj88znM2v
	PnYmD8lSFVh5I5HkMtQluNgKNYlbADefJ8L3WHpYYe881ygmwVPJvZLSTHJEjPGz
	gf7jBINxO4lREeo8PUjukXwIxeer1aztOL4aP/ctC7xGh6r3WRPG+UvFd4yZMyNv
	9CfK/bVKJNvMKA0zVe4HyHCwY5tMQ1pIQ+p3ZkCI9wLYNID1UrtewOiLxdng/J9X
	t//0oEIIcNuRTAupHkFvA==
X-ME-Sender: <xms:bhr-aRIVSkxzvm8o2LADMnPWnq8f7nlNo1hErFyHUpMMUT1QMlFAaQ>
    <xme:bhr-aepOspiHXChT2T6UqZB3k0ILCV19d9TwSLovzyQ0mL4R8Csxe77R4kcSqblXD
    LEwrreYZWwY4wHOfHnXbAj31okMPp5gDzKGeOvgJVsfkf2lW-wXCQ>
X-ME-Received: <xmr:bhr-aZySnxeNd7hjdb9N2NqTj5aW-kdjLAMWg5qY6dNNFzf7VgOdwg_UjMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepkeehjeeitefffeeuieetjedtje
    ffvdelledvuedvffdvfeetgefhveekuedvfedvnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhtohhrnhhoshhmsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    giesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:bhr-aSPudeAykLzzdZ6sHmcwSof2w6DoA_kV7etaHlMLz9gYKsi14w>
    <xmx:bhr-ae4ep74ifhSr7zCrfDXE-prHs5uheW09KplSj2sdgzw3McEz1g>
    <xmx:bhr-ablAyzHB0V6XAXP-4ge7HLqCfbpN5VTr7zyVmkgqVoOt7upu5w>
    <xmx:bhr-aXQfADG6MYYTzzBpJT5itQKBHChXi1es6ww0MxQr2VTUoYWxlg>
    <xmx:bhr-aeizaAC8jlk2G0ghHxWIjdGJtPHvJGQZxQSM3g3qBvHRTsCfwazJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 13:16:30 -0400 (EDT)
Date: Fri, 8 May 2026 11:16:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v2] PCI: Force PM reset for Qualcomm devices with
 NoSoftRst+
Message-ID: <20260508111627.702c9be2@shazbot.org>
In-Reply-To: <20260508145153.717641-2-jtornosm@redhat.com>
References: <20260508145153.717641-1-jtornosm@redhat.com>
	<20260508145153.717641-2-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 16:51:53 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Some Qualcomm PCIe devices lack FLR capability and have the NoSoftRst+
> flag set in their PM capability. This causes all standard PCI reset
> methods to return -ENOTTY, leaving the device without any reset capability.
> 
> Add PCI_DEV_FLAGS_FORCE_PM_RESET flag to bypass the NoSoftRst check and
> allow PM reset to proceed with the standard D3hot->D0 transition. This
> provides these devices with a working reset method.
> 
> Apply this quirk to Qualcomm devices that need PM reset:
> - ath11k WiFi (17cb:1103) - No FLR, NoSoftRst+, needs reset for reuse
> - ath12k WiFi (17cb:1107) - No FLR, NoSoftRst+, needs reset for reuse
> - SDX62/SDX65 5G modems (17cb:0308) - No FLR, NoSoftRst+, never initialize
>   without proper reset (both modem generations share the same PCI device ID)
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> 1. WiFi devices (ath11k, ath12k): Normal VM operation works fine,
>    including clean shutdown/reboot. However, when the VM terminates
>    uncleanly (crash, force-off), VFIO attempts to reset the device.
>    Without a working reset method, the device cannot be reused for
>    another VM, preventing device reassignment.
> 
> 2. Modem devices (SDX62/SDX65): Never successfully initialize even on
>    first VM assignment without proper reset capability.

What does reset_methods sysfs attribute report for these devices on an
unpatched kernel?

I'd tend to expect these are single-function devices where bus reset
would be available as a function level reset.  Even in the case of a
multi-function device, vfio-pci could be performing a bus reset if all
the functions are bound to vfio-pci.  I'm very suspicious that this is
just masking an underlying issue relative to bus reset for these
devices, especially if we haven't actually verified the device state is
actually reset on transition back to D0 and we're just relying on
heuristics that this makes it work.  Thanks,

Alex

> Testing showed that without this quirk, no reset is performed during
> VFIO device initialization. With this quirk, PM reset succeeds and
> devices work reliably in VFIO passthrough scenarios.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v2:
>   - Split from original combined patch based on maintainer feedback (Alex
>     Williamson) and commented results.
>   - Change approach: instead of custom D3cold reset method, enable existing
>     pci_pm_reset() by bypassing NoSoftRst check for affected devices
>     (PCI_DEV_FLAGS_FORCE_PM_RESET flag is added for that)
> v1: https://lore.kernel.org/all/20260507142916.392983-1-jtornosm@redhat.com/
> 
>  drivers/pci/pci.c    | 12 +++++++++---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..e0b32eccfcf4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4451,6 +4451,10 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
>   * by default (i.e. unless the @dev's d3hot_delay field has a different value).
>   * Moreover, only devices in D0 can be reset by this function.
> + *
> + * Some devices incorrectly advertise PCI_PM_CTRL_NO_SOFT_RESET but PM reset
> + * actually works. For such devices, PCI_DEV_FLAGS_FORCE_PM_RESET can be set
> + * via quirk to bypass the NO_SOFT_RESET check and enable PM reset.
>   */
>  static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -4460,9 +4464,11 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>  		return -ENOTTY;
>  
> -	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> -	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
> -		return -ENOTTY;
> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_FORCE_PM_RESET)) {
> +		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> +		if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
> +			return -ENOTTY;
> +	}
>  
>  	if (probe)
>  		return 0;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..5e8b310c9d5f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5595,6 +5595,19 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>  
> +/*
> + * Some devices incorrectly advertise NoSoftRst+ (suggesting PM reset won't
> + * work), but PM reset via D3hot->D0 transition actually works fine. Force
> + * PM reset for these devices to provide working reset capability.
> + */
> +static void quirk_force_pm_reset(struct pci_dev *dev)
> +{
> +	dev->dev_flags |= PCI_DEV_FLAGS_FORCE_PM_RESET;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1103, quirk_force_pm_reset); /* ath11k */
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1107, quirk_force_pm_reset); /* ath12k */
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0308, quirk_force_pm_reset); /* SDX62/SDX65 */
> +
>  /*
>   * FLR may cause the following to devices to hang:
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..714dbdaa21af 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -261,6 +261,8 @@ enum pci_dev_flags {
>  	 * integrated with the downstream devices and doesn't use real PCI.
>  	 */
>  	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
> +	/* Force PM reset even when NoSoftRst+ is set */
> +	PCI_DEV_FLAGS_FORCE_PM_RESET = (__force pci_dev_flags_t) (1 << 15),
>  };
>  
>  enum pci_irq_reroute_variant {

