Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E652AC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA642087F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAGW0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:26:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50556 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfAGW0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 17:26:46 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a9094d0a3f24be5e; Mon, 7 Jan 2019 23:26:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "PCI/PME: Implement runtime PM callbacks"
Date:   Mon, 07 Jan 2019 23:26:00 +0100
Message-ID: <34380094.uq4NseSssK@aspire.rjw.lan>
In-Reply-To: <20190107143959.75267-2-mika.westerberg@linux.intel.com>
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com> <20190107143959.75267-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, January 7, 2019 3:39:58 PM CET Mika Westerberg wrote:
> This reverts commit 0e157e52860441cb26051f131dd0b5ae3187a07b.
> 
> Heiner reported that the commit in question prevents his network adapter
> from triggering PME and waking up when network cable is plugged.
> 
> The commit tried to prevent root port waking up from D3cold immediately
> but looks like disabing root port PME interrupt is not the right way to
> fix that issue so revert it now. The patch following proposes an
> alternative solution to that issue.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
> Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pcie/pme.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 0dbcf429089f..1a8b85051b1b 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -432,31 +432,6 @@ static void pcie_pme_remove(struct pcie_device *srv)
>  	kfree(get_service_data(srv));
>  }
>  
> -static int pcie_pme_runtime_suspend(struct pcie_device *srv)
> -{
> -	struct pcie_pme_service_data *data = get_service_data(srv);
> -
> -	spin_lock_irq(&data->lock);
> -	pcie_pme_interrupt_enable(srv->port, false);
> -	pcie_clear_root_pme_status(srv->port);
> -	data->noirq = true;
> -	spin_unlock_irq(&data->lock);
> -
> -	return 0;
> -}
> -
> -static int pcie_pme_runtime_resume(struct pcie_device *srv)
> -{
> -	struct pcie_pme_service_data *data = get_service_data(srv);
> -
> -	spin_lock_irq(&data->lock);
> -	pcie_pme_interrupt_enable(srv->port, true);
> -	data->noirq = false;
> -	spin_unlock_irq(&data->lock);
> -
> -	return 0;
> -}
> -
>  static struct pcie_port_service_driver pcie_pme_driver = {
>  	.name		= "pcie_pme",
>  	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> @@ -464,8 +439,6 @@ static struct pcie_port_service_driver pcie_pme_driver = {
>  
>  	.probe		= pcie_pme_probe,
>  	.suspend	= pcie_pme_suspend,
> -	.runtime_suspend = pcie_pme_runtime_suspend,
> -	.runtime_resume	= pcie_pme_runtime_resume,
>  	.resume		= pcie_pme_resume,
>  	.remove		= pcie_pme_remove,
>  };
> 


