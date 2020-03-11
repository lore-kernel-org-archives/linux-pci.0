X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: by 2002:a05:6638:1b5:0:0:0:0 with SMTP id b21csp1019839jaq;
        Wed, 11 Mar 2020 08:49:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtmSDETMtK+1bWET3H8N+rnQosFqvG8NQS9RV6ZBKhffOZV9ru31hAiyFU0Fr1T+hLV0Jdh
X-Received: by 2002:a9d:18f:: with SMTP id e15mr2740817ote.42.1583941746855;
        Wed, 11 Mar 2020 08:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1583941746; cv=none;
        d=google.com; s=arc-20160816;
        b=XMq84iedX5GhsBcN0lxOuCMs0XJm27Fn3JSAX1AQVplNr/7KClfEBNWSJ89sEo2rb8
         pXWsn4gpfLRdiR05pb9NiJ4tK2DUrEuKYRCosTcq0snxPWHUTkp+xWnH274x9dqCQICA
         6acqx312WvYX9z+JoqMpF4Frs9Gc1hp7v5mgg14587P9y9lYgnDmO1vHJqMoP1lyqyDo
         HmkrWUPQ7Dn3LWH4kf1IcCGNKhOI7nP0fz2Kz9nXJrfx4GtxTkpWkp68E0fNwORSD62k
         NqCx5O6xa01gjD5wuE3krzBwm66AZq9DhUxbMxMiRZDwaF4+RKRonI1ClJR49x9b6U2z
         yW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:dkim-signature:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject;
        bh=ywvixbNO+/N+yt4O8EWdBUGbwryGxLJH9bz6Oivel4E=;
        b=P+6NadMf14RetaQzl+S+f4cPezt2qC5dLqERiEG2tLmcxxKfWroTw8Klriz5g9qQDO
         MKBSefpTLMCe2cOak+0WZCygmLNir+v64VniwoUiOosQj1TWwBXtxxpPZQgJi363czXo
         3MZl5G8Ddl2WnfwhLawUkL8rQM4sPhkFP4kGiwZpnh/iyPjih7S3ylgAqLRlAkQyYXFF
         hw5Pq348IcIGLQ0b5jhjtIRrNYsvUbZ6wBBjWzIYQ52/eZZNoKOyK1JCIBxHR8YlohwU
         EhI109BuyxgSijv2++g4SQ2ZwVWhfMNC1/C5B4105lsI7i7cFkbFL8lTDxUsGgUZKDKX
         AgBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nvidia.com header.s=n1 header.b=FUr9rm3Z;
       spf=pass (google.com: best guess record for domain of linux-pci-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-pci-owner@vger.kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org. [209.132.180.67])
        by mx.google.com with ESMTP id l19si1207369oii.54.2020.03.11.08.48.47;
        Wed, 11 Mar 2020 08:49:06 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of linux-pci-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) client-ip=209.132.180.67;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nvidia.com header.s=n1 header.b=FUr9rm3Z;
       spf=pass (google.com: best guess record for domain of linux-pci-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-pci-owner@vger.kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgCKPsL (ORCPT <rfc822;prsuko@gmail.com> + 99 others);
        Wed, 11 Mar 2020 11:48:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1212 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgCKPsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 11:48:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e69080d0001>; Wed, 11 Mar 2020 08:47:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Mar 2020 08:48:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Mar 2020 08:48:10 -0700
Received: from [10.25.76.193] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar
 2020 15:48:05 +0000
Subject: Re: [PATCH V5 0/5] Add support for PCIe endpoint mode in Tegra194
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200303181052.16134-1-vidyas@nvidia.com>
 <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e49b3c8d-f669-007b-5d35-b8ec4f0529aa@nvidia.com>
Date:   Wed, 11 Mar 2020 21:18:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583941645; bh=ywvixbNO+/N+yt4O8EWdBUGbwryGxLJH9bz6Oivel4E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FUr9rm3ZDnaGkISW2fqFeQV6c9pGe4voXCRhfLm6YSBXRi1w8HYJNa8/I8bfNPJZ0
         hrvJzdioW7B0VV1xDJZl38c+TJcJV+KIjyRryJyYj+nF9IqXosGb48Ru5Rzl7X9PuQ
         xeqi9ruu0zODcJlLs68teXh/cON40ntYNfdx1DuZAkFrt9DKr8AE0NVAcbdP9PcPEg
         y0TF7XWWQpo73L1oNJfHpDQX3qHnrJJ8qYBxYrWerdWJ6trWhksnPj6k/0qaZdNTVF
         PkPHL/U5VcNEI8kIWQRmXkUai/qB8i/kSr2X+0RJw+0Am0rEg3tMthMIaAg/ooMlGN
         n1/Ibsjw1TkiQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
X-TUID: dPn/f81ONJoo



On 3/11/2020 4:22 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 03, 2020 at 11:40:47PM +0530, Vidya Sagar wrote:
>> Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can operate
>> either in root port mode or in end point mode but only in one mode at a time.
>> Platform P2972-0000 supports enabling endpoint mode for C5 controller. This
>> patch series adds support for PCIe endpoint mode in both the driver as well as
>> in DT.
>> This patch series depends on the changes made for Synopsys DesignWare endpoint
>> mode subsystem that are recently accepted.
>> @ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
>> which in turn depends on the patch made by Kishon
>> @ https://patchwork.kernel.org/patch/10975123/
>> which is also under review.
>>
>> V5:
>> * Rebased patch-2 on top of Lorenzo's pci/endpoint branch
>> * Removed unwanted header files inclusion in patch-5
> 
> Applied patches 1,2,5 to pci/endpoint for v5.7, please let me know
> if something is missing.
Thanks Lorenzo and Thierry.

Thanks,
Vidya Sagar

> 
> Thanks,
> Lorenzo
> 
>> V4:
>> * Started using threaded irqs instead of kthreads
>>
>> V3:
>> * Re-ordered patches in the series to make the driver change as the last patch
>> * Took care of Thierry's review comments
>>
>> V2:
>> * Addressed Thierry & Bjorn's review comments
>> * Added EP mode specific binding documentation to already existing binding documentation file
>> * Removed patch that enables GPIO controller nodes explicitly as they are enabled already
>>
>> Vidya Sagar (5):
>>    soc/tegra: bpmp: Update ABI header
>>    dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
>>    arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
>>    arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
>>      platform
>>    PCI: tegra: Add support for PCIe endpoint mode in Tegra194
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 +++-
>>   .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
>>   drivers/pci/controller/dwc/Kconfig            |  30 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c    | 679 +++++++++++++++++-
>>   include/soc/tegra/bpmp-abi.h                  |  10 +-
>>   6 files changed, 916 insertions(+), 45 deletions(-)
>>
>> --
>> 2.17.1
>>
