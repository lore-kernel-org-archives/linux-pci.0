Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1792C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AA021924
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfBOK1H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:27:07 -0500
Received: from foss.arm.com ([217.140.101.70]:57706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBOK1G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 05:27:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3971BA78;
        Fri, 15 Feb 2019 02:27:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4BAF3F557;
        Fri, 15 Feb 2019 02:27:03 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:26:58 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
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
Message-ID: <20190215102657.GA26740@e107981-ln.cambridge.arm.com>
References: <cover.1548489092.git.m.maya.nakamura@gmail.com>
 <2fa660dc51189316590021c4ee8aeaac79b8270f.1548489092.git.m.maya.nakamura@gmail.com>
 <BL0PR2101MB09148DD8AB57D5CD2C41A797D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
 <20190129054930.GA1269@m-hyperV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129054930.GA1269@m-hyperV>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 09:49:32PM -0800, Maya Nakamura wrote:
> On Sun, Jan 27, 2019 at 05:11:48AM +0000, Michael Kelley wrote:
> > From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Saturday, January 26, 2019 12:52 AM
> > > 
> > > Remove a duplicate definition of VP set (hv_vp_set) and use the common
> > > definition (hv_vpset) that is used in other places.
> > > 
> > > Change the order of the members in struct hv_pcibus_device so that the
> > > declaration of retarget_msi_interrupt_params is the last member. Struct
> > > hv_vpset, which contains a flexible array, is nested two levels deep in
> > > struct hv_pcibus_device via retarget_msi_interrupt_params.
> > > 
> > > Add a comment that retarget_msi_interrupt_params should be the last member
> > > of struct hv_pcibus_device.
> > > 
> > > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > > ---
> > > Change in v2:
> > > - None
> > > 
> > 
> > Right -- there was no code change.  But it's customary to note that
> > you updated the commit message.
> > 
> Thank you for your feedback. I will edit the change log in v3.
> 
> > Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

I will add Michael's tag to v3 (unless Michael is not happy with that),
it is missing there.

Lorenzo
