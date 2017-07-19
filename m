Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:56592 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751922AbdGSHMt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jul 2017 03:12:49 -0400
Subject: Re: [PATCH 7/7] PCI: dwc: qcom: Add support for IPQ8074 PCIe
 controller
To: Varadarajan Narayanan <varada@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kishon@ti.com, sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smuthayy <smuthayy@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-8-git-send-email-varada@codeaurora.org>
 <20170717220718.GZ20973@minitux> <20170718095814.GE32439@codeaurora.org>
 <20170718164438.GE20973@minitux> <20170719064943.GA29996@codeaurora.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <81d75c74-df15-cc9d-c07c-dd6f5cc30d18@mm-sol.com>
Date: Wed, 19 Jul 2017 10:12:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170719064943.GA29996@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 07/19/2017 09:49 AM, Varadarajan Narayanan wrote:
> On Tue, Jul 18, 2017 at 09:44:38AM -0700, Bjorn Andersson wrote:
>> On Tue 18 Jul 02:58 PDT 2017, Varadarajan Narayanan wrote:
>>
>>> On Mon, Jul 17, 2017 at 03:07:18PM -0700, Bjorn Andersson wrote:
>>>> On Mon 17 Jul 05:04 PDT 2017, Varadarajan Narayanan wrote:
>> [..]
>>>>
>>>> Can you confirm that this is actually version 4 of this block? Or are we
>>>> just incrementing an arbitrary number here?
>>>
>>> This is not exactly the 4th version of the block. However, it is
>>> a different version than the ones that are already supported in
>>> this driver. Since the existing driver didn't exactly tie it with
>>> the block IP version, I too followed the same versioning
>>> convention.
>>>
>>
>> Do you have a block IP version that you could base your numbering on, to
>> break the trend? (We should go back and fix up the others as well)
> 
> Presently, the driver supports the ipq8064, apq8064, apq8084,
> msm8996, ipq4019 and ipq8074. The SoCs, qcom_pcie_ops version and
> the block IP versions are as follows.
> 
> 	ipq8064 - v0 - 2.1.0
> 	apq8064 - v0 - 2.1.0
> 	apq8084 - v1 - 1.0.0
> 	msm8996 - v2 - 2.3.2
> 	ipq4019 - v3 - 2.4.0
> 	ipq8074 - v4 - 2.3.3

That's nice, but I think we need the Synopsys IP versions too, can you
provide such an information and after that we can decide how the names
should look like.

> 
> I will rename the qcom_pcie_ops structure and related functions
> with the block IP version instead of vX numbering and post the
> patch.



regards,
Stan
