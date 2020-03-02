Return-Path: <SRS0=J54v=4T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6882C3F2D1
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E520866
	for <linux-pci@archiver.kernel.org>; Mon,  2 Mar 2020 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgCBT7A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:59:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:1308 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBT7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 14:59:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="258070179"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.106]) ([134.134.177.106])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 11:58:59 -0800
Subject: Re: [PATCH 1/5] pci: introduce pci_get_dsn
To:     David Miller <davem@davemloft.net>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        bhelgaas@google.com, jeffrey.t.kirsher@intel.com,
        QLogic-Storage-Upstream@cavium.com, michael.chan@broadcom.com
References: <20200227223635.1021197-1-jacob.e.keller@intel.com>
 <20200227223635.1021197-3-jacob.e.keller@intel.com>
 <20200229.212759.1192215762119235356.davem@davemloft.net>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <e26c36b3-bdd6-2d88-8f38-f59a0c8e2b40@intel.com>
Date:   Mon, 2 Mar 2020 11:58:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229.212759.1192215762119235356.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/29/2020 9:27 PM, David Miller wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> Date: Thu, 27 Feb 2020 14:36:31 -0800
> 
>> +int pci_get_dsn(struct pci_dev *dev, u8 dsn[])
>> +{
>> +	u32 dword;
>> +	int pos;
>> +
>> +
> 
> Just one empty line after the local variable declarations please.
> 
> Thank you.
> 

I've fixed this locally, but am going to wait to see if there is any
further feedback before sending a v2.

Thanks,
Jake
