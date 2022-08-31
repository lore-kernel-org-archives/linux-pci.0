Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C81FECAAD1
	for <linux-pci@archiver.kernel.org>; Wed, 31 Aug 2022 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiHaOU4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Aug 2022 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiHaOUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 10:20:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380D3AE7C
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955654; x=1693491654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6fhALA8khW9m42RP56IE3Tnoi9JGZrRS6KikXTN768=;
  b=jJ7EgPHwCShxMk5SgTf3njd7XKpo/mypI7Zp1QyvzN9KM87lhZorzfTw
   Zj9HA5Gt3UxJ6eVy6V7qEdXf0x3w+fltlCsGQW+4OFjO2vnR1MLIeM4Yd
   jzqffwVq/n5cPlTwIBgtU6bGIod+PTvrKxbnziXa2hAVS0px5D8Vv19sY
   jlFVQCDm/dzUWN1rYhT81RWMVNnR8Gn5scy8avRJQ+pr6WgoWLACqC69R
   tqHRTR+BgCBRFJIdS8FCE9aoq816Gm8ZlMEQyVDRPz13WxC4In/mkTQ4G
   Jwi3DBq1wUmmXXVTSj3JDUk8cbp1KElV0gWrGARQ1WafLaBnvCDrD7Q7M
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="359415569"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="359415569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:20:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563047115"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:20:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTOYB-006PkK-0q;
        Wed, 31 Aug 2022 17:18:39 +0300
Date:   Wed, 31 Aug 2022 17:18:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: Distribute available resources for root buses
 too
Message-ID: <Yw9tvs7KjZ4dMAlA@smile.fi.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
 <20220816100740.68667-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816100740.68667-4-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 01:07:37PM +0300, Mika Westerberg wrote:
> Currently we distribute the spare resources only upon hot-add so if
> there are PCI devices connected already when the initial root bus scan
> is done, and they have not been fully configured by the BIOS, we may end
> up allocating resources just enough to cover only what is currently
> there. If some of those devices are hotplug bridges themselves we do not
> leave any additional resource space for future expansion.
> 
> For this reason distribute the available resources for root buses too to
> make this work the same way we do in the normal hotplug case.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> Reported-by: Chris Chiu <chris.chiu@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The diffstat is quite big here but this is due the fact that we move the
> pci_assign_unassigned_root_bus_resources() below
> pci_bridge_distribute_available_resources() so we can call it without
> adding forward declaration.

Perhaps you can split to move and actual update?

-- 
With Best Regards,
Andy Shevchenko


