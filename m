Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7270C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 21:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CD021B24
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550179421;
	bh=7AqDADxFhirwmTm7LAFAooKA65XX1dE/RqIVBwMzFUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ELDxYj7NcF6w/miXKqZy+4jjnmKQ1uiVw/4mRvkyRhvxgtFE8DnBdf2XVbmUN/DeO
	 uyRe4z85zIJF/YWCgO4KbpxjOwg8LN1eFNt/A7w/F7Bxi6Ef/MyiF6d9XdjTro+/ma
	 68m+MnkViWAAAPK5v1mwi9UDvVeL/Z93vSc1/gfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439992AbfBNVXl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439987AbfBNVXk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 16:23:40 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6309D218FF;
        Thu, 14 Feb 2019 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550179419;
        bh=7AqDADxFhirwmTm7LAFAooKA65XX1dE/RqIVBwMzFUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6i0iTjkkfxAWJQQGExqbAl0kllGw91sGF1HEYCj8wFtY84YK34buVLYOeyZ8/nyB
         4lMhLaQjnHiHuw+hpM361XjOkdfDkADKENv7W23v8tLxZ08p2MbE43qWsYD9leX97L
         kv0LCq0zhI8IWY354A1MBWsAVwKh+53tzRz9GSsM=
Date:   Thu, 14 Feb 2019 15:23:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Disable Data Link Layer State
 Changed event on suspend
Message-ID: <20190214212129.GN96272@google.com>
References: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
 <20190131170746.7604-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131170746.7604-3-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 08:07:46PM +0300, Mika Westerberg wrote:
> Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
> solve an issue where the hierarchy immediately wakes up when it is
> transitioned into D3cold. However, it turns out to prevent PME
> propagation on some systems that do not support D3cold.
> 
> I looked more closely what might cause the immediate wakeup. It happens
> when the ACPI power resource of the root port is turned off. The AML
> code associated with the _OFF() method of the ACPI power resource
> executes PCIe L2/3 ready transition and waits for it to complete. Right
> after the L2/3 ready transition is started the root port receives PME
> from the downstream port.
> 
> The simplest hierarchy where this happens looks like this:
> 
>   00:1d.0 PCIe Root port
>     ^
>     |
>     v
>     05:00.0 PCIe switch #1 upstream port
>       06:01.0 PCIe switch #1 downstream hotplug port
>         ^
>         |
>         v
>         08:00.0 Pcie switch #2 upstream port
> 
> It seems that the PCIe link between the two switches, before
> PME_Turn_Off/PME_TO_Ack is complete for the whole hierarchy, goes
> inactive and triggers PME towards the root port bringing it back to D0.
> The L2/3 ready sequence is described in PCIe r4.0 spec sections 5.2 and
> 5.3.3 but unfortunately they do not state what happens if DLLSCE is
> enabled during the sequence.

The hotplug (and, I guess, the DLLSCE interrupt) and PME interrupts
are the same INTx wire or MSI vector.  But I guess we know the
interrupt here must really be a PME because pcie_pme_irq() reads
PCI_EXP_RTSTA_PME and does nothing unless it is set.

> Disabling Data Link Layer State Changed event (DLLSCE) seems to prevent
> the issue and still allows the downstream hotplug port to notice when a
> device is plugged/unplugged.

Interesting that Hot-Plug Interrupt Enable by itself doesn't seem to
gate the DLLSCE notification.  Sec 6.7.3.4 says Hot-Plug Interrupt
Enable is a master enable/disable bit for "all hot-plug events".  It's
not completely explicit about what "all hot-plug events" includes, but
DLLSCE is definitely included in the list in sec 6.7.3.

I don't think the bugzilla from Heiner below is actually related to
*this* patch.  Heiner's system doesn't have the topology above.

If you have a report for a system where the immediate wakeup happens,
i.e., something with the topology above, I'd be interested in
including that report here.  Ideally it would have complete lspci
info.  I'm just wondering if this is actually a defect in the switch.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
> Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index cd9eae650aa5..8bfcb8cd0900 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -736,12 +736,25 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
>  
>  void pcie_enable_interrupt(struct controller *ctrl)
>  {
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
> +	u16 mask;
> +
> +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	pcie_write_cmd(ctrl, mask, mask);
>  }
>  
>  void pcie_disable_interrupt(struct controller *ctrl)
>  {
> -	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
> +	u16 mask;
> +
> +	/*
> +	 * Mask hot-plug interrupt to prevent it triggering immediately
> +	 * when the link goes inactive (we still get PME when any of the
> +	 * enabled events is detected). Same goes with Link Layer State
> +	 * changed event which generates PME immediately when the link goes
> +	 * inactive so mask it as well.
> +	 */
> +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	pcie_write_cmd(ctrl, 0, mask);
>  }
>  
>  /*
> -- 
> 2.20.1
> 
