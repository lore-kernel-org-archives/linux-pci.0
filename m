Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0FC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936962147C
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DaWsGAZN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CNorGnML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDCJ0S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:26:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCJ0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:26:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EB8961196; Wed,  3 Apr 2019 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554283577;
        bh=5pA59JnwmAsIHYPGsNGzbkxrq33gDyF3rYN9ztXq8yM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DaWsGAZNS9RWhpc5qWLDmjnyj7oC1kkOFIWNQg2Khk5RrHsPJj7YkWJe5j3fGIXv7
         ZDZMQMPdABnwbLKfrA+9BiSG/kE71NwEUnQ6RjdA9z4sZYSP5SKWsYhQo67qtMCqm3
         v4VaNDTV0xRW8G8f6uiZl22zjqIUD+m1z8Uhwsh4=
Received: from [10.79.129.169] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5DFE60A44;
        Wed,  3 Apr 2019 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554283573;
        bh=5pA59JnwmAsIHYPGsNGzbkxrq33gDyF3rYN9ztXq8yM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CNorGnML2GE8gy3PoPFP69jl7kqOCa0ylFHsG+/UTNkDeI4uBzVYPiTffSMbi5azs
         RLTjDgPi2uHuuq/tTBgA2hW5YvQdnhInN6Bb6AbWTKQB/kKORODaCPD4KAmf67v//K
         wa83bX99madn1WTtWgslmcgMu2xURZjcsyy/5M74=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5DFE60A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
To:     Robin Murphy <robin.murphy@arm.com>,
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
 <e6d2200d-f6b9-3c27-f166-537742b32bfe@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <868a3924-928c-ff23-e39f-8c521eec455a@codeaurora.org>
Date:   Wed, 3 Apr 2019 14:56:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e6d2200d-f6b9-3c27-f166-537742b32bfe@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/2/2019 7:24 PM, Robin Murphy wrote:
> On 30/03/2019 14:18, Vivek Gautam wrote:
>>> You should probably have some "bus" and "iface" clocks too, per the
>>> requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant
>>> for MSM8998?
>>
>> As Jeffrey rightly mentioned, these clocks are not under the control 
>> of Linux.
>> So, we won't need to add clocks to this SMMU.
>
> OK, in that case the "clock-names" part of binding doc probably wants 
> refining to reflect which implementations do actually require clocks.

Certainly.
Marc, do you want to push a patch for the same? Or, let me know I can 
prepare one.

Thanks
Vivek

>
> Robin.
