Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404FC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2F12184E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKJq3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:46:29 -0400
Received: from ns.iliad.fr ([212.27.33.1]:36520 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfDKJq3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 05:46:29 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 951E52007E;
        Thu, 11 Apr 2019 11:46:27 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 79E121FFF7;
        Thu, 11 Apr 2019 11:46:27 +0200 (CEST)
Subject: Re: [PATCH v3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <f9d9afc3-06cb-a0bf-e420-8188f8255a88@free.fr>
 <c41c4057-8352-3b8e-1bdb-631df1ec3cd8@free.fr>
 <a435823e-a5e1-a55c-9040-f494de21323c@mm-sol.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f2e92e73-dcd3-cf41-e175-6769c9bdd217@free.fr>
Date:   Thu, 11 Apr 2019 11:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a435823e-a5e1-a55c-9040-f494de21323c@mm-sol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 11 11:46:27 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/04/2019 11:23, Stanimir Varbanov wrote:

> On 4/11/19 11:50 AM, Marc Gonzalez wrote:
> 
>> +			power-domains = <&gcc PCIE_0_GDSC>;
>> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
>> +			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> 
> Where are pinctrl properties? Probably in board .dts files?

I didn't define any; they appear to be optional.

I have checked that PCIe Fundamental Reset works as expected.

Regards.
