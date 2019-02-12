Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC08C4151A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 02:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C72218A3
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 02:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBLCqK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:46:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfBLCqK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 21:46:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7083C9CA701F09DE79C5;
        Tue, 12 Feb 2019 10:46:07 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 10:46:00 +0800
Subject: Re: [PATCH RESEND] PCI/DPC: Fix print AER status in DPC event
 handling
To:     Keith Busch <keith.busch@intel.com>
References: <1549868579-125090-1-git-send-email-liudongdong3@huawei.com>
 <20190211154615.GB4525@localhost.localdomain>
CC:     <helgaas@kernel.org>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <stable@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <93ab1e2f-4813-70d0-0601-39876d845c69@huawei.com>
Date:   Tue, 12 Feb 2019 10:46:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190211154615.GB4525@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith

Many thanks for your review.

在 2019/2/11 23:46, Keith Busch 写道:
> On Mon, Feb 11, 2019 at 03:02:59PM +0800, Dongdong Liu wrote:
>> +static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>> +					  struct aer_err_info *info)
>> +{
>> +	int pos = dev->aer_cap;
>> +	u32 status, mask, sev;
>> +
>> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
>> +	status &= ~mask;
>> +	if (!status)
>> +		return 0;
>> +
>> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
>> +	status &= sev;
>> +	if (status)
>> +		info->severity = AER_FATAL;
>> +	else
>> +		info->severity = AER_NONFATAL;
>> +
>> +	return 1;
>> +}
>> +
>
> You can set info->severity to AER_FATAL since that's the only type we
> enable DPC triggering.

DPC Trigger Enable
01b-DPC is enabled and is triggered when the Downstream Port detects
an unmasked uncorrectable error or when the Downstream Port receives an
ERR_FATAL Message.

DPC Trigger Reason
00b-DPC was triggered due to an unmasked uncorrectable error
reason == 0, due to detect an unmasked uncorrectable error, include non-fatal
and fatal error, so need to get the severity.

>
>>  static irqreturn_t dpc_handler(int irq, void *context)
>>  {
>>  	struct aer_err_info info;
>> @@ -229,9 +251,12 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>  	/* show RP PIO error detail information */
>>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>>  		dpc_process_rp_pio_error(dpc);
>> -	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
>> +	else if (reason == 0 &&
>> +		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>> +		 aer_get_device_error_info(pdev, &info)) {
>>  		aer_print_error(pdev, &info);
>>  		pci_cleanup_aer_uncorrect_error_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>
> Good catch here, but let's clear the pending bits with a single call
> to pci_cleanup_aer_error_status_regs() rather than NONFATAL and
> FATAL separately.

pci_cleanup_aer_error_status_regs() also clear correctable error status.
seems not good enough as reason == 0 means detect an unmasked uncorrectable error.

Thanks,
Dongdong
>
> .
>

