Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F2EB64DC
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jul 2023 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjGNMf0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jul 2023 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjGNMfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:35:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A23173B;
        Fri, 14 Jul 2023 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689338125; x=1720874125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qj1aaPyREzZcYjVK+fmXUh6iHLqnHWfOUSr3l9RvmIM=;
  b=lFMv8fHzaFqMeNAH8mOzznSYjcjEV/HRXvZ90bZIUaNcfIdfDqriYeO0
   LGsbLpAzr4b/NOhs+6rWpZ/lIbf6VsAqYwla+L9gygGkImmRv4Cy/lHCM
   /gzEmmad8UQqp1TH2ldYKMVHUxQzEzVkIm/JoG9NrxlvjyWZ+jVZN9xpA
   Y3zIahhjCk08Fo60wkLYK8Bec3CZQI62rJA8OKS1oLyHYGHsR4IJOAn9K
   DwCp1ctVGFYxAyuD0IGTHfY3AOSh4yizymscKLdQUNJ9ASh9Y39j+3iJR
   NcXEU261XlBsJjLms9oGCtficy7Z5KW5AmKKyR9Ck1Pmsqjkhjt53bb8V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="369012253"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="369012253"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787840574"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="787840574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 05:35:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qKI11-002exN-2W;
        Fri, 14 Jul 2023 15:35:19 +0300
Date:   Fri, 14 Jul 2023 15:35:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v3 03/15] ASoC: SOF: Remove unused Broxton PCI ID
Message-ID: <ZLFBBzmJXgXeWZ0y@smile.fi.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
 <20230714202457.423866-4-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714202457.423866-4-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 10:24:45PM +0200, Amadeusz Sławiński wrote:
> Current code references 0x1a98 which is BXT-M (not -T as it is
> commented) and it's an RVP, BXT-M B0 to be specific. From what we know
> no BXT is available on market.

...

>  sound/hda/intel-dsp-config.c  | 7 -------
>  sound/soc/sof/intel/pci-apl.c | 2 --

I dunno how SOF and HDA are related to each other, but in the next patch you
also do something about HDA, either group all of them, or split HDA, or split
on per file basis. I'm not familiar with the relationship between them up to
you which way you choose.

-- 
With Best Regards,
Andy Shevchenko


