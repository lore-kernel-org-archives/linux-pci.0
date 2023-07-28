Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B360C001DE
	for <linux-pci@archiver.kernel.org>; Fri, 28 Jul 2023 10:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjG1KSz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjG1KSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 06:18:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D073A89;
        Fri, 28 Jul 2023 03:18:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RC3Rv1cCZz689PQ;
        Fri, 28 Jul 2023 18:15:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:18:41 +0100
Date:   Fri, 28 Jul 2023 11:18:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v6 1/4] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
Message-ID: <20230728111840.000062a9@Huawei.com>
In-Reply-To: <e5f05c67-1b4a-af9a-3e14-8ee4234e36c8@linux.alibaba.com>
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
        <20230606074938.97724-2-xueshuai@linux.alibaba.com>
        <20230727095727.0000190b@Huawei.com>
        <e5f05c67-1b4a-af9a-3e14-8ee4234e36c8@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> >   
> >> +debugging, AER error injection, and collection of statistics. To facilitate
> >> +collection of statistics, Synopsys DesignWare Cores PCIe controller  
> > 
> > "Core's"
> > 
> > (as it belongs to the core rather than intent being that it applies to plural
> > cores?)  
> 
> "Synopsys DesignWare Cores PCIe controller" is from the title from Synopsys
> databook, so I prefer to keep as it is here.

Makes sense to keep them matching.

Jonathan


