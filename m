Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA06C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93E2133D
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfDBNyd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:54:33 -0400
Received: from foss.arm.com ([217.140.101.70]:51732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDBNyc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 09:54:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6166116A3;
        Tue,  2 Apr 2019 06:54:32 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043773F721;
        Tue,  2 Apr 2019 06:54:29 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
 <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
 <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
 <CAFp+6iHOwW5jJmdVWo-E7154xk2jpR4ZLRoXEJdPwu8_ZJg14Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e6d2200d-f6b9-3c27-f166-537742b32bfe@arm.com>
Date:   Tue, 2 Apr 2019 14:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iHOwW5jJmdVWo-E7154xk2jpR4ZLRoXEJdPwu8_ZJg14Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/03/2019 14:18, Vivek Gautam wrote:
>> You should probably have some "bus" and "iface" clocks too, per the
>> requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant
>> for MSM8998?
> 
> As Jeffrey rightly mentioned, these clocks are not under the control of Linux.
> So, we won't need to add clocks to this SMMU.

OK, in that case the "clock-names" part of binding doc probably wants 
refining to reflect which implementations do actually require clocks.

Robin.
