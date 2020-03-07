Return-Path: <SRS0=Ylk5=4Y=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD14C10DCE
	for <linux-pci@archiver.kernel.org>; Sat,  7 Mar 2020 00:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E199206D5
	for <linux-pci@archiver.kernel.org>; Sat,  7 Mar 2020 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCGAVo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:21:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:37589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCGAVo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 19:21:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 16:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="264626664"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2020 16:21:43 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id B28EA5802A3;
        Fri,  6 Mar 2020 16:21:42 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
References: <20200306232308.GA254242@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <23576842-42a2-238f-4230-efdfa09a8ecc@linux.intel.com>
Date:   Fri, 6 Mar 2020 16:19:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306232308.GA254242@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/6/20 3:23 PM, Bjorn Helgaas wrote:
> No need.  Just take a look at my review/edr branch.  I intend to tweak
> some commit logs and (maybe) make the "clear status" functions void
> since there are only one or two minor uses of the return values.  But
> it's pretty much what I hope to merge.

Your review/edr branch seems to have covered everything.
Thanks for working on it.

>
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

