Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B0C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E111217F5
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfH0JOQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:14:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:32104 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfH0JOQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 05:14:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="380850102"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 02:14:15 -0700
Received: from [10.226.39.22] (ekotax-mobl.gar.corp.intel.com [10.226.39.22])
        by linux.intel.com (Postfix) with ESMTP id 121F7580444;
        Tue, 27 Aug 2019 02:14:12 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        hch@infradead.org, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        qi-ming.wu@intel.com
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <f1cb5ba9-b57a-971a-5a2f-1f13e0cc9507@linux.intel.com>
 <CAFBinCDojCN0Gxpa0fyh7t8TdvTLc_dwgJgMxC4PoAszK==BKg@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <c0bb5bcf-6ccb-d155-7184-a7174bb36bd8@linux.intel.com>
Date:   Tue, 27 Aug 2019 17:14:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDojCN0Gxpa0fyh7t8TdvTLc_dwgJgMxC4PoAszK==BKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/27/2019 4:14 AM, Martin Blumenstingl wrote:
> second example: pcie-tegra194 (only in -next, will be part of v5.4)
>    struct tegra_pcie_dw {
>      ...
>      struct dw_pcie pci;
>      ...
>    };
>
> so some drivers store a pointer pointer to the dw_pcie struct vs.
> embedding the dw_pcie struct directly.
> as far as I know the result will be equal, except that you don't have
> to use a second devm_kzalloc for struct dw_pcie (and thus reducing
> memory fragmentation).
Okay, i will change it to "struct dw_pcie pci;"

Thanks for the feedback.

Regards,

Dilip

