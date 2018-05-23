Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54873 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeEWKKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 06:10:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id f6-v6so7382690wmc.4
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 03:10:41 -0700 (PDT)
Subject: Re: [RESEND PATCH] PCI: qcom: add runtime pm support to pcie_port
To: Vinod <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180518070736.3003-1-bjorn.andersson@linaro.org>
 <20180523061536.GE20991@vkoul-mobl>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <89bc5fc1-d4a3-4121-208c-546c62138699@linaro.org>
Date: Wed, 23 May 2018 11:10:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180523061536.GE20991@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 23/05/18 07:15, Vinod wrote:
> On 18-05-18, 00:07, Bjorn Andersson wrote:
> 
>> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
>> index 5897af7d3355..3f35098b71b1 100644
>> --- a/drivers/pci/dwc/pcie-qcom.c
>> +++ b/drivers/pci/dwc/pcie-qcom.c
>> @@ -1088,6 +1088,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>   	int ret;
>>   
>> +	pm_runtime_get_sync(pci->dev);
>> +
>>   	qcom_ep_reset_assert(pcie);
>>   
>>   	ret = pcie->ops->init(pcie);
>> @@ -1124,6 +1126,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>   	phy_power_off(pcie->phy);
>>   err_deinit:
>>   	pcie->ops->deinit(pcie);
>> +	pm_runtime_put_sync(pci->dev);
> 
> Wondering if there is a reason for sync put here?
pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
appropriate here I guess as per 
https://www.kernel.org/doc/Documentation/power/runtime_pm.txt

I will respin this patch.

Thanks,
srini


> 
