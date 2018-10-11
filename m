Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A481C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2032D213A2
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C658Mv4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2032D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJKWnt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeJKWnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 18:43:49 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA7E2087A;
        Thu, 11 Oct 2018 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539270972;
        bh=DptqWW1WxEbR39mwz5GXwHw+TiQ0F9ApQDa3GVdhhYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C658Mv4pSllGaggmZww19aUbrdj8nngEEdwGId+nmMJWtd7P59XO4181r4yD54u4o
         v8r2R+BDJP4Tt0eL2Tv1r17TzE+17RmiQVu7Jm+zAG+a/1gW86lbXKX5Nol0ktjiuX
         eKnoAqMAf0sYWn1rt9bkfNkkq7h4UBxtDuyjcVQ8=
Date:   Thu, 11 Oct 2018 10:16:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Message-ID: <20181011151610.GM5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
 <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
 <1539114641.8364.34.camel@intel.com>
 <20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com>
 <f16ca9d1-0c78-da00-77e0-c9915782239f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16ca9d1-0c78-da00-77e0-c9915782239f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 07:58:47PM +0800, Dongdong Liu wrote:
> Hi Bjorn
> 
> > commit 15a6711649915ca3e9d1086dc88ff4b616b99aac
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Oct 9 17:25:25 2018 -0500
> > 
> >     PCI/AER: Enable reporting for ports enumerated after AER driver registration
> > 
> >     Previously we enabled AER error reporting only for Switch Ports that were
> >     enumerated prior to registering the AER service driver.  Switch Ports
> >     enumerated after AER driver registration were left with error reporting
> >     disabled.
> > 
> >     A common order, which works correctly, is that we enumerate devices before
> >     registering portdrv and the AER driver:
> > 
> >       - Enumerate all the devices at boot-time
> > 
> >       - Register portdrv and bind it to all Root Ports and Switch Ports, which
> >         disables error reporting for these Ports
> > 
> >       - Register AER service driver and bind it to all Root Ports, which
> >         enables error reporting for the Root Ports and any Switch Ports below
> >         them
> > 
> >     But if we enumerate devices *after* registering portdrv and the AER driver,
> >     e.g., if a host bridge driver is loaded as a module, error reporting is not
> >     enabled correctly:
> > 
> >       - Register portdrv and AER driver (this happens at boot-time)
> > 
> >       - Enumerate a Root Port
> > 
> >       - Bind portdrv to Root Port, disabling its error reporting
> > 
> >       - Bind AER service driver to Root Port, enabling error reporting for it
> >         and its children (none, since we haven't enumerated them yet)
> > 
> >       - Enumerate Switch Port below the Root Port
> > 
> >       - Bind portdrv to Switch Port, disabling its error reporting
> > 
> >       - AER service driver doesn't bind to Switch Ports, so error reporting
> >         remains disabled
> > 
> >     Hot-adding a Switch fails similarly: error reporting is enabled correctly
> >     for the Root Port, but when the Switch is enumerated, the AER service
> >     driver doesn't claim it, so there's nothing to enable error reporting for
> >     the Switch Ports.
> > 
> >     Change the AER service driver so it binds to *all* PCIe ports, including
> >     Switch Upstream and Downstream Ports.  For Switch Ports, enable AER error
> >     reporting.
> > 
> >     Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
> >     Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 90b53abf621d..fe6c16461367 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
> >  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
> >  	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
> > 
> > -	/*
> > -	 * Enable error reporting for the root port device and downstream port
> > -	 * devices.
> > -	 */
> > -	set_downstream_devices_error_reporting(pdev, true);
> > -
> 
> Delete the code will also disable error reporting for the root port as
> the portdrv to Root Port has disabled its error reporting,
> so need to enable enable error reporting for the root port.
> +pci_enable_pcie_error_reporting(pdev);

Oh, you're right, thank you!

I'll post a "v3" to fix this, i.e.,

  v1 - Jon's original post, https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
  v2 - My rework, https://lore.kernel.org/linux-pci/20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com
  v3 - My rework + enable error reporting for Root Ports

Bjorn
