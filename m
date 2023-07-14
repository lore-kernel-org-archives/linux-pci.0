Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF8EB64DA
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jul 2023 11:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjGNLXP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jul 2023 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjGNLXO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:23:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A902D63;
        Fri, 14 Jul 2023 04:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333793; x=1720869793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dm1Lkb1BqeH3aTuLA6KKqD+HaGLC4eQ3seZpRsghqj0=;
  b=YFHopVmrrIvLuhbPfogIcZ3cPRSTH4vo/SSFdWyBe0YBaNmBAgxtMkbu
   /kw+3UXsdQ0SApj45oNLg40D5mLPSuDTnxW1DsKmwODLi+yqfDM8/jarj
   rVoDyqqdrz4a8HIhCYN4cEiSNwVcphSJYk5iT2lFEGKU4gOeZ9rl/D2Xo
   FZQO/BrG6F/IvTCRWggYbIIlyFpTBLsjl1xD+s/6xQ2dKElKmT+0PW4/E
   y1qgq36Vz0+rES9ERtMMv758JLCFilG4Bebvt9g1unCVwB0U0s565aqJw
   7wvXs+nsgCDIWqEvDqeiXCZi+AeJARbSnmXdBlIu0WgN1RKozmBgJJjyk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364325835"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364325835"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725677390"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="725677390"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2023 04:23:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKGt9-002e0C-3C;
        Fri, 14 Jul 2023 14:23:07 +0300
Date:   Fri, 14 Jul 2023 14:23:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 14/15] ASoC: SOF: Intel: Convert to PCI device IDs
 defines
Message-ID: <ZLEwG1gLRSkyooKe@smile.fi.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
 <20230714185615.370597-15-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714185615.370597-15-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 08:56:14PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_DEVICE_DATA() macro, to simplify declarations.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


