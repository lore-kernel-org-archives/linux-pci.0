Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0018CCA47E
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jun 2022 14:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiF2OYb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiF2OYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594C20F74;
        Wed, 29 Jun 2022 07:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F9761E91;
        Wed, 29 Jun 2022 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF8C34114;
        Wed, 29 Jun 2022 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656512668;
        bh=k555K7dpoxoX4xP5uNt0S6uUOT34Hsk9/WxKJiiKRao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx212FVJAO6x8DzqBkGfDlhdZULdL5BLsJKkQpke/OpItIoItPodVMRGMEYF6nX1q
         mGDiBmFQGgAcv4Cv88rceSpK3SGEXeJlPGGJaYGBdXvoIw6rrSB80BS1RzChQAPXRw
         /ytRvGHuKg9kEglr9rGbacDtDzgdMNO2SOn0JvkXzJYOikaS7W11nF4xWZhZp8RsSO
         GtW0G/huNn2psrq8n36HiDKo512piO7t7HQkhiTPl2gU6sT2nmDX/75zhG5o0h8af5
         ind0pjn7+9rsBZsMLhh6XSG8xP+1nejWrjIOUaeJBY3nvcwPlG+RplcB/gAnBS01fU
         vk4wh5ssHmuzQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6YcG-0004wR-Fh; Wed, 29 Jun 2022 16:24:28 +0200
Date:   Wed, 29 Jun 2022 16:24:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v15 4/7] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YrxgnME5nsCwFv0L@hovoldconsulting.com>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
 <20220620112015.1600380-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112015.1600380-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 02:20:12PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested-by: Johan Hovold <johan+linaro@kernel.org>
