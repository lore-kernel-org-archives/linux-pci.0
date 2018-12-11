Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B4C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1D20879
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E1D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeLKQm5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:42:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:52040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeLKQm5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 11:42:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 08:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="301271612"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2018 08:42:56 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 08:42:56 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.212]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.147]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 08:42:55 -0800
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
Thread-Index: AQHUjmAj8kDGnIzvDkKqiRXJVUlss6V4iC+AgAEc+wCAABlGEA==
Date:   Tue, 11 Dec 2018 16:42:55 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D492095@ORSMSX110.amr.corp.intel.com>
References: <20181207190720.18517-1-hch@lst.de>
 <20181210215113.GA22180@agluck-desk> <20181211065112.GA13668@lst.de>
In-Reply-To: <20181211065112.GA13668@lst.de>
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

> This should fix it:
...
> +#include <linux/dma-noncoherent.h>

Not quite. Still have an issue with __phys_to_pfn(paddr)

Trying ti #include <asm-generic/memory_model.h> gave we a raft of redefined
macros. So I just added

#define      __phys_to_pfn(paddr)    PHYS_PFN(paddr)

to arch/ia64/mm/init.c

That made the build work. But boot spontaneously resets after:

mptsas: ioc1: attaching ssp device: fw_channel 0, fw_id 6, phy 6, sas_addr 0x5000c5000ecada69
scsi 5:0:0:0: Direct-Access     SEAGATE  ST9146802SS      0003 PQ: 0 ANSI: 5
EFI Variables Facility v0.08 2004-May-17
sd 5:0:0:0: [sdb] 286749488 512-byte logical blocks: (147 GB/137 GiB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2
sd 5:0:0:0: [sdb] Attached SCSI disk

But that might not be your fault. My ancient system is getting flaky. A v4.19 build that
has booted before is also resetting :-(

-Tony


