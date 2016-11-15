Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36389 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbcKOQKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 11:10:31 -0500
Received: by mail-wm0-f51.google.com with SMTP id g23so176600861wme.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2016 08:10:30 -0800 (PST)
Subject: Re: [PATCH v4 2/3] PCI: qcom: add support to msm8996 PCIE controller
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-3-git-send-email-srinivas.kandagatla@linaro.org>
 <aa135735-4ff4-06e3-7899-1255a21edfb4@mm-sol.com>
 <f0d9884c-b5f6-e9a8-e814-6dfd632466fc@linaro.org>
 <ea5858f3-19d6-c746-2e95-a64d6a436b38@mm-sol.com>
Cc: robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8d0e9b19-5d6f-8be5-84be-d102817a6b21@linaro.org>
Date: Tue, 15 Nov 2016 16:10:28 +0000
MIME-Version: 1.0
In-Reply-To: <ea5858f3-19d6-c746-2e95-a64d6a436b38@mm-sol.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 15/11/16 15:08, Stanimir Varbanov wrote:
>>> I don't like MSM8996_ prefix. Could you invent a macro which depending
>>> >> on controller selects proper offset?
>> >
>> > maybe some like this ??
>> >
>> > #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2    0x1A8
> No, I wanted to preserve the name of the register offset. By that way in
> the next pcie controller version we do not need to have
> PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V3.
>
> I was thinking for something like
>
> PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT(ver)	\
> 		((ver) == VERSION_1 ? 0x178 : 0x1A8)
>
> But you will need to extend qcom_pcie_ops with new member to store the
> version.
>
> It's up to you ... or we can fix it when new version of the controller
> appear.
TBH, I don't want to add this just for this one case, looks bit over do.
So I skipped to using V2 Suffix.
We can fix later if required.

--srini

