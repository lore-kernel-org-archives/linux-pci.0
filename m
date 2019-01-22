Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3BC282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6134121841
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548201098;
	bh=jRtKrT4Fr7OvfKk4AgXDaAaRHxzbmYtL0pFNCei9/wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZuXoJhkIIGiqYGfIevfi0pjZ9+0hwawAhebwiLsaF9d1FbGcH5+rhno2rfH8uEBeB
	 UrqOG1PkVqZYzwEIskYTXxNUN9ipx0IbaSp0zfl/Rw8+4nWa3Z7r/anMWxq9JBYtX4
	 7aWFbQfhvjWWRlCdbOMCoTF25+F8USQF9CJTRFIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAVXvh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAVXvh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jan 2019 18:51:37 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB0A20684;
        Tue, 22 Jan 2019 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548201095;
        bh=jRtKrT4Fr7OvfKk4AgXDaAaRHxzbmYtL0pFNCei9/wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0uW0n1vQBxtxOP9LF8OZsVXNphbuE9MT570h0I4Gn1NiFTb4hRg1xkJD+AY4H3dK
         6/5aDn7XqVNi4Yzx9BTWtOMsDe7nGPEMxJlVxIJ1AKhBwJ0Qs3owm5C6QniSUapTiF
         xZ0fOy8UEmywsnHE8KVoC04yc8ILSZ9jpuwZabDM=
Date:   Tue, 22 Jan 2019 17:51:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
Message-ID: <20190122235134.GE14636@google.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122064544.27426-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
> There are some e1000e devices can only be woken up from D3 one time, by
> plugging ethernet cable. Subsequent cable plugging does set PME bit
> correctly, but it still doesn't get woken up.
> 
> Since e1000e connects to the root complex directly, we rely on ACPI to
> wake it up. In this case, the GPE from _PRW only works once and stops
> working after that.
> 
> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
> platform firmwares that have unreliable GPE wake.

This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
claims about a zillion different device IDs.

I would be surprised if these two devices are defective but all the
others work correctly.  Could it be that there is a problem with the
wiring on this particular motherboard or with the ACPI _PRW methods
(or the way Linux interprets them) in this firmware?

Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
output to the bugzilla, please?

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  drivers/pci/quirks.c   | 8 ++++++++
>  include/linux/pci.h    | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7efd9c..184e2fc8a294 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>  
>  	pci_dev = to_pci_dev(context->dev);
>  
> -	if (pci_dev->pme_poll)
> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
>  		pci_dev->pme_poll = false;
>  
>  	if (pci_dev->current_state == PCI_D3cold) {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..ed4863496fa8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  
> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
> +{
> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
> +	pdev->unreliable_acpi_wake = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
> +
>  /*
>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>   * completions for config read requests even though PCIe r4.0, sec
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f082..d22065c1576f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -331,6 +331,7 @@ struct pci_dev {
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
>  	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
>  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
> -- 
> 2.17.1
> 
