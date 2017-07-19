Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:52040 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbdGSPlZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jul 2017 11:41:25 -0400
Subject: Re: [PATCH 7/7] PCI: dwc: qcom: Add support for IPQ8074 PCIe
 controller
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com,
        sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        smuthayy <smuthayy@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-8-git-send-email-varada@codeaurora.org>
 <20170717220718.GZ20973@minitux> <20170718095814.GE32439@codeaurora.org>
 <20170718164438.GE20973@minitux> <20170719064943.GA29996@codeaurora.org>
 <81d75c74-df15-cc9d-c07c-dd6f5cc30d18@mm-sol.com>
 <20170719092905.GA13546@codeaurora.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <bc243fc5-faa8-e64c-7a1e-6d1140a2e3ba@mm-sol.com>
Date: Wed, 19 Jul 2017 18:41:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170719092905.GA13546@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 07/19/2017 12:29 PM, Varadarajan Narayanan wrote:
> Stan,
> 

<cut>

>> That's nice, but I think we need the Synopsys IP versions too, can you
>> provide such an information and after that we can decide how the names
>> should look like.
> 
> Sorry, I posted v2 before I saw this e-mail. Will post v3 based
> on what naming style is decided.
> 
> The SoCs, qcom_pcie_ops version, the block IP version and
> Synopsys IP versions are as follows.
> 
> 	ipq8064 - v0 - 2.1.0 - 4.01a
> 	apq8064 - v0 - 2.1.0 - 4.01a
> 	apq8084 - v1 - 1.0.0 - 4.11a
> 	msm8996 - v2 - 2.3.2 - 4.21a
> 	ipq4019 - v3 - 2.4.0 - 4.20a
> 	ipq8074 - v4 - 2.3.3 - 4.30a

I'm not sure, with Synopsys versions the mess becomes bigger.

So I tend to agree with qcom versions (because this driver taking care
of qcom wrappers over Synopsys IP) plus comments about Synopsys version
used for this particular SoC, just for completeness.


regards,
Stan
