Return-Path: <SRS0=gy3g=6T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F996C47247
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 15:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0963F207DD
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgEEPlg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 May 2020 11:41:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:15617 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgEEPlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:41:36 -0400
IronPort-SDR: kL3i5/dE+LLkejljAgC7LbAIgbaHC7YRtCP3U/CAT+EMJdCzLhn5TukSPoBcSOg9nYkI9+ykp4
 JCp7zv4XH6AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:41:35 -0700
IronPort-SDR: jJkmnoYMRdO4Xpdqwud5ysq5xL3z4x/9rNWJCba2AxrNNR0+EpdOnOfvcS6LFzjp57RSniYg6G
 H4lyf+wXG/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="263209128"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2020 08:41:33 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVzhQ-004q9S-08; Tue, 05 May 2020 18:41:36 +0300
Date:   Tue, 5 May 2020 18:41:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] ACPI / hotplug / PCI: Use the new
 acpi_evaluate_reg() helper
Message-ID: <20200505154135.GQ185537@smile.fi.intel.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505132128.19476-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:27PM +0200, Hans de Goede wrote:
> Use the new acpi_evaluate_reg() helper in the acpiphp_glue.c code.

> -		/* _REG is optional, we don't care about if there is failure */

This may be left.

-- 
With Best Regards,
Andy Shevchenko


