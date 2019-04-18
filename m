Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81038C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505B1205F4
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555629855;
	bh=UaxLoQRiyIUjwAaSUqcbVoPYd5elynGr16cbbgYMoZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hO/a5QUEgUJk3wjz/oEPgMsuTsOrEL/YJY9rGL5tE0sUqZnfOlqM/UHDrFqMCbg8M
	 TP/Xt/8d35rC8zrBJ/v+wY/PHPlXtFkLH3WfBGX1H9paQuPwzfO7deRfQbjCA7QabO
	 ThKNibryLfSHmH8VreleiO272kHxY/OYZ68GnDGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfDRXYO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfDRXYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 19:24:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8425221479;
        Thu, 18 Apr 2019 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555629853;
        bh=UaxLoQRiyIUjwAaSUqcbVoPYd5elynGr16cbbgYMoZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+d3cvkw7x0ioaFf+YbMgUQg4NQtDk4JIWyGEQHPXoYJgez24i12BHzineXGoI2LG
         TDr+kQOrKqNqNS1MakdfOdgr3skGvgGiLK2jjG6fz/hUVYJsO9DHvz9IS86tLCm4zN
         lJ00rPHuPACB7jN7erefiLF0i3jWEZxKssVRxl8E=
Date:   Thu, 18 Apr 2019 18:24:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Imre Deak <imre.deak@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Disable bandwidth notification interrupt
 during suspend
Message-ID: <20190418232411.GE126710@google.com>
References: <20190415084142.30897-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415084142.30897-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 11:41:42AM +0300, Mika Westerberg wrote:
> If the bandwidth notification interrupt is left unmasked when entering
> suspend to idle it triggers immediately bringing the system back to
> working state.
> 
> To keep that from happening, disable the interrupt when entering system
> sleep and enable it again during resume.
> 
> Reported-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/portdrv for v5.2, thanks, Mika.

> ---
>  drivers/pci/pcie/bw_notification.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index 4fa9e3523ee1..77e685771487 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -107,11 +107,25 @@ static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
>  	free_irq(srv->irq, srv);
>  }
>  
> +static int pcie_bandwidth_notification_suspend(struct pcie_device *srv)
> +{
> +	pcie_disable_link_bandwidth_notification(srv->port);
> +	return 0;
> +}
> +
> +static int pcie_bandwidth_notification_resume(struct pcie_device *srv)
> +{
> +	pcie_enable_link_bandwidth_notification(srv->port);
> +	return 0;
> +}
> +
>  static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
>  	.name		= "pcie_bw_notification",
>  	.port_type	= PCIE_ANY_PORT,
>  	.service	= PCIE_PORT_SERVICE_BWNOTIF,
>  	.probe		= pcie_bandwidth_notification_probe,
> +	.suspend	= pcie_bandwidth_notification_suspend,
> +	.resume		= pcie_bandwidth_notification_resume,
>  	.remove		= pcie_bandwidth_notification_remove,
>  };
>  
> -- 
> 2.20.1
> 
