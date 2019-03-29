Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B7BC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AB0206BA
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="Oj5wsHsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfC2PzL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:55:11 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:33671 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfC2PzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 11:55:10 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A92FECE35;
        Fri, 29 Mar 2019 17:55:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1553874907; bh=0OQcb1L9DuMNbj7v2/mLG6m0U/ZzVluwkG8H+Nb+Dqk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Oj5wsHsVdjjO6a0JrVbyfXY4X4WMEs0TH03rB+YA25OWeipDgFzYh+LHWMzf3sKBG
         v/KR0lxYE3a4rwZTqFwWJU9nv04IkFHHQyypG6Ewz247dg/nMVmPuU/uuhncf7gCLA
         ZdyA0Ezyx9gvXNoPj8tsmrjQe5CVaJ/x2CgHkWeQpglv9BqzM8fZBl8R0fHNnC/2VO
         iwNY9a0LX/Sdng8yZPcz78DEe6ZeDMHOun9oepeCpEfoqOtTNWZSTC0VcksUWJHWbK
         fWhj7lpeCai8rtbSsrOwAAt3bEkgPMC4BtxhGnWO3TAxO4avfqPzAW846meAj9kaJa
         64ceuktmnoV0g==
Subject: Re: [PATCH v5] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
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
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
 <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
 <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <9017c41a-a66c-0652-b2aa-6eb6af38c5c9@mm-sol.com>
Date:   Fri, 29 Mar 2019 17:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <66ae38dc-1c0c-5a76-be23-fb87db90b327@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thanks for the patch!

On 3/25/19 5:42 PM, Marc Gonzalez wrote:
> Move the device class fudge to a proper fixup function, and remove
> qcom_pcie_rd_own_conf() which has become useless.
> 
> NB: dw_pcie_setup_rc() already did the right thing, but it's broken
> on older qcom chips, such as 8064.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v4 to v5: Apply fixup to all qcom chips, the same way it was before
> (thus the code remains functionally equivalent)
> Drop Srinivas' Tested-by tag because of the change
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>


-- 
regards,
Stan
