Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F403C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4438F2084A
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544536907;
	bh=BrPCIYw4y3W3jjjxvy14qmwei0MW0x6KeI0SPMGcEfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmLiSftV7fzirGC9HxDfZEqDgEyL0R0EifQm2oo6v7a1dV+D/oIvyuVsd/9k6Kpc3
	 GhEjeMr1ysMWLW/G1P6crA8yyQtIJ2ETKw5J4jNKLVPQnR+j4HplM9GF14ly2zLsd4
	 so26sflhWz0+Z9Bp37LvE8KW3pXniAfVit1WQ9N0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4438F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeLKOBq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeLKOBq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 09:01:46 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC0A2082F;
        Tue, 11 Dec 2018 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544536904;
        bh=BrPCIYw4y3W3jjjxvy14qmwei0MW0x6KeI0SPMGcEfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYJcHiouudMefyK2+ftBv4ygnhtWrjBASJZ2+b39da1AoxIV9eMyIbVglsmQ21zVl
         P9ABEhOghbslkvWKe0VIFQJQ1eyje/h9sgocdfEjWBhvcy2/L4N+WCTNVLEkHx0iQc
         t0JLdTPENVgofOobfER9jqD79nEpCk+H2FDby0yg=
Date:   Tue, 11 Dec 2018 08:01:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     davem@davemloft.net, saeedm@mellanox.com, ogerlitz@mellanox.com,
        tariqt@mellanox.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20181211140143.GD99796@google.com>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206041951.22413-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

I see you're still working on this, but if you do end up going this
direction eventually, would you mind splitting this into two patches:
1) rename the quirk to make it more generic (but not changing any
behavior), and 2) add the ConnectX devices to the quirk.  That way
the ConnectX change is smaller and more easily understood/reverted/etc.

On Thu, Dec 06, 2018 at 03:19:51PM +1100, David Gibson wrote:
> Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
> unbound from their regular driver and attached to vfio-pci in order to pass
> them through to a guest.
> 
> This goes away if the disable_idle_d3 option is used, so it looks like a
> problem with the hardware handling D3 state.  To fix that more permanently,
> use a device quirk to disable D3 state for these devices.
> 
> We do this by renaming the existing quirk_no_ata_d3() more generally and
> attaching it to the ConnectX-[45] devices (0x15b3:0x1013).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/pci/quirks.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..add3f516ca12 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1315,23 +1315,24 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>  
> -/* Some ATA devices break if put into D3 */
> -static void quirk_no_ata_d3(struct pci_dev *pdev)
> +/* Some devices (including a number of ATA cards) break if put into D3 */
> +static void quirk_no_d3(struct pci_dev *pdev)
>  {
>  	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>  }
> +
>  /* Quirk the legacy ATA devices only. The AHCI ones are ok */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  /* ALi loses some register settings that we cannot then restore */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  /* VIA comes back fine but we need to keep it alive or ACPI GTM failures
>     occur when mode detecting */
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> -				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> +				PCI_CLASS_STORAGE_IDE, 8, quirk_no_d3);
>  
>  /*
>   * This was originally an Alpha-specific thing, but it really fits here.
> @@ -3367,6 +3368,10 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>  			mellanox_check_broken_intx_masking);
>  
> +/* Mellanox MT27800 (ConnectX-5) IB card seems to break with D3
> + * In particular this shows up when the device is bound to the vfio-pci driver */

Follow usual multiline comment style, i.e.,

  /*
   * text ...
   * more text ...
   */

> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTX4, quirk_no_d3)
> +
>  static void quirk_no_bus_reset(struct pci_dev *dev)
>  {
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> -- 
> 2.19.2
> 
