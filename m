Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06E449EC5;
	Thu,  7 May 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167525; cv=none; b=t1t7M+s0JmcoeuMMNCmjPbKXot/FEhZOiEl/bMVGEgoYxOdIsbmPfNK4Z5OTfpbboFH9wB9TTAj9Cq3xK75IdmUcD/Br7LstaMN2KQh2eNqZ2BNCfcTpXoJmPQGxYu7Lb0q4kllAA+Gqr3LfJOw661MsD9OVAfKKsUysevuKj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167525; c=relaxed/simple;
	bh=5D73UgmzYAbMCgy71AQH7BnKfr+NyNK4G08K25k/7qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTe5+nEZcKahUGryoLbYYU2QZJntF+fWVgnf4mwDrd/fvdEyfExJFZvxHf34ShKWCAconipqwKFI31jnu7QM3ZllZ5fgbzDEDjzddgcIEAU3FK1cfqfG4HxlM7Oa7+C8y01M8w9kT+/8WXFbg7vFdJ+sP2uyTks00NRx68eF2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ohhcZ76v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tz1jVmyB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ohhcZ76v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tz1jVmyB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 538021D000A0;
	Thu,  7 May 2026 11:25:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 07 May 2026 11:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778167521;
	 x=1778253921; bh=tCciJ3UNh3k/4As+A1FcBt3Wz7n9hz0fmoKMl8/g4TM=; b=
	ohhcZ76vq3Kti+Fc3/WlzfZCsXuG2wUXLRfXiPic464CROl+Oxz+RzoxZEOn3UT4
	LcY/Za0mAS+mFgTJStwtfAITIppjt9CEPZwjL5dauHNMMgQJbuq5HIBQLYV63eqE
	JnEdNRf+14YqGhGgm8ceRnPK3mfaGpvLOjw3PAn50fdlP51trpm42CV5Uet5XeeN
	Q+oPIKBptSTbSzAVAycz+SRcfvPBF7ozdZ32PgDRWiYaNf9rP+ik6uu0VQPxbnpW
	YbyhnRfzh+9QuI3FcLVrUrj9OhEqVconfasiZs0VrD/iwm6PHIKMiyL6jbEO03Qr
	AuR43uf7w9kP0PiSDWUheA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778167521; x=
	1778253921; bh=tCciJ3UNh3k/4As+A1FcBt3Wz7n9hz0fmoKMl8/g4TM=; b=t
	z1jVmyBQn/FgNAUYbobftM2aM1xHTL1oxNBL6rLglcrNn6f6G08BKXrGVEQhTtBg
	PoAUdR0j2CFZFEcxdyiyMz9+4EPuxzV+NlQsv+gDI7Qph+AfGmC2eFbD+5Pz4vzd
	Rq12HyDQvZrLkxphVP/GdrKgIefM0+x+QXHOzKhuZsOFrtCKpDSck9QnFYRqQ4dQ
	YiVh0B3ouNHyOt7VxcH8y0q5RP7MnpsKjWLCwl99qO3URUIwYPs9ZrubkUV1Rfc9
	RlW+SWQ1J0m5Q0xXeE/zH6vb/W6tnWRLUjKNec1IUrwyI3NZcsSoi6HZKntjRIKA
	A8X9adbaOZy8pRd8DaQ1A==
X-ME-Sender: <xms:4K78aa0GYYbgNs3z4PqPC3BSZAtvr_vdsLBpCcchbVfBjdqXyEISaw>
    <xme:4K78aelvbBYWVGo3WqaMzQlxfZxAScBD3mfeajp9zZd8qwwY5vg9ecZoUCmqDq94b
    lk7ngghhDr69z2rZ3efs0NH4Rc9C2uWAitS7AnyqcQMjZFwaVGtLg>
X-ME-Received: <xmr:4K78aS-5mGY2zyBE2bvbDUzVmKLqX3ix9SZ-GlQuCDdSMzw9HWrDdA2vWdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjthhorhhn
    ohhsmhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:4K78abpst2IUUIzW2RXfpmyNYCVu83KY7q3XAZb4E6-KLJG0gzkSQQ>
    <xmx:4K78aTmvebHkBtkQhxgBE6RrEqrwmn-Dm8Dv_k48LPk969Ne6FRRVQ>
    <xmx:4K78aagSOtLLTPd4bVUJo5icY9j2Nq2dbtUV_HkmVhPvCeqJwNmnug>
    <xmx:4K78aTc8INvm-yCWzZhYhAdlXt3qnh42FyxU4mfQMyYpyJQY0kT4hQ>
    <xmx:4a78aeuEXOiRlxUERSZR-ip4tJJiR47LlBnuf4MdgmIo_vWMgegdZLyP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 11:25:20 -0400 (EDT)
