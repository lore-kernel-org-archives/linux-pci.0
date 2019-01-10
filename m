Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A76C43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAC3214DA
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfAJNM1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:12:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728131AbfAJNM1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 08:12:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CAA8371A133A741B65E;
        Thu, 10 Jan 2019 21:12:25 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 21:12:23 +0800
Subject: Re: [Bug report] PCIe NVME SSD hotplug surprise removal issue
To:     <bhelgaas@google.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>
References: <252786ac-fc97-0c17-4219-d47d1d394def@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <448f8345-b169-dce3-ba19-acaceb5982de@huawei.com>
Date:   Thu, 10 Jan 2019 21:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <252786ac-fc97-0c17-4219-d47d1d394def@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


The hotplug port's POWER_CTRL(ctrl) is false.
pciehp 0000:80:10.0:pcie004: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+

Any suggestion will be appreciated.

Thanks,
Dongdong
ÔÚ 2019/1/10 16:17, Dongdong Liu Ð´µÀ:
> Hi Bjorn, Keith
>
> The lspci -tv topology is as below.
>  +-[0000:80]-+-00.0-[81]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-02.0-[82]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-04.0-[83]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-06.0-[84]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |                   +-08.0-[|           +-0c.0-[86]--
>  |           +-10.0-[87]----00.0  Huawei Technologies Co., Ltd. Device 3714
>
> Then surprise removal 87:00.0 NVME SSD card. The issue is as below.
> The SSD card is still present.
>
> [  178.610064] pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
> [  178.725009] iommu: Removing device 0000:87:00.0 from group 12
> [  178.731278] pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> [  180.731129] pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
> [  182.243128] pciehp 0000:80:10.0:pcie004: Failed to check link status
>
> Then lspci -s 80:10.0 -vvv|grep -i SltSta
> SltSta:Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock
> We can see the card is not present (PresDet-).
>
> Data Link Layer State Changed (link down) event reported
> prior to Presence Detect Changed (card is not present).
> Current code pciehp_handle_presence_or_link_change() seems have such issue.
>
> Any idea to resolve the issue.
>
> Thanks,
> Dongdong
>
>
> .
>

