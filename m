Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C4C64E90
	for <linux-pci@archiver.kernel.org>; Tue,  1 Dec 2020 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4ABE2086A
	for <linux-pci@archiver.kernel.org>; Tue,  1 Dec 2020 01:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbgLABJx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Nov 2020 20:09:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:62798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgLABJx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 20:09:53 -0500
IronPort-SDR: DSStL4CHiaTcVpH5P8ps+uXFtCwJRQUF8AjR5c9kOhWEF3nc3AJwH7eDr2jySqF+92JbHUiGo7
 tRPIbMCJJ9qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="159794885"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="159794885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 17:09:12 -0800
IronPort-SDR: 2QO5EKwyGtliPdiCa5T0s+N33CDu+ekUx+qgruqo7CxwAHxSrih4iqp/G7eeG9XDYIIf5bDCKR
 Ol0EQQzTOjSA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="364474329"
Received: from rvalimx-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.91.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 17:09:11 -0800
Subject: Re: [PATCH v12 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201201002516.GA1130192@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Message-ID: <35019c15-27da-2ce4-fcd9-94559d39a7ec@intel.com>
Date:   Mon, 30 Nov 2020 17:09:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201002516.GA1130192@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/30/20 4:25 PM, Bjorn Helgaas wrote:
> I think EDR is the same as DPC?
Yes, EDR is same as DPC.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

