Return-Path: <SRS0=BI5g=7I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0913C433DF
	for <linux-pci@archiver.kernel.org>; Tue, 26 May 2020 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF6C207D8
	for <linux-pci@archiver.kernel.org>; Tue, 26 May 2020 20:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbgEZUX7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 May 2020 16:23:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:17182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389893AbgEZUX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 16:23:58 -0400
IronPort-SDR: ToZMgNggOTMmk36WqF3T/Va8Wb8L0XBrk3uB/MjHGRQ63T+Klw3de8E4X60pFA6S1n7EOk467f
 bcYDVNz42juQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 13:23:58 -0700
IronPort-SDR: bZWk4+f1RUAqJTFyFVwl8JZc4rLRTbebLSxZaSN8DGEI/Le+0XA2o3/bexq4FTA/A5ZkfiMNaW
 0UzdWfESW2Jw==
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="442228673"
Received: from dswadhwa-mobl1.amr.corp.intel.com (HELO [10.212.25.137]) ([10.212.25.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 13:23:57 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Martin =?utf-8?q?Mare=C5=A1?=" <mj@ucw.cz>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        f.fangjian@huawei.com, huangdaode@hisilicon.com
Subject: Re: [PATCH v7 0/2] pciutils: Add basic decode support for CXL DVSEC
Date:   Tue, 26 May 2020 13:23:56 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <9A956B40-0ADC-45DD-9B98-3969C9C77132@linux.intel.com>
In-Reply-To: <mj+md-20200525.103642.86045.nikam@ucw.cz>
References: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
 <mj+md-20200525.103642.86045.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

On 25 May 2020, at 3:37, Martin Mareš wrote:

> Hello!
>
> I applied your patch (by mistake, I applied v6 first, so the vendor ID 
> change
> is a separate commit).
>
> I have cleaned up the code a bit, so that the DVSEC header is not 
> parsed
> multiple times.
>
> Could you also update the cap-dvsec-cxl test to match the new vendor 
> ID?
>
> 			Have a nice day
> 						Martin

Will do.

Thanks!

Sean
