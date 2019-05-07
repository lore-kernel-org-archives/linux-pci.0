Return-Path: <SRS0=vOG0=TH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D3C004C9
	for <linux-pci@archiver.kernel.org>; Tue,  7 May 2019 12:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCDB20989
	for <linux-pci@archiver.kernel.org>; Tue,  7 May 2019 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557233397;
	bh=ra7tqOS4f+DfaPqJyjodbcdGsIMeXh1kzglL7pZre8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gaS8YJYkJbGhihfE17s0vSW+szFn8Nwgv8iUgvY2qUvlKcNtXoCPII49k1Mht/2DE
	 6W/863hvu3MuroI9Y/CxpPJw1GNWr5VvydG1WN1Fguy0T82l2llxtE579R/dpkFkQJ
	 eg/rvNeh9xyr8AkdFwuo5Uq+6NvSCMhiFRseyuIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEGMtw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 7 May 2019 08:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfEGMtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 08:49:51 -0400
Received: from localhost (173-24-246-231.client.mchsi.com [173.24.246.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4787205C9;
        Tue,  7 May 2019 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557233391;
        bh=ra7tqOS4f+DfaPqJyjodbcdGsIMeXh1kzglL7pZre8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DERnMfiV/5F1i33PM1E2PdY9rxIepPd+xuFV70+do8LEyO53zDcitWILeCfAYZSLz
         vTQtUao3vDB3wUcd4vY5Ek6kO5CYC6m57j3COVcilc9iR9O5550VGDTSYgtLwwxWVy
         TJZVOU4J42Mp+opl6YYXio2Oxf4mf32uXHbROGvY=
Date:   Tue, 7 May 2019 07:49:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-pci@vger.kernel.org, "Chocron, Jonathan" <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20190507124948.GC156478@google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 01:00:03PM +0100, David Woodhouse wrote:
> On Fri, 2018-03-09 at 13:00 -0600, Bjorn Helgaas wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -540,6 +540,16 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> >         INIT_LIST_HEAD(&bridge->windows);
> >         bridge->dev.release = pci_release_host_bridge_dev;
> >  
> > +       /*
> > +        * We assume we can manage these PCIe features.  Some systems may
> > +        * reserve these for use by the platform itself, e.g., an ACPI BIOS
> > +        * may implement its own AER handling and use _OSC to prevent the
> > +        * OS from interfering.
> > +        */
> > +       bridge->use_aer = 1;
> > +       bridge->use_hotplug = 1;
> > +       bridge->use_pme = 1;
> > +
> >         return bridge;
> >  }
> >  EXPORT_SYMBOL(pci_alloc_host_bridge);
> 
> Is there a good reason why you've done this only for
> pci_alloc_host_bridge() and not also for devm_pci_alloc_host_bridge()? 

No good reason; I just screwed up.  Should be fixed in v5.2 (and marked for
stable):

https://lore.kernel.org/linux-pci/20190318160718.10925-1-jean-philippe.brucker@arm.com

Sorry about that.

Bjorn
