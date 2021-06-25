Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E166C2B9F4
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BBD61963
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 16:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFYQCg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:02:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3305 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFYQCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 12:02:36 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBLzw2hKqz6G8jp;
        Fri, 25 Jun 2021 23:50:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:00:13 +0200
Received: from [10.47.26.115] (10.47.26.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 25 Jun
 2021 17:00:12 +0100
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <485dcb90-01bc-766a-466a-f32563e2076f@huawei.com>
Date:   Fri, 25 Jun 2021 16:53:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.115]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/06/2021 11:59, Qi Liu wrote:
> +
> +/*
> + * Events with the "dl" suffix in their names count performance in DL layer,
> + * otherswise, events count performance in TL layer.
> + */
> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x010004),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x100005),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x010005),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x200004),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x000010),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x020010),
> +	HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x000011),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x010084),
> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x030084),
> +	NULL
> +};
> +
> +static struct attribute_group hisi_pcie_pmu_events_group = {
> +	.name = "events",
> +	.attrs = hisi_pcie_pmu_events_attr,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
> +	HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-15"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:16-23"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
> +	HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
> +	NULL
> +};

I am just wondering how this now works.

So if the user programs the following:
./perf stat -v -e hisi_pcieX/lat_rx_mrd/

Then the value (incremented) in HISI_PCIE_CNT (I think that's the right 
one) is returned as the event count. But one would expect bandwidth from 
that event, while we only return here the delay cycles - how is the 
count in HISI_PCIE_CNT_EXT exposed, so userspace can do the calc for bw?

Thanks,
John
