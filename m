Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1655C5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39E20870
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E39E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeLKRNc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:13:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:56296 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKRNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 12:13:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 09:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="97923112"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 09:13:31 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 09:13:31 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.212]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 09:13:31 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] avoid indirect calls for DMA direct mappings v2
Thread-Topic: [RFC] avoid indirect calls for DMA direct mappings v2
Thread-Index: AQHUjmAj8kDGnIzvDkKqiRXJVUlss6V4iC+AgAEc+wCAABlGEIAADc/A
Date:   Tue, 11 Dec 2018 17:13:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4922D6@ORSMSX110.amr.corp.intel.com>
References: <20181207190720.18517-1-hch@lst.de>
 <20181210215113.GA22180@agluck-desk> <20181211065112.GA13668@lst.de> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWRlMjM5NWMtOThjMy00ODUyLTk2MGEtMjcxYWRkYzFkMjU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQXJnbkJERjNGR0dvcnFISncrMzRLUzEra3UyK3lnZjhKVDkyNHN6Sk94bXdmODE5XC9ZWE9xTzBCUlFlYys0MSsifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> But that might not be your fault. My ancient system is getting flaky. A v4.19 build that
> has booted before is also resetting :-(

After a power-cycle (and some time to let the machine cool off). System now boots
with your patch series plus the __phys_to_pfn() #define

So if you can figure the right way to fix that, you are good to go.

Tested-by: Tony Luck <tony.luck@intel.com>
