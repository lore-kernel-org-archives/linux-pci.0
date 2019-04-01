Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BCC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 10:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3C820883
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 10:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfDAKjf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:39:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:43040 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDAKjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 06:39:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B1FED20907;
        Mon,  1 Apr 2019 12:39:33 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id A1AAD20429;
        Mon,  1 Apr 2019 12:39:33 +0200 (CEST)
Subject: Re: [PATCH v5] PCI: qcom: Use default config space read function
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
 <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
 <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
 <20190329163808.GB8768@e107981-ln.cambridge.arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <891b4d8a-f353-993e-62d1-1c1d3c749b4c@free.fr>
Date:   Mon, 1 Apr 2019 12:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329163808.GB8768@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  1 12:39:33 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/03/2019 17:38, Lorenzo Pieralisi wrote:

> On Mon, Mar 25, 2019 at 04:42:55PM +0100, Marc Gonzalez wrote:
>
>> Move the device class fudge to a proper fixup function, and remove
>> qcom_pcie_rd_own_conf() which has become useless.
>>
>> NB: dw_pcie_setup_rc() already did the right thing, but it's broken
>> on older qcom chips, such as 8064.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>> Changes from v4 to v5: Apply fixup to all qcom chips, the same way it was before
>> (thus the code remains functionally equivalent)
>> Drop Srinivas' Tested-by tag because of the change
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
>>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> Applied to pci/dwc for v5.2, thanks.

Thanks!

Do you push to linux-next? (The patch is not in next-20190401)

Regards.
