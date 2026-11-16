Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860985;
	b=iGOel51i/GTwa81OW1mO27kue4U1tThtCzvyvYk8XkzO+SGh9YI/0sa1eS9/OsEwgilO
	 h80tYZcl+sbMfgYCGOGJ+wCasKMJ6eZaEES/IdjTEzafKzsacJfe3BDYoUp+B498XgRoc
	 RZrPICnchyvncS4AEzGpc75BE+4xKPHapbbrHsfbGyP67jnqcTymZMbFW6kRtVOqxjOMp
	 EMLvrhNeOmLWca2Sl4+FFywG+Uow4vo4buwc4RSzh9n6Cn6wtSPrA5WEgHAMofgiD5tGg
	 dsZZqbQbpWRTTzATJI2svGuexqfqDrmp31J+Vm2gJRkVLrR8UHtdoXCD2wdM3Ghn1EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bxiPwN4xhxQXi/k20R2XiKg45rKq5gXPBhnO4j3LjxU=;
	b=fXtQ1B6pIEo41HGyHiGuVZjRfKxzFiU5ZoPRAUpntYNMHiFxZG7HGo+UrJGW21c4SUP5
	 MhhSrvhgUSUcKmAJDEH6Udmmv3dEyBI3Osn66GXpm5d8BFV9oX8VUKkyYq+IA8z4t7Xcx
	 YAP07jfno+fm7uHQtppNwlN4+NV6H0E2kmuFQ1xyAyVNWQ7WpKv6TpG2rGbsNGxolScwk
	 lTI4eLKTJ//EKmdwlZbElz69w1Eluhu4XohLKQVtVn56vEz5N9OSM/dzSoZg6ncud5CHa
	 vZeyEtxC4OH1ta6kZZ2l0H0kQyu8ngyDu4Z5rzuT6g5H9xOHHG9/QxImJtQ03Oza91g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqKhH4UF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E1606A31C;
	Mon, 16 Nov 2026 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqKhH4UF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64681F000C4;
	Mon, 16 Nov 2026 20:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860984;
	bh=bxiPwN4xhxQXi/k20R2XiKg45rKq5gXPBhnO4j3LjxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cqKhH4UFdHcS1XNAmkgRAjHPI0hPd8pVumH1s9HS4uN/+N3NmJfo7nDTt4gct0A5c
	 G3bue/CmliRS7IMuccEh6c2htg/w8sxldqsRNXUml+J8Id6t5PmICIdbBQeR/EChzy
	 MQnAXZqeDF4C7UovAy1T33BjAqAicUoRZpImDbISiHgUzCyQs6Jr8PDLOcnYnibaWr
	 /2/t7Wb0wn5T/eeZa8PXTRoQ7IWKpH0bB56AGZB9RxWy7bE0xYqUlZU05Ln9WfJc52
	 RzM96hOgCsBCKSE0dD43KPAdAr4z8GABU/jU4eCBdQaUh0byG2ufaPL1AwByulASbV
	 q2lcNNnnh60tw==
Date: Mon, 16 Nov 2026 14:29:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kean Ren <rh_king@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Timur Tabi <ttabi@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
Message-ID: <20261116202943.GA204660@bhelgaas>
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
In-Reply-To: <20261116065612.230481-1-rh_king@163.com>

[+cc others from https://lore.kernel.org/linux-pci/20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com/;
is this the same issue?  That is for GPUs, not NVMe, but sounds similar]

