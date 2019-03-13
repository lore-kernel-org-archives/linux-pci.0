Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B8C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607321019
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 22:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMW0b (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:26:31 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:8482 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMW0b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 18:26:31 -0400
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4F5F219F59E;
        Wed, 13 Mar 2019 23:26:07 +0100 (CET)
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
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
Date:   Wed, 13 Mar 2019 23:26:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/03/2019 22:52, Srinivas Kandagatla wrote:

> On 13/03/2019 20:39, Marc Gonzalez wrote:
>
>> Could you pastebin the output of lspci -vvv -n in the working case?
>
> This was already in my original reply:
> working without patch : https://paste.ubuntu.com/p/TJm4hgjGW4/

I needed to see the numeric values, hence the -n flag ;-)

	lspci -vvv -n

Regards.
