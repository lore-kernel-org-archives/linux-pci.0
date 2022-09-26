Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723EEC32771
	for <linux-pci@archiver.kernel.org>; Mon, 26 Sep 2022 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiIZNCk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Sep 2022 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiIZNCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:02:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17E1759A;
        Mon, 26 Sep 2022 04:34:39 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mbgbc5PCdz688y7;
        Mon, 26 Sep 2022 19:32:44 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 26 Sep 2022 13:33:55 +0200
Received: from [10.48.156.245] (10.48.156.245) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:33:54 +0100
Message-ID: <2f4335ff-133c-18e0-5c14-3fd29bf6503a@huawei.com>
Date:   Mon, 26 Sep 2022 12:33:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v13 1/3] perf tool: arm: Refactor event list iteration in
 auxtrace_record__init()
To:     Yicong Yang <yangyicong@huawei.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "liuqi6124@gmail.com" <liuqi6124@gmail.com>
References: <20220919090045.6778-1-yangyicong@huawei.com>
 <20220919090045.6778-2-yangyicong@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220919090045.6778-2-yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.156.245]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/09/2022 10:00, Yicong Yang wrote:
> From: Qi Liu<liuqi115@huawei.com>
> 
> Add find_pmu_for_event() and use to simplify logic in
> auxtrace_record_init(). find_pmu_for_event() will be
> reused in subsequent patches.
> 
> Reviewed-by: Leo Yan<leo.yan@linaro.org>
> Reviewed-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Signed-off-by: Qi Liu<liuqi115@huawei.com>
> Signed-off-by: Yicong Yang<yangyicong@hisilicon.com>
> ---


Reviewed-by: John Garry <john.garry@huawei.com>
