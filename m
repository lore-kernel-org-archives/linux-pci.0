Return-Path: <SRS0=3fN0=7O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B0C433E1
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24F32085B
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591045005;
	bh=HCz9UVZXCgKN3I40vPGv+sLWdK9si2POu1wW9gPJGjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KswVnCOBev57pk3zHSLpR2BNAOeR4ho9cUIxw/IqtPw1hT33v6VwyALaUzxQ+B1LV
	 HItkeHuLm8cJhKGRSG1yGEHwUbTOpw7A22KVa09ZiOdIg3QTB8eDoTyGjGJ0x+nqgi
	 /I/09TTjB1MIthPAKBboEHyKwvAZzlf+eaNbctkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgFAU4o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:56:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39793 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFAU4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 16:56:44 -0400
Received: by mail-il1-f195.google.com with SMTP id p5so9691152ile.6;
        Mon, 01 Jun 2020 13:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BITL98F0854rJrS/8AfTCyNP8QqONyxvkx/UcCn4Ghw=;
        b=q4bRL5W17pyk3cIFE7+BS7X420whtK0D2FBcPs1fj4UjBJI2CT+/d4G/0EWVFFb8DW
         KvmUzZ56r+kMaLBv1dc0Je/IN42RJ+778VmhwCGSYojuz++Xn85MRkoVyGPMFVXhCF0I
         7XYkkqvyykBavFk2O7ZVx5Hb5nqzYpONWGoj8hVLY0vvcBUSOyGlHe8cRBKVwDMB4Gsg
         26BNtG8X83GHOsXfZ7cjCISpOg8ncXRgCTMjA4znCCAWEQTiBab2tSbHFOlqaWwNoNXj
         TEVuUD2ZsWbYJU/1hvd1fwH3WtM1kCszXxPOJmdTAk72CtIwc4gt8AqPXBY9RGcSboel
         +wCg==
X-Gm-Message-State: AOAM532mk6vz+pJ+fwU+soEjGk7diPP9ODSpBT5vTYu/AXzGX0H3c0iI
        KFUHxZ5Tzc5SMmVr8NPV8A==
X-Google-Smtp-Source: ABdhPJyuuvB/FS5C1fkxV/PLo1BQ2+acgAR7znlJ1e9A2P9nFp3yvEkY29q7lcPuS8p0Oy5o7R46aQ==
X-Received: by 2002:a92:b644:: with SMTP id s65mr23068196ili.205.1591045002799;
        Mon, 01 Jun 2020 13:56:42 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h71sm368014ili.43.2020.06.01.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:56:42 -0700 (PDT)
Received: (nullmailer pid 1480899 invoked by uid 1000);
        Mon, 01 Jun 2020 20:56:40 -0000
Date:   Mon, 1 Jun 2020 14:56:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 01/10] PCI: qcom: Add missing ipq806x clocks in PCIe
 driver
Message-ID: <20200601205640.GA1480847@bogus>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
 <20200514200712.12232-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514200712.12232-2-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 22:07:02 +0200, Ansuel Smith wrote:
> Aux and Ref clk are missing in PCIe qcom driver. Add support for this
> optional clks for ipq8064/apq8064 SoC.
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
