Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186EC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E1220659
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 00:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547511854;
	bh=WfetSsjyxPlm0VmTwn5Do5mXIpyTmlr4C9ONHulGWyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFud3LBJdxww2XtFs0WqueoDbXyQgDKbyxC4oWK3EbRDvpHFMv652swyiRJskCsv5
	 1E/x/jTAmo3fQ20xWX5u5/7dj8Skhj47naCQ1m+U5g4DjQPZjWbbcZZw/KJd110bki
	 +2War6j0Gi3x7uCm1bdh4cCXPjSqkFxK1M2ERW9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfAOAYO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfAOAYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 19:24:14 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5419220578;
        Tue, 15 Jan 2019 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547511853;
        bh=WfetSsjyxPlm0VmTwn5Do5mXIpyTmlr4C9ONHulGWyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlzSxtVuJdHrmXvozk061rYPpTtigWhEqO+a1CTTJ1slz/ObkztGKK3bW5fR4x3Ya
         sDLxMwx7Dlgfxt9FshwpnzSVt5JDc2SacAqaSNSCfXGmz1kuGL+STEy6a/QV+aL1PV
         9PM+JyLsSpgL83fobVFz9jy52CFcw624MXdVG608=
Date:   Mon, 14 Jan 2019 18:24:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Disable Data Link Layer State Changed
 event on suspend
Message-ID: <20190115002410.GF33971@google.com>
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
 <20190107143959.75267-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107143959.75267-3-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 05:39:59PM +0300, Mika Westerberg wrote:
> Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
> solve an issue where the hierarchy immediately wakes up when it is
> transitioned into D3cold. It turns out preventing PME propagation in
> some PCIe hierarchies not supporting D3cold.

I can't quite parse this last sentence.  Is it missing a word?

> I looked more closely what might cause the immediate wakeup. It happens
> when the ACPI power resource of the root port is turned off. The AML
> code associated with the _OFF() method of the ACPI power resource
> executes PCIe L2/3 ready transition and waits it to complete.

waits *for* it ...

> Right
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
> Disabling Data Link Layer State Changed event (DLLSCE) prevents the
> issue and still allows the downstream hotplug port to notice when a
> device is plugged/unplugged.

I don't understand the "link goes inactive and triggers PME" part.  Is
that prescribed by the spec, or is this implementation-specific
behavior, or even a bug?

Are there spec references that would be useful here?  PCIe r4.0, sec
5.2 seems like one starting point.  5.3.1.4.2?  5.3.3.2.1 and
following sections seem like they should be very relevant, but I
haven't studied it in detail.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
> Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index cd9eae650aa5..6fdaa8d48ebe 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -736,12 +736,18 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
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

I think some sort of comment here would be useful.  It's pretty hard
for the casual reader to figure out what things need to be masked.

> +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	pcie_write_cmd(ctrl, 0, mask);
>  }
>  
>  /*
> -- 
> 2.19.2
> 
