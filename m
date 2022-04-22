Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0386C433EF
	for <linux-pci@archiver.kernel.org>; Fri, 22 Apr 2022 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445564AbiDVISH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiDVIRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 04:17:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED452E47;
        Fri, 22 Apr 2022 01:14:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5B8751F463D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650615277;
        bh=ybS44P9MMmakQWgzcRRe1GKjiCQ1Y7b4n1Sb0wQeP+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VI1NBwBSfhyzngLnXnZOB7u77+EOStHd17W+lTDF8zVdfmZwJwba+cwmnvDf7yuUY
         X1JE9FQn8FXfQOyUhhekOt5ABbngj4sEwnmstSMuk+XSfzpCGqDKcjUJ/XPBsUN4+9
         luwRyVOtE738zh48axUJFbr32+pELyvoOchijHDcc0k09YfkZ/c7hiSyXyRESioYvL
         popckrnmZX/F/JF8ktgtn/MOUf65IWeMPPXM5lCA3wwbKxUSZ0gFBYOSoYVPUTwYpU
         CyVkMhZovNfISUmKOc9pCSqXjGR20nbgiiFGWBt0WxoAKIUHUTCl1UIWA+eCl3EbA7
         S3Y/FOoKRGGRg==
Message-ID: <612cb22e-7254-b19a-e6e4-6e737092a504@collabora.com>
Date:   Fri, 22 Apr 2022 10:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Update entries to distinguish
 MediaTek PCIe controller
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220422070908.14043-1-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422070908.14043-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 22/04/22 09:09, Jianjun Wang ha scritto:
> Update driver entries in pcie-mediatek-gen3.c to distinguish the
> MediaTek PCIe controllers.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

