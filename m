Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2368C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87230213A2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCMUkP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:40:15 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:43578 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCMUkP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 16:40:15 -0400
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id B6DBE19F5A8;
        Wed, 13 Mar 2019 21:39:51 +0100 (CET)
Subject: Re: [PATCH v2] PCI: qcom: Use default config space read function
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
Date:   Wed, 13 Mar 2019 21:39:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/03/2019 19:29, Srinivas Kandagatla wrote:

> On 13/03/2019 11:45, Marc Gonzalez wrote:
>
>> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
>> because dw_pcie_setup_rc() already does the right thing:
>>
>> 	/* Program correct class for RC */
>> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>> Changes from v1 to v2: Completely drop qcom_pcie_rd_own_conf
>> Srinivas, could you test this patch on apq/ipq8064?
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 17 -----------------
>>   1 file changed, 17 deletions(-)
>>
> I tried this patch on IFC6410 board which has APQ8064, and the pci does 
> not work anymore after applying this patch.
> 
> non-working output of 'lspci -vvv' 
> https://paste.ubuntu.com/p/ndmdsW4zkJ/ and bootlog 
> https://paste.ubuntu.com/p/CqVzGymnq8/
> 
> working without patch : https://paste.ubuntu.com/p/TJm4hgjGW4/
> 
> I have not debugged it any further other than just testing the patch.
> Let me know if you need any more dumps for more debug.

Could you pastebin the output of lspci -vvv -n in the working case?

I think that programming the device class might not work on APQ8064,
and therefore that platform requires the quirk.

So maybe I can add the quirk back, just for APQ8064?

Regards.
