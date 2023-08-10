Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F6C04A6A
	for <linux-pci@archiver.kernel.org>; Thu, 10 Aug 2023 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjHJP6V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjHJP6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 11:58:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFBE7F;
        Thu, 10 Aug 2023 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691683099; x=1723219099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgMLmJNdsuvmJQcqlOslFMkATk/AzqxWQ1RQ/RVSfyo=;
  b=i0bsS+aKDbs7MURukpfp7o0kj3+ZuUDpd28vGBjrecRMCS83JB+ydtGL
   tVSPVT0Lb2Yupvn+nNrkA81vcMs3+wtmrOyez+KlOUys2NJ3e/kvaIr54
   bBRmUeEXTdL3Djyt8yaX+gjSKC3vbkArjtaD38p4pm3/6t8IAdM+pLyMW
   5tD/exT4hOY/i87GO6Xa1EQsSCb9uDtJV4cMWh04fG1AZTHwr9Q0YfvyJ
   3eSYrTvrA/gKhOF5rL8NYtJ97c9xUcg0OpFAZaqL2+U+8z2mSuXR0NTYU
   SHtNbC/G/VXzHrXELOcj69RyI93Grrle5JeY7cNyE6jsHHmuRNn4kI0Vb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361578428"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361578428"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="725876875"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="725876875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 08:58:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU82y-007tTE-2i;
        Thu, 10 Aug 2023 18:58:00 +0300
Date:   Thu, 10 Aug 2023 18:58:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 6/9] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Message-ID: <ZNUJCL27fKpdp8px@smile.fi.intel.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-7-mario.limonciello@amd.com>
 <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
 <a480b846-bd5c-4a98-a1ee-9eacb53816b7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a480b846-bd5c-4a98-a1ee-9eacb53816b7@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 10:54:08AM -0500, Limonciello, Mario wrote:
> On 8/10/2023 10:47 AM, Andy Shevchenko wrote:
> > On Wed, Aug 09, 2023 at 01:54:50PM -0500, Mario Limonciello wrote:

...

> Much appreciated suggestion.  I'll incorporate this in the next version.

I just sent a patch into this thread. Feel free to incorporate.

-- 
With Best Regards,
Andy Shevchenko


