Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37110C07E99
	for <linux-pci@archiver.kernel.org>; Mon, 12 Jul 2021 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E50061003
	for <linux-pci@archiver.kernel.org>; Mon, 12 Jul 2021 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhGLODD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:03:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:18719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbhGLODD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 10:03:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209959272"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="209959272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:00:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="429654968"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:00:12 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2wTf-00CFce-2h; Mon, 12 Jul 2021 17:00:07 +0300
Date:   Mon, 12 Jul 2021 17:00:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_HOST)
Message-ID: <YOxK5zyMIUr1NF2F@smile.fi.intel.com>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 23, 2021 at 05:01:02PM +0300, Andy Shevchenko wrote:
> First of all, the "depends on" is no-op in the selectable options.
> Second, no need to repeat menu dependencies (PCI).
> 
> Clean up the users of PCIE_DW_HOST and introduce idiom
> 
> 	depends on PCI_MSI_IRQ_DOMAIN
> 	select PCIE_DW_HOST
> 
> for all of them.

Any comments on the series?

-- 
With Best Regards,
Andy Shevchenko


