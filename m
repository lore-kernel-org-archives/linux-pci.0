Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA6C4332F
	for <linux-pci@archiver.kernel.org>; Mon, 30 Oct 2023 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJ3K3w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Oct 2023 06:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJ3K3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 06:29:50 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A28E;
        Mon, 30 Oct 2023 03:29:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VvAhU0W_1698661780;
Received: from 30.240.112.195(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VvAhU0W_1698661780)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 18:29:42 +0800
Message-ID: <45de80bc-d4ab-44fd-945c-f0ff7ce3b8b0@linux.alibaba.com>
Date:   Mon, 30 Oct 2023 18:29:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <8af04f14-87ae-87aa-7187-55d5450b6d74@quicinc.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <8af04f14-87ae-87aa-7187-55d5450b6d74@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/30 14:28, Krishna Chaitanya Chundru wrote:
> 
...
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>> +{
>> +    struct pci_dev *pdev = NULL;
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    bool notify = false;
>> +    char *name;
>> +    u32 bdf;
>> +    int ret;
>> +
>> +    /* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
>> +    for_each_pci_dev(pdev) {
>> +        u16 vsec;
>> +        u32 val;
>> +
>> +        if (!(pci_is_pcie(pdev) &&
>> +              pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>> +            continue;
>> +
>> +        vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +                        DWC_PCIE_VSEC_RAS_DES_ID);
> 
> We are searching for ALIBABA vendor only  for this capability.
> 
> Can we have a list of vendor ID's and we can check for all those vendors for this capability so that it will be easy to add new vendors in the list
> 
> something like this
> 
> struct vendor_ids {
> 
> int vendor_id;
> 
> };
> 
> struct vendor_ids dwc_ids[] = {
> 
>     {.vendor_id =PCI_VENDOR_ID_ALIBABA },
> 
>      {.vendor_id = XXX},
> 
> };
> 
>     for_each_pci_dev(pdev) {
>         u16 vsec;
>         u32 val;
> 
>         if (!(pci_is_pcie(pdev) &&
>               pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>             continue;
>         for (int i = 0; i < num of elements of dwc_ids < i++) {
>             ---
> 
>         }
>        
>         ---
>     }
> 
> Thanks & Regards,
> Krishna Chaitanya.
> 


Good idea, with vendor_ids, I think it will be easy to extend for other vendors in the future.

Thank you.

Best Regards,
Shuai
