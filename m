Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB4C7EE25
	for <linux-pci@archiver.kernel.org>; Fri,  9 Jun 2023 08:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjFIIGr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjFIHzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 03:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB83AAC;
        Fri,  9 Jun 2023 00:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA326515C;
        Fri,  9 Jun 2023 07:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7317C433EF;
        Fri,  9 Jun 2023 07:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686297209;
        bh=L39bRnVk+fthMiFdoFkMyKIU0XbPQZaAMaVHuaQP/98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRRvAZDv/wtHXxUnOhzMjXxKsrOy/rK3FxSXXdN4J0Z3eWdHgSFAkZrzf1cmxvQRP
         5rK2a8FMVsjYXlMB3T2N/6BaLcOF0lHAHYu/9qPbPrWHxrIui6dOmM0iCM49Ncaena
         eQRDND3IWWBsGQfV5aF2KEJz+vgx0WmHe2sKri3QPBt6ymuSuGlr1R9kevcjY7eutW
         kbeT/dODIUeoXCNBLSSXHWEqBFtG4mh1lwPFptGh4dnlMl3o2LXWbxGo1/0eQ6Rrt0
         wtMaaNbSqoV4dcv8I4Bro78X/CljQHuJb4OxBPTNKoIU7S3ZCvmDaKBCOsEZuComlt
         zf4kHX6kiylHA==
Date:   Fri, 9 Jun 2023 09:53:22 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dlemoal@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v6 8/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <ZILacq9kIG21cI3O@lpieralisi>
References: <20230607204923.GA1174664@bhelgaas>
 <20230607211941.GA1176583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607211941.GA1176583@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 04:19:41PM -0500, Bjorn Helgaas wrote:
> [+cc Yang Li, sorry I didn't notice your patch earlier:
> https://lore.kernel.org/r/20230607093514.104012-1-yang.lee@linux.alibaba.com]
> 
> I think we can squash this into the original commit since it hasn't
> gone upstream yet.  Also note that removing the dev_err() apparently
> makes "dev" unused, so we'd have to remove that as well, based on this
> report [2].
> 
> [2] https://lore.kernel.org/r/202306080418.i64hTj5T-lkp@intel.com

Done.

Thanks,
Lorenzo

> On Wed, Jun 07, 2023 at 03:49:25PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 02, 2023 at 05:17:55PM +0530, Manivannan Sadhasivam wrote:
> > > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > > The driver implements the MHI function over PCI in the endpoint device
> > > such as SDX55 modem. The MHI endpoint function driver acts as a
> > > controller driver for the MHI Endpoint stack and carries out all PCI
> > > related activities like mapping the host memory using iATU, triggering
> > > MSIs etc...
> > > ...
> > 
> > > +static int pci_epf_mhi_bind(struct pci_epf *epf)
> > > +{
> > > ...
> > 
> > > +	ret = platform_get_irq_byname(pdev, "doorbell");
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to get Doorbell IRQ\n");
> > 
> > This dev_err() causes this new warning from the 0-day robot [1]:
> > 
> >   drivers/pci/endpoint/functions/pci-epf-mhi.c:362:2-9: line 362 is redundant because platform_get_irq() already prints an error
> > 
> > Maybe we could drop it?
> > 
> > Bjorn
> > 
> > [1] https://lore.kernel.org/all/20230607163937.ZTc-D%25lkp@intel.com/
