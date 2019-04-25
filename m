Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB49C10F03
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2310220678
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556197288;
	bh=Z5o13u5SEfOqQI+GfkO/KziMTykmSD5QTd6/HiylPqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t87qxf7q4KdhSOVE0Hv1WU2v2GxQQ6OWyBp0EyLdd0LrUy9bparRiSTIsd8131/xe
	 2aCcYsIu6q3x7TtCaNf6VM2i6RqXtdoKSs6+lHGoROYTEk3rZYnyVdHrkmEZV5LaGt
	 ZXfPGkbpzQrtqj1aUyo2lZ/Sq+TpLUlUNZOlPzso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfDYNB2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfDYNB1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 09:01:27 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905F620678;
        Thu, 25 Apr 2019 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556197285;
        bh=Z5o13u5SEfOqQI+GfkO/KziMTykmSD5QTd6/HiylPqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4WQyPfQWLosEaE+QW+8v1JRCsa3nDXl4G42rs61dn+meBuulauy67PxnFVQC2FWi
         WHScWmscUqdM3tJWue4LDA+sOociIPABQPfo3rJtyXh+cuG7KVNqsUM47du1ql0o9t
         c5NmdmVcxkz3uj+4ujed8aex8R/FS2cHVBGNDBUU=
Date:   Thu, 25 Apr 2019 08:01:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
Message-ID: <20190425130124.GD11428@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212220230.1568-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 12, 2019 at 05:02:30PM -0500, Lyude Paul wrote:
> On a very specific subset of ThinkPad P50 SKUs, particularly ones that
> come with a Quadro M1000M chip instead of the M2000M variant, the BIOS
> seems to have a very nasty habit of not always resetting the secondary
> Nvidia GPU between full reboots if the laptop is configured in Hybrid
> Graphics mode. The reason for this happening is unknown, but the
> following steps and possibly a good bit of patience will reproduce the
> issue:
> 
> 1. Boot up the laptop normally in Hybrid graphics mode
> 2. Make sure nouveau is loaded and that the GPU is awake
> 2. Allow the nvidia GPU to runtime suspend itself after being idle
> 3. Reboot the machine, the more sudden the better (e.g sysrq-b may help)
> 4. If nouveau loads up properly, reboot the machine again and go back to
> step 2 until you reproduce the issue
> 
> This results in some very strange behavior: the GPU will
> quite literally be left in exactly the same state it was in when the
> previously booted kernel started the reboot. This has all sorts of bad
> sideaffects: for starters, this completely breaks nouveau starting with a
> mysterious EVO channel failure that happens well before we've actually
> used the EVO channel for anything:
> 
> nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000
> 00000002
> ...

> So to do this, we add a new pci quirk using
> DECLARE_PCI_FIXUP_CLASS_FINAL that will be invoked before the PCI probe
> at boot finishes. From there, we check to make sure that this is indeed
> the specific P50 variant of this GPU. We also make sure that the GPU PCI
> device is advertising NoReset- in order to prevent us from trying to
> reset the GPU when the machine is in Dedicated graphics mode (where the
> GPU being initialized by the BIOS is normal and expected). Finally, we
> try mapping the MMIO space for the GPU which should only work if the GPU
> is actually active in D0 mode. We can then read the magic 0x2240c
> register on the GPU, which will have bit 1 set if the GPU's firmware has
> already been posted during a previous boot. Once we've confirmed all of
> this, we reset the PCI device and re-disable it - bringing the GPU back
> into a healthy state.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Ben Skeggs <skeggsb@gmail.com>
> Cc: stable@vger.kernel.org

Applied to pci/misc for v5.2, thanks!

> ---
>  drivers/pci/quirks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..948492fda8bf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5117,3 +5117,68 @@ SWITCHTEC_QUIRK(0x8573);  /* PFXI 48XG3 */
>  SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>  SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>  SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
> +
> +/*
> + * On certain Lenovo Thinkpad P50 SKUs, specifically those with a Nvidia
> + * Quadro M1000M, the BIOS will occasionally make the mistake of not resetting
> + * the nvidia GPU between reboots if the system is configured to use hybrid
> + * graphics mode. This results in the GPU being left in whatever state it was
> + * in during the previous boot which causes spurious interrupts from the GPU,
> + * which in turn cause us to disable the wrong IRQs and end up breaking the
> + * touchpad. Unsurprisingly, this also completely breaks nouveau.
> + *
> + * Luckily, it seems a simple reset of the PCI device for the nvidia GPU
> + * manages to bring the GPU back into a clean state and fix all of these
> + * issues. Additionally since the GPU will report NoReset+ when the machine is
> + * configured in Dedicated display mode, we don't need to worry about
> + * accidentally resetting the GPU when it's supposed to already be
> + * initialized.
> + */
> +static void
> +quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot(struct pci_dev *pdev)
> +{
> +	void __iomem *map;
> +	int ret;
> +
> +	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> +	    pdev->subsystem_device != 0x222e ||
> +	    !pdev->reset_fn)
> +		return;
> +
> +	/*
> +	 * If we can't enable the device's mmio space, it's probably not even
> +	 * initialized. This is fine, and means we can just skip the quirk
> +	 * entirely.
> +	 */
> +	if (pci_enable_device_mem(pdev)) {
> +		pci_dbg(pdev, "Can't enable device mem, no reset needed\n");
> +		return;
> +	}
> +
> +	/* Taken from drivers/gpu/drm/nouveau/engine/device/base.c */
> +	map = ioremap(pci_resource_start(pdev, 0), 0x102000);
> +	if (!map) {
> +		pci_err(pdev, "Can't map MMIO space, this is probably very bad\n");
> +		goto out_disable;
> +	}
> +
> +	/*
> +	 * Be extra careful, and make sure that the GPU firmware is posted
> +	 * before trying a reset
> +	 */
> +	if (ioread32(map + 0x2240c) & 0x2) {
> +		pci_info(pdev,
> +			 FW_BUG "GPU left initialized by EFI, resetting\n");
> +		ret = pci_reset_function(pdev);
> +		if (ret < 0)
> +			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
> +	}
> +
> +	iounmap(map);
> +out_disable:
> +	pci_disable_device(pdev);
> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> +			      PCI_CLASS_DISPLAY_VGA, 8,
> +			      quirk_lenovo_thinkpad_p50_nvgpu_survives_reboot);
> -- 
> 2.20.1
> 
