Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC84C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B920880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555337757;
	bh=+c9tqmdYpsQrL2+t2QqE3CVnCkBh/sdftL1h2M+dlTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hpnz9DXPTj0dmIb4bjmTJjRjJrEnaE/bQKvocryO3XYa9k2qKq5k6wxWpfh1edzi5
	 8AO4A6CTsUETbrjceWjirebvN9Pvjc37WjVIEfMVImm2GINOXFea5kpPKWxtPqePaJ
	 hzzP6TVidCDm+VULnnU7ZSRJ+TkqzmKi/F9ZsiVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDOOP4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOOP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 10:15:56 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD55B20825;
        Mon, 15 Apr 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555337755;
        bh=+c9tqmdYpsQrL2+t2QqE3CVnCkBh/sdftL1h2M+dlTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hmBdphA6QxfiY/598HOQ2mvSKmutsTShmo3gkGnTUqssT1mcq0NYBSwb4cbP3dpx
         9sVsnrO68sak83UVDzZ7Lr4iD8Gcy9tAj+UyDesUW5MDE1Qkx0xNKTiGxd3sREAJbR
         /h09pkiNQ8QEs5TjDRj694/aygT2nkCoIoND3ebc=
Date:   Mon, 15 Apr 2019 09:15:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190415141554.GL126710@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415135903.wiyw34faiezdnbbs@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This says it's a resend, but I don't see a previous posting; maybe it was
HTML and rejected by the mailing list?

On Mon, Apr 15, 2019 at 04:59:03PM +0300, Alexander Fomichev wrote:
> PLX switches have an issue that their internal registers become inaccessible
> when runtime PM is enabled. Therefore PLX service tools can't communicate
> with the hardware. A kernel option "pcie_port_pm=off" can be used as a
> workaround. But it affects all the devices.
> So this solution is to add PLX switch devices to the quirk list for
> disabling runtime PM only for them.

I assume the problem is actually that the config space registers are
inaccessible when the device is in D3hot?

I think config space access is supposed to work when a device is in D3hot
(see PCIe r4.0, sec 5.3.1.4).

If it doesn't work, wouldn't that mean that we couldn't even bring the
device *out* of D3hot, since that requires a config write?

If this is really the problem, it'd be nice to identify this specifically
instead of piggy-backing on the "is_hotplug_bridge" thing, which might be
coincidentally related, but also carries other meanings.

> ---
>  drivers/pci/quirks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a59ad09..8ea99aa 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2923,6 +2923,17 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
>  	dev->is_hotplug_bridge = 1;
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> +/*
> + * Disable runtime PM for PLX Draco (1,2), Capella (1,2) series PCIe switches
> + * to prevent service tools from failing to access hardware registers.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8712, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8733, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8734, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8780, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8796, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9781, quirk_hotplug_bridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9797, quirk_hotplug_bridge);
>  
>  /*
>   * This is a quirk for the Ricoh MMC controller found as a part of some
> -- 
> 2.7.4
