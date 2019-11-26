Return-Path: <SRS0=NgYY=ZS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1366C432C3
	for <linux-pci@archiver.kernel.org>; Tue, 26 Nov 2019 10:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935B320869
	for <linux-pci@archiver.kernel.org>; Tue, 26 Nov 2019 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKZKEB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:04:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:13816 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfKZKEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 05:04:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 02:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="359121781"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 02:03:45 -0800
Received: from [10.226.39.33] (unknown [10.226.39.33])
        by linux.intel.com (Postfix) with ESMTP id EAF6D5802E4;
        Tue, 26 Nov 2019 02:03:41 -0800 (PST)
Subject: Re: [PATCH v9 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        helgaas@kernel.org, jingoohan1@gmail.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1574314547.git.eswara.kota@linux.intel.com>
 <20191125170345.GB30891@e121166-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <a9ad8973-103d-835e-5ebc-0345a119fc46@linux.intel.com>
Date:   Tue, 26 Nov 2019 18:03:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125170345.GB30891@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/26/2019 1:03 AM, Lorenzo Pieralisi wrote:
> On Thu, Nov 21, 2019 at 05:31:17PM +0800, Dilip Kota wrote:
>> Intel PCIe is Synopsys based controller. Intel PCIe driver uses
>> DesignWare PCIe framework for host initialization and register
>> configurations.
>>
>> Dilip Kota (3):
>>    dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>>    dwc: PCI: intel: PCIe RC controller driver
> "PCI: dwc: ..."
>
> You should follow other commit logs in history as a general
Sure Noted.
> rule to make them uniform, I reordered it.
Thank you,
>
>>    PCI: artpec6: Configure FTS with dwc helper function
>>
>>   .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
>>   drivers/pci/controller/dwc/Kconfig                 |  10 +
>>   drivers/pci/controller/dwc/Makefile                |   1 +
>>   drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
>>   drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
>>   drivers/pci/controller/dwc/pcie-designware.h       |  12 +
>>   drivers/pci/controller/dwc/pcie-intel-gw.c         | 545 +++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h                      |   1 +
>>   8 files changed, 765 insertions(+), 7 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>>   create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
> Applied to pci/dwc, we should be able to merge it for v5.5.

Thank you.

Regards,
Dilip

>
> Lorenzo
