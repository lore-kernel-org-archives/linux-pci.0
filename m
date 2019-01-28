Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9539CC282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794C2177E
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697519;
	bh=557nZhSfIECJ6lJcDGQc756ICmn6sZLxzFE3/SObG2A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=b6fo8Xf7AQBnFSMPUV9c5FVDyTUWKthBw2CmzM59OqjNaBzF48m15LRGwlfijBWMu
	 JNn2kycEt8S0UTCrX92PqpOH0Tdpdym7DAUNiO1vVYuPp9dKIUBgKOtYwygyOBFU4b
	 c6ISyNTtq6+5IsImrQoxwzXsJnPK63NtUIG9933g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfA1RpR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfA1Prw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:52 -0500
Received: from [10.84.151.15] (unknown [167.220.148.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB7B2175B;
        Mon, 28 Jan 2019 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690472;
        bh=557nZhSfIECJ6lJcDGQc756ICmn6sZLxzFE3/SObG2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uRYUZTMydEYkRH5RLjt8xJQkdnZJORgECmU0urMBA8V37iAuUA1BVLgrJxRvtGNaF
         E84KjtgZn8iEKyjSqMrO62vDaqRiwRaLeg12QcdDigREvbfvy48zxDtYWBLPrTcPJb
         cK7O/YO6K9RD8Y2nvqf3/XvijNh8xpCy581ywaOE=
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
 <20190125171713.GB11210@localhost.localdomain>
 <bbe67d36-103c-1cda-4186-128a155e8c0e@kernel.org>
 <f1d8845c-68fc-e0bf-67ed-7348b933eda1@kernel.org>
 <2623f4f8-a832-c517-e5a5-7df2af57bc07@huawei.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <7a2ee482-9f77-0295-6540-e41d85b04297@kernel.org>
Date:   Mon, 28 Jan 2019 10:47:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2623f4f8-a832-c517-e5a5-7df2af57bc07@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/28/2019 9:54 AM, Dongdong Liu wrote:
>> In this case the AER error status of other functions should not report any
>> outstanding event. Please verify this. Otherwise, you are looking at a device quirk. 
>>
> 
> Agree, multiple errors bit can be set, AER driver or firmware will collect the error 
> 
> devices and call pcie_do_recovery() for every error devices.

pcie_do_recovery() is also being called for non-firmware first scenario where OS
has no prior knowledge of which devices are in fault.

> 
> also have different PFs (device numbers are different) under the same bus.
> This case do not need to brodcast all the devices under the same bus.

Even if OS was to call pcie_do_recovery() for other devices, nothing should
happen because the expectation for other devices' AER status register to report
no errors. This is the case we want you to validate. If this is not true, you
are looking at a firmware/HW bug.
