Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9422DC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DC52086C
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbeLQSfZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:35:25 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34058 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbeLQSfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 13:35:25 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gYxj0-0002I4-Hj; Mon, 17 Dec 2018 11:34:43 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
        Keith Busch <keith.busch@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.umansky@huawei.com,
        Eric.Wehage@huawei.com
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com> <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5bbd3740-0a25-a5a8-bd88-9e29dffdc4d3@deltatee.com>
Date:   Mon, 17 Dec 2018 11:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217181915.GL20725@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Eric.Wehage@huawei.com, alex.umansky@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, mika.westerberg@linux.intel.com, wangzhou1@hisilicon.com, keith.busch@intel.com, linuxarm@huawei.com, will.deacon@arm.com, zhangshaokun@hisilicon.com, mark.rutland@arm.com, linux-pci@vger.kernel.org, jonathan.cameron@huawei.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-17 11:19 a.m., Bjorn Helgaas wrote:
> I *think* drivers/pci/switch/switchtec.c is for a type 0 endpoint that
> happens to be built into the switch, e.g., the type 1 bridge is
> function 0 and the type 0 management endpoint is function 1.  Logan,
> can you confirm/deny?

Yes, that's correct. The upstream port has multiple functions: one for
the bridge and one for the management/NTB endpoint. In the driver, we
have absolutely no reason to touch, or even know about, the bridge
endpoint. This is all very configurable and you can disable either of
the endpoints in the switch's configuration. And the NTB endpoint can
have all the BARS configured with any reasonable amount of BAR space for
memory windows. In the NTB world, there are never enough BARs or address
space within them.

The upstream device, with both functions, looks like this on my system:

02:00.0 PCI bridge: PMC-Sierra Inc. Device 8543 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Bus: primary=02, secondary=03, subordinate=0c, sec-latency=0
	I/O behind bridge: 00002000-00006fff
	Memory behind bridge: f7100000-f78fffff
	Prefetchable memory behind bridge: 0000381f80000000-0000381fc3ffffff
	Capabilities: [40] Express Upstream Port, MSI 00
	Capabilities: [7c] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [8c] Power Management version 3
	Capabilities: [94] Subsystem: PMC-Sierra Inc. Device beef
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Power Budgeting <?>
	Capabilities: [148] #12
	Capabilities: [178] #19
	Capabilities: [1a4] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [1b0] Latency Tolerance Reporting
	Capabilities: [1b8] Access Control Services
	Capabilities: [7f8] Vendor Specific Information: ID=ffff Rev=1 Len=808 <?>
	Kernel driver in use: pcieport

02:00.1 Memory controller: PMC-Sierra Inc. Device 8543
	Subsystem: PMC-Sierra Inc. Device 8543
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Memory at 381fc4000000 (64-bit, prefetchable) [size=4M]
	Capabilities: [40] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [50] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [5c] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [144] Access Control Services
	Kernel driver in use: switchtec
	Kernel modules: switchtec


Logan
