Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF43C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4848820815
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 15:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfACPol (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:44:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfACPok (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 10:44:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3C5A78;
        Thu,  3 Jan 2019 07:44:40 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 286413F575;
        Thu,  3 Jan 2019 07:44:40 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 526771AE0BD1; Thu,  3 Jan 2019 15:44:40 +0000 (GMT)
Date:   Thu, 3 Jan 2019 15:44:40 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linuxarm@huawei.com, Keith Busch <keith.busch@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.umansky@huawei.com,
        Eric.Wehage@huawei.com, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
Message-ID: <20190103154439.GC16311@edgewater-inn.cambridge.arm.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com>
 <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
 <20181218102127.0000018e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218102127.0000018e@huawei.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 10:21:27AM +0000, Jonathan Cameron wrote:
> On Mon, 17 Dec 2018 12:19:15 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Agreed.  I could imagine a drivers/pci/pmu/ directory sort of like
> > drivers/pci/switch/.
> 
> That might work.  Mark, Will what do you think? As long as you and Bjorn
> agree I don't think it'll really matter which one is chosen.
> 
> driver/pci/pmu/ or drivers/perf/pci ?

I have a slight preference for the latter since the perf interface for
PMU drivers is notoriously subtle and error-prone. Keeping PMU drivers
together can be helpful to spot emerging patterns and makes cross-driver
changes easier to co-ordinate.

However, I'll defer to Bjorn since it's only a minor preference. We'd
obviously loop in linux-pci + Bjorn on any new submissions.

Will
