Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AF6C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C920989
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1OFc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:05:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbfA1OFc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 09:05:32 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA66D45085AD96A1B998;
        Mon, 28 Jan 2019 22:05:29 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 22:05:21 +0800
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
 <7b515af9-b119-bf33-f774-3e091ca30483@kernel.org>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <2871dbbe-fb99-ef33-3787-79a96b274b50@huawei.com>
Date:   Mon, 28 Jan 2019 22:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7b515af9-b119-bf33-f774-3e091ca30483@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sinan
在 2019/1/26 1:09, Sinan Kaya 写道:
> On 1/25/2019 9:28 AM, Dongdong Liu wrote:
>> I want to fix 2 points by the patch.
>>
>> 1. For EP devices (such as multi-function EP device) under the same bus,
>> when one of the EP devices met non-fatal error, should report non-fatal
>> error only to the error endpoint device, no need to broadcast all of them.
>> That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15)
>> have done, but current code PATCH [1] broken this.
>>
>> 2. We found a NULL pointer dereference issue for 74:02.0 device
>> when the device met a non-fatal error (firmware-first) after 4.19.
>> The topology is as below.
>
> Is it possible to split the patches into two to address these two different
> issues?

Good suggestion, will do.

>
> I can understand the first one but second one seems some mystery that needs
> to be explored in detail.
>

  +-[0000:74]-+-02.0  Huawei Technologies Co., Ltd. HiSilicon SAS 3.0 HBA
  |           \-03.0  Huawei Technologies Co., Ltd. HiSilicon AHCI HBA

74:02.0 is a RCiEP, but do not under a root port.
Current code have the issue as the below code, see [DD].
aer_recover_work_func()
     pcie_do_recovery() {

	/*
	 * Error recovery runs on all subordinates of the first downstream port.
	 * If the downstream port detected the error, it is cleared at the end.
	 */
	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
		dev = dev->bus->self;   //[DD]: Here dev will be NULL pointer for 74:02.0（RCiEP）as it does not have a root port.
	bus = dev->subordinate;
  }

We do not have the  NULL pointer dereference issue
before the patch [1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20 .

Thanks,
Dongdong
> .
>