Date: Thu, 7 May 2026 09:25:18 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] PCI: Add D3cold reset quirk for devices with
 broken/missing FLR
Message-ID: <20260507092518.186c7f1b@shazbot.org>
In-Reply-To: <20260507142916.392983-1-jtornosm@redhat.com>
References: <20260507142916.392983-1-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 16:29:16 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Some PCIe devices require D3cold power state transitions for proper
> firmware reset when used in VFIO passthrough scenarios, but lack
> Function Level Reset (FLR) capability or have incomplete FLR
> implementations that don't fully reset firmware state.
> 
> Known devices affected:
> - Qualcomm ath11k WiFi (17cb:1103) - FLReset-, reset unreliable
> - Qualcomm ath12k WiFi (17cb:1107) - FLReset-, reset always fails
> - Qualcomm SDX62/SDX65 5G modems (17cb:0308) - FLReset-, never
>   initialize in VMs
> - MediaTek mt7925e WiFi (14c3:7925) - FLReset+ but broken, reset always
>   fails
> 
> The problem manifests in two scenarios:
> 
> 1. WiFi devices (ath11k, ath12k, mt7925e): Normal VM operation works fine,
>    including clean shutdown/reboot. However, when the VM terminates
>    uncleanly (crash, force-off), VFIO attempts to reset the device before
>    it can be assigned to another VM. Because FLR is missing or broken, the
>    reset fails and the device remains in an undefined state, preventing
>    reuse.
> 
> 2. Modem devices (SDX62/SDX65): Never successfully initialize even on first
>    VM assignment due to lack of proper reset capability.
> 
> Add reset_device_d3cold() quirk that performs a simple D3cold->D0
> power cycle when the device is bound to vfio-pci. This provides
> firmware reset capability for VM reset operations where standard PCI
> reset methods are insufficient.
> 
> The quirk only applies during VFIO passthrough - native drivers use
> their own reset mechanisms and will fall back to standard PCI reset
> methods by returning -ENOTTY.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..11d9a8b562e4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4237,6 +4237,40 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +/*
> + * Some devices need D3cold->D0 power cycle for proper firmware reset
> + * when used in VFIO passthrough. Some claim FLReset+ but it's incomplete,
> + * others lack FLR entirely, and standard reset methods don't fully reset
> + * firmware state. On bare metal with native drivers, we skip this and let
> + * the driver handle reset via standard methods.
> + */
> +static int reset_device_d3cold(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (!dev->driver || strcmp(dev->driver->name, "vfio-pci") != 0)

We should not have driver dependent reset behavior.  If FLR is broken,
add these devices to the list of devices using quirk_no_flr() and we'll
fall back to another reset method.  We also shouldn't be implementing a
variant of pci_pm_reset().  PM reset can also be prioritized over FLR
via the reset_methods sysfs attribute if the reset method really is
tied to the usage.  Thanks,

Alex

> +		return -ENOTTY;
> +
> +	/*
> +	 * D3cold->D0 power cycle for firmware reset.
> +	 * VFIO has already disabled interrupts and will handle state
> +	 * save/restore, so we just do the power transition.
> +	 */
> +	ret = pci_set_power_state(dev, PCI_D3cold);
> +	if (ret && ret != -EIO)
> +		pci_warn(dev, "D3cold transition failed: %d\n", ret);
> +
> +	ret = pci_set_power_state(dev, PCI_D0);
> +	if (ret && ret != -EIO)
> +		pci_warn(dev, "D0 transition failed: %d\n", ret);
> +
> +	pci_info(dev, "D3cold reset completed\n");
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4252,6 +4286,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_device_d3cold },     /* Qualcomm ath11k WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_device_d3cold },     /* Qualcomm ath12k WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_device_d3cold },     /* Qualcomm SDX62/SDX65 5G modem */
> +	{ PCI_VENDOR_ID_MEDIATEK, 0x7925, reset_device_d3cold }, /* MediaTek mt7925e WiFi */
>  	{ 0 }
>  };
>  

