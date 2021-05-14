Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4DC433ED
	for <linux-pci@archiver.kernel.org>; Fri, 14 May 2021 14:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EA561490
	for <linux-pci@archiver.kernel.org>; Fri, 14 May 2021 14:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhENOyH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 May 2021 10:54:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38033 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234604AbhENOyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 10:54:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 177045C08CD;
        Fri, 14 May 2021 10:52:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 May 2021 10:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=G
        RZ34JbeiaYiaTG5LS+UHZ1sxnV9iyAnujZBzbjf1cM=; b=PAK1was+pXGI0oDP+
        9FWsBtWsBJANMG75FbH6UyiJpkcl4D8HkkSVgJvQD7C7ZZS5qGf+yozYe96dzA98
        +4/5hLfb6EdAXDKfcnnQnxZ4Ct6csI/LzV1RZnnoH9b11/RIb7lXGo7yP4qcdBpc
        pnKBkmIwE9VDZf7r+1kyRmC8jmQJdqn2qUtMOnxX/DoyEwwt/jKuIXPznb8aZDYf
        K1Ps/ZhfeCEFdbvPw+eBLD1xBfeXzB82j9mkXatGB37vUiedLDRAQ0ICBdEDafJl
        5D5/Z8cHlD+OHLUfy1dnhDkkCM9BTa/oyyWbkH0VvEkWB0von3ZDco0mqm3rMSGR
        qZbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=GRZ34JbeiaYiaTG5LS+UHZ1sxnV9iyAnujZBzbjf1
        cM=; b=DM0BVOf9J/zmz2mUS0ht1pZiJDU3A9v70PC1gCrickUp7mDr9hPWssacL
        70NBDHMmc3pwu60OquRS+2bIgaq8Iog1DOZuq9Pbyt5hO/pkmU4XkO+t6SIhM1pE
        poCm2Vu+PQ6nEr7yM1xUptbsaIpCliU+/rqcXlWItwlFKmLfTaJAPJ9VrE2F4Xgs
        2rCMZ/0f9jkXBK7Jp/LOD8kWuHqYeP9IjgoqegrRvFAo+2V5l9U66X4nZriSr2jv
        T2RmSHcUTIdUnAeIDM8W3TNXUqPUp1h028Xmi9bIFf8Oo9gZKLorkOLDwk8DOMJG
        yrRAlADWeA3RVTfPVM11RBiJ99tYw==
X-ME-Sender: <xms:xo6eYPGXZJmDLYio3-6c1E5go4kB61Dr4rS2_MtC6Uq8YcGZ3u3Phg>
    <xme:xo6eYMVTeQgXTxB3z_gdsKJz0vfNQ5yJi_ac4NVC8Al9w7zSdxutOMTk1zLF6bANz
    OOseig-NE7KXqHpaNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehjedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefleduiedtvdekffeggfeukeejgeeffeetlefghfekffeuteei
    jeeghefhueffvdenucfkphepudekfedrudehiedrfeelrdeltdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:xo6eYBIB6KP-zh2XS1XGd3Emb2icjWh_zPb4sLm55C1I0bvwUz7egw>
    <xmx:xo6eYNEMOhgJNRjNBqOJ_pVxRYwmwz9zCLcNXQ0S4TnhnXxbA4d8jg>
    <xmx:xo6eYFX_KsNu2wuBfs1h9RkvTXznr-lpCJ7_Z2wxc-wO-SYKjxopiA>
    <xmx:x46eYCjCNEw29RFKsJ20hiZZEmuQVSMcnj3obVWAsTWirHyk6U-tYA>
Received: from [192.168.1.200] (unknown [183.156.39.90])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 14 May 2021 10:52:51 -0400 (EDT)
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-5-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c3de05bd-91c9-dcd7-5b9a-87de91e480bf@flygoat.com>
Date:   Fri, 14 May 2021 22:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514080025.1828197-5-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2021/5/14 16:00, Huacai Chen Ð´µÀ:
> From: Jianmin Lv <lvjianmin@loongson.cn>
>
> In LS7A, multifunction device use same pci PIN and different
> irq for different function, so fix it for standard pci PIN
> usage.

Hmm, I'm unsure about this change.
The PCIe port, or PCI-to-PCI bridge on LS7A only have a single
upstream interrupt specified in DeviceTree, how can this quirk
work?

Thanks.

- Jiaxun

>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

