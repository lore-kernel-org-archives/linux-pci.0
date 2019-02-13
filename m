Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B04EC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F343222BB
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 11:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfBMLuu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:50:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52434 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfBMLuu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 06:50:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB0EEA78;
        Wed, 13 Feb 2019 03:50:49 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD4D3F557;
        Wed, 13 Feb 2019 03:50:47 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:50:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "m.maya.nakamura" <m.maya.nakamura@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <20190213115044.GB25260@e107981-ln.cambridge.arm.com>
References: <cover.1548489092.git.m.maya.nakamura@gmail.com>
 <2fa660dc51189316590021c4ee8aeaac79b8270f.1548489092.git.m.maya.nakamura@gmail.com>
 <BL0PR2101MB09148DD8AB57D5CD2C41A797D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
 <20190129054930.GA1269@m-hyperV>
 <20190212163529.GB28306@e107981-ln.cambridge.arm.com>
 <DM5PR2101MB091868E19484F7DCD8C69171D7660@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091868E19484F7DCD8C69171D7660@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 02:20:29AM +0000, Michael Kelley wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  Sent: Tuesday, February 12, 2019 8:35 AM
> >
> > On Mon, Jan 28, 2019 at 09:49:32PM -0800, Maya Nakamura wrote:
> > > On Sun, Jan 27, 2019 at 05:11:48AM +0000, Michael Kelley wrote:
> > > > From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Saturday, January 26,
> > 2019 12:52 AM
> > > > >
> > > > > Remove a duplicate definition of VP set (hv_vp_set) and use the common
> > > > > definition (hv_vpset) that is used in other places.
> > > > >
> > > > > Change the order of the members in struct hv_pcibus_device so that the
> > > > > declaration of retarget_msi_interrupt_params is the last member. Struct
> > > > > hv_vpset, which contains a flexible array, is nested two levels deep in
> > > > > struct hv_pcibus_device via retarget_msi_interrupt_params.
> > > > >
> > > > > Add a comment that retarget_msi_interrupt_params should be the last member
> > > > > of struct hv_pcibus_device.
> > > > >
> > > > > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > > > > ---
> > > > > Change in v2:
> > > > > - None
> > > > >
> > > >
> > > > Right -- there was no code change.  But it's customary to note that
> > > > you updated the commit message.
> > > >
> > > Thank you for your feedback. I will edit the change log in v3.
> > >
> > > > Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> > 
> > Are you really sure there is no behavioural change ? What piece of
> > code allocates hv_vpset.bank_contents[] memory with this patch applied ?
> > 
> > I suspect the current code does not use hv_vpset for this specific
> > reason, ie allocate struct hv_vp_set.masks array memory statically.
> > 
> 
> There is indeed no behavior change.   A full page of memory is
> allocated in hv_pci_probe() so that we can be sure that the Hyper-V
> hypercall arguments don't cross a page boundary.   This page allows
> more than enough space for the hv_vpset.bank_contents[] to grow
> as needed (with one bit allocated in the masks for up to the limit
> of 8192 CPUs allowed by Linux).   A flexible array is used because
> the hv_vpset structure is also used in some MMU hypercalls that
> have two variable size arrays.

I see, thanks for explaining.

Lorenzo
