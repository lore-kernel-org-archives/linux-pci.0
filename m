Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCFC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367B8218A6
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WL6glWVN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QcDoHEyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfC2Tmn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:42:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33588 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2Tmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 15:42:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B81AE60767; Fri, 29 Mar 2019 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553888561;
        bh=XcYswFRLs6BGiEh4PoxU/553fWssn+HvDOVHx+7N1F4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WL6glWVN24HAlCJH8MmRpg2Yjav/m4B++CdMeOueEgVesTDfS3TgmnoEtsmbJfbUJ
         ybWrFuTQwIe8nCh6BRRxcfmfE2SAhwZu1RNXo3ZhnbVwexqBNhaN7rHckFm65YxERE
         B2keoWVIEQ3Xq+/XAz/H7L51PRIfsehh8Arj7J64=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 723A260767;
        Fri, 29 Mar 2019 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553888560;
        bh=XcYswFRLs6BGiEh4PoxU/553fWssn+HvDOVHx+7N1F4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QcDoHEyj48/3Al++eA2p+AIMvLiiGp7/JbMetNeyp4wFNUMii4R8gW6Byr/XFfb8E
         /9o3OBU4uPd1PJgXgY1BsHVk5tL/oEotPBmzXtOuX0hBtBG58V02Vhm/bVlB7I4tU/
         kDsCL+eWe2uNZwiJKuBaHYWChqkYGq9QPEPqYtNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 723A260767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
To:     Robin Murphy <robin.murphy@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
 <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
 <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <19de4919-d765-b098-8d83-458567bb03bc@codeaurora.org>
Date:   Fri, 29 Mar 2019 13:42:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/2019 12:29 PM, Robin Murphy wrote:
> On 29/03/2019 10:51, Marc Gonzalez wrote:
>> On 28/03/2019 18:05, Marc Gonzalez wrote:
>>> +
>>> +            #global-interrupts = <0>;
>>> +            interrupts =
>>> +                <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
>>> +                <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
>>> +                <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
>>> +                <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
>>> +                <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
>>> +                <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>>> +        };
>>> +
>>
>> The rest of the node looks fairly straight-forward.
> 
> You should probably have some "bus" and "iface" clocks too, per the 
> requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant 
> for MSM8998?
> 

The clocks that power the SMMU are not under the control of Linux, but 
rather the RPM subsystem.  The interface to them is the interconnect 
framework, which does not yet support 8998 per my understanding.  The 
clocks will always be on, but perhaps not at the best rate for 
performance until the interconnect is brought in.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
