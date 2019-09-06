Return-Path: <SRS0=Mawq=XB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598EC43331
	for <linux-pci@archiver.kernel.org>; Fri,  6 Sep 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABCC20640
	for <linux-pci@archiver.kernel.org>; Fri,  6 Sep 2019 17:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390907AbfIFRsW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:48:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:53543 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfIFRsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 13:48:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 10:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="334957784"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2019 10:48:17 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i6ILH-00035H-Ss; Fri, 06 Sep 2019 20:48:15 +0300
Date:   Fri, 6 Sep 2019 20:48:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ivan Gorinov <ivan.gorinov@intel.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20190906174815.GZ2680@smile.fi.intel.com>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
 <ce4e04ee-9a8f-fbe1-0133-4a18c92dc136@linux.intel.com>
 <CAFBinCABoe89Z9CiG=3Bz6+JoRCYcpxWJ6jzEqMo16SCCoXPmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCABoe89Z9CiG=3Bz6+JoRCYcpxWJ6jzEqMo16SCCoXPmQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 07:17:11PM +0200, Martin Blumenstingl wrote:
> On Fri, Sep 6, 2019 at 5:22 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:

> >      type_index = fwspec->param[1]; // index.
> >      if (type_index >= ARRAY_SIZE(of_ioapic_type))
> >          return -EINVAL;
> >
> > I would not see this definition is user-friendly. But it is how x86
> > handles at the moment.
> thank you for explaining this - I had no idea x86 is different from
> all other platforms I know
> the only upstream x86 .dts I could find
> (arch/x86/platform/ce4100/falconfalls.dts) also uses the magic x86
> numbers
> so I'm fine with this until someone else knows a better solution

Ivan, Cc'ed, had done few amendments to x86 DT support. Perhaps he may add
something to the discussion.

-- 
With Best Regards,
Andy Shevchenko


