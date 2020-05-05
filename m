Return-Path: <SRS0=gy3g=6T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE2C47259
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FAD206B9
	for <linux-pci@archiver.kernel.org>; Tue,  5 May 2020 15:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgEEPou (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 May 2020 11:44:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:40262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgEEPos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:44:48 -0400
IronPort-SDR: m0RCNkw9wSsvgHeZIJ2AYP3Znthr8LWjpUi3f2A/zBIdrCtfGqrjNfzJzWdmoJjovqcrqDlCkw
 h+fp5/Tj0+qg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 08:44:47 -0700
IronPort-SDR: c83OjqTcYVomZQyXm54dQMs1rBgzxZvQoFtZROvqLqkq0/IYAm5Lt0YjRj8363HpGn7WPLFAy2
 fskqwk9DhJFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="406884579"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2020 08:44:44 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVzkV-004qBJ-Mo; Tue, 05 May 2020 18:44:47 +0300
Date:   Tue, 5 May 2020 18:44:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI / utils: Add acpi_evaluate_reg() helper
Message-ID: <20200505154447.GU185537@smile.fi.intel.com>
References: <20200505132128.19476-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505132128.19476-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 03:21:25PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a small series adding an acpi_evaluate_reg() helper, note
> the third patch sits on top of a fix for the pinctrl-cherryview
> driver which I recently submitted and which is still finding its
> way upstream.
> 
> Since this is not urgent (just a small code cleanup) I suggest
> that the ACPI people can pick up patches 1-2 and then the last patch
> can be merged post 5.8-rc1, at which point all the dependencies for
> it should have landed already.

Thank you!

Some minor comments to be addressed.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


