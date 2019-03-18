Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3B0C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1A20879
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcA5xbaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfCROj0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:39:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35723 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfCROj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 10:39:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so11402481wrp.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2019 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gp8iUyUi3yCu5Qx+QSk59Sc3wuET4GTXF2MVPnUk19U=;
        b=fcA5xbaOIG+TJKd7Ls2ilSgsSkx6/I4Avm7ZGqSyXibg/5H0AVFrKHZRKW7ICuI0WY
         k9Nfp4CV7b4OC+akJl5uWMYrxOXxtkdnhevcgJPz66SkK1/pbvhkgpjcQqPTCJYpP+xz
         QZEqVm3zuXaHRkEHV3mA7Do6DgL5b+TYeJryD1pAdQhxMgBrloGraHDwacqRp0LbRnws
         9JUIxFUxiPhzpERQdLsVR5H9gH+UR2dGpAycVFDErOeRqwB7e/6I7MJp/r/HS/S77Av+
         m1ElY+54NGB0yioO3+l7mI+qs8t+TpLx6A1qbD7YtSkDIQE3cg2OYq6xg1PwrL2J415u
         lrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gp8iUyUi3yCu5Qx+QSk59Sc3wuET4GTXF2MVPnUk19U=;
        b=PzOX4WvJbI2eD3MQncAFZ/vUYppU3PoZ/sOnrLCWbrByvmtGB9z+Vl3M7wlI/NJFcu
         F6dU7hV0fIITBF/fkXh88WGP8aL+iRFUvgbu8Ef9ROERwFvkfytN+4tn0eIW1LH0YJPY
         o2WECo9v3j7KNP4iI19T7ktNsulI2CRsHM/Jb4Ay7HaPsqNeJHGW8bk/zJDdkqH14kfJ
         qRXHCMftcMMC3zurLHox6oFgVMdsoZb8Sv0CeHRxCKTEIuYOk4MTIp449VxLAtTd8Bo2
         76tgdfOXFtTWNhz6gjaPr9iLKwacql5xxRmOEP3B4DBqPO9UFbfVV5wRRtb103UtzRXR
         TjdQ==
X-Gm-Message-State: APjAAAWCt8hv/fycv6Kh31JALsmUr2w73GBSSxyNJpZ6YKVW4Jzx5iaP
        VcqbgtP/lB9dAKcljDfMYmCG6A==
X-Google-Smtp-Source: APXvYqySbOgND4EwxE2OL0neUCYmsR0fCSpbNdXwFNIyJkeSGuPDBfnAv3XgSLU3nxqrE9X7coDd8A==
X-Received: by 2002:adf:9d86:: with SMTP id p6mr10224883wre.139.1552919964508;
        Mon, 18 Mar 2019 07:39:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c6sm5650208wru.73.2019.03.18.07.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:39:22 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
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
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <aa42765d-00a8-59ea-1a17-de33c2cf3c74@linaro.org>
Date:   Mon, 18 Mar 2019 14:39:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/03/2019 14:28, Marc Gonzalez wrote:
> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
> because dw_pcie_setup_rc() already does the right thing:
> 
> 	/* Program correct class for RC */
> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> 
> However, the above has no effect on 8064, thus a fixup is required.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v2 to v3: Add fixup for 8064 quirk

Tested this on IFC6410 which is based of APQ8064.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks,
srini
