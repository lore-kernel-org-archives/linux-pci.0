Return-Path: <SRS0=A4Uv=4X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90644C10F25
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 09:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AFE207FD
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 09:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgCFJis (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:38:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbgCFJis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 04:38:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 783E760514E051BBB7BF;
        Fri,  6 Mar 2020 17:38:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 17:37:19 +0800
Subject: Re: [PATCH 04/11] ACPI/IORT: Check ATS capability in root complex
 node
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <bhelgaas@google.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <linux-doc@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <corbet@lwn.net>, <mark.rutland@arm.com>, <liviu.dudau@arm.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <dwmw2@infradead.org>,
        <amurray@thegoodpenguin.co.uk>, <frowand.list@gmail.com>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-5-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1052d5a3-fb32-4c7c-9b77-e7aa94849cb1@huawei.com>
Date:   Fri, 6 Mar 2020 17:37:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200213165049.508908-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/2/14 0:50, Jean-Philippe Brucker wrote:
> When initializing a PCI root bridge, copy its "ATS supported" attribute
> into the root bridge.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 27 +++++++++++++++++++++++++++
>  drivers/acpi/pci_root.c   |  3 +++
>  include/linux/acpi_iort.h |  8 ++++++++

Acked-by: Hanjun Guo <guohanjun@huawei.com>