On Mon, Nov 16, 2026 at 02:56:12PM +0800, Kean Ren wrote:
> On Lenovo ThinkPad P1 Gen 9 (21UF, Panther Lake), firmware enables the
> ACPI wake capability (_PRW) of PCIe root port 00:1c.4, which is the root
> port of the primary NVMe SSD.  When the NVMe controller is put into D3
> during system suspend, a spurious PME is raised on that root port, which
> sets ACPI GPE 0x6F (SCI).  The SCI fires during the noirq suspend phase
> and aborts s2idle before it reaches the low-power state: every suspend
> is followed by a wake within ~2.5 seconds with practically zero s2idle
> residency.
> 
> The downstream NVMe device is not a wake source (its own ACPI wake is
> disabled), so the spurious event comes from the root port's wake/PME
> path.  Disable the root port's wake capability as well.
> 
> No firmware with a fix is available: the issue reproduces with BIOS
> N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time of
> writing.  Match the 21UF model prefix; all 21UF SKUs share the same
> platform and firmware, and the remaining MTM characters encode the
> factory configuration and region.  If a fixed BIOS is released later,
> this quirk can be removed or restricted to the affected BIOS versions.
> 
> Verified on 21UFZE0PCN:
>  - gpe6F increments by one per suspend/resume on both BIOS versions;
>  - masking gpe6F, or disabling RP05 wake via /proc/acpi/wakeup, makes
>    s2idle stay asleep;
>  - with this quirk, /proc/acpi/wakeup reports RP05 as disabled and
>    gpe6F no longer increments across repeated suspends.
> 
> Signed-off-by: Kean Ren <rh_king@163.com>
> ---
> Changes in v3:
> - Check device_may_wakeup() instead of device_can_wakeup(): the latter is
>   set for all PME-capable devices, whether or not wakeup is enabled, so the
>   quirk could log a disable that did not actually happen.  Drop the
>   corresponding warning; there is nothing to do if wakeup is not enabled.
> 
> Changes in v2:
> - Match the 21UF model prefix instead of the full 21UFZE0PCN MTM so the
>   quirk also covers the other ThinkPad P1 Gen 9 factory configurations
>   that share the same platform and firmware.
> 
>  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee4..6ede2ea49b3a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6595,3 +6595,59 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Lenovo ThinkPad P1 Gen 9 (21UF): the firmware enables the ACPI wake
> + * capability of PCIe root port 00:1c.4, which is the root port of the
> + * primary NVMe SSD.  When the NVMe controller is put into D3 during
> + * system suspend, a spurious PME is raised on that root port, which in
> + * turn fires ACPI GPE 0x6F (SCI) and aborts s2idle before the system
> + * reaches the low-power state.  The NVMe device itself is not a wake
> + * source (its own ACPI wake is disabled), so disable the root port's
> + * wake capability as well.
> + *
> + * No firmware with a fix is available: the issue reproduces with BIOS
> + * N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time
> + * of writing.  Match the 21UF model prefix (the remaining MTM
> + * characters encode the factory configuration and region); if a fixed
> + * BIOS is released later, this quirk can be removed or restricted to
> + * the affected BIOS versions.
> + */
> +static const struct dmi_system_id p1g9_rp05_wakeup_dmi[] __initconst = {
> +	{
> +		.ident = "Lenovo ThinkPad P1 Gen 9 (21UF)",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			/* 21UF = ThinkPad P1 Gen 9 model; suffix is the SKU. */
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21UF"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static int __init pci_fixup_p1g9_rp05_wakeup(void)
> +{
> +	struct pci_dev *rp;
> +
> +	if (!dmi_check_system(p1g9_rp05_wakeup_dmi))
> +		return 0;
> +
> +	/* Root port of the primary NVMe SSD (05:00.0). */
> +	rp = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0x1c, 4));
> +	if (!rp)
> +		return 0;
> +
> +	/*
> +	 * Disable wakeup only if it is enabled: device_can_wakeup() is set
> +	 * for all PME-capable devices, even when wakeup is disabled.
> +	 */
> +	if (device_may_wakeup(&rp->dev)) {
> +		device_set_wakeup_enable(&rp->dev, false);
> +		pci_info(rp, "disabled spurious s2idle wake (BIOS %s)\n",
> +			 dmi_get_system_info(DMI_BIOS_VERSION));
> +	}
> +	pci_dev_put(rp);
> +
> +	return 0;
> +}
> +late_initcall(pci_fixup_p1g9_rp05_wakeup);
> -- 
> 2.43.0
> 
