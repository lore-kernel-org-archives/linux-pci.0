Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdGSDIG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 23:08:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170718165644.GF20973@minitux>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-4-git-send-email-varada@codeaurora.org> <20170717223047.GA20973@minitux>
 <20170718085440.GD32439@codeaurora.org> <20170718165644.GF20973@minitux>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 19 Jul 2017 08:38:03 +0530
Message-ID: <CAFp+6iEeu6rubQ+uDauCMbZa6LJoWaNJV04xb5AWL715U-e2Yw@mail.gmail.com>
Subject: Re: [PATCH 3/7] phy: qcom-qmp: Fix phy pipe clock name
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, svarbanov@mm-sol.com,
        kishon <kishon@ti.com>, Stephen Boyd <sboyd@codeaurora.org>,
        fengguang.wu@intel.com, Wei Yongjun <weiyongjun1@huawei.com>,
        linux-pci@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 18, 2017 at 10:26 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 18 Jul 01:54 PDT 2017, Varadarajan Narayanan wrote:
>> On Mon, Jul 17, 2017 at 03:30:47PM -0700, Bjorn Andersson wrote:
> [..]
>> >
>> > This would be the case for any existing dts files, so you're not allowed
>> > to treat this as an error.
>>
>> Since, there are no dts files that presently enable this driver,
>> wouldn't it be better to flag this as an error now itself instead
>> of having to fall back to old handling (which as mentioned above
>> is incomplete). Please let me know.
>>
>
> You're right, hopefully we can introduce it in the upstream dts for
> v4.14...
>
> So it does make sense to fix this up now, rather than live with the
> fallback forever. Can you ensure we get an "ack" from Vivek on this?

Right, it makes sense to get this name from the dt (since same
will be also available in the clock entry), and not assume the name
based on some logic.
And since we don't have any already existing bindings, it's good that
we fix it now.

>
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
