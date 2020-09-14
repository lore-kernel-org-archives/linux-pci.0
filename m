Return-Path: <SRS0=ryE9=CX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9720C43461
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F547204FD
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 09:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw0rY+eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgINJZm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Sep 2020 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 05:25:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4EDC06174A;
        Mon, 14 Sep 2020 02:25:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so17865743wrm.9;
        Mon, 14 Sep 2020 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1dIPQoWyftPmIiGZ7bnGzVMHwKLifufczvlCSX3EG1w=;
        b=jw0rY+eY22uu18XCKudon3U6qaDho8rSQASPXbM1kk+uiI/Ym5Vp9eYIxzx8KX+QAT
         SMqS4LqpAm1a+bqfONdmKttchrdKwbUELxMvuObXuxSmNxn3onhYhAfAlUlR+3XNBFGv
         cDkJ2Hb0WwEQaEIfFUHFZMq3TPY8FI4La+beet5Tu51LRrcgVKZOLJf5VN+o8J8fuM6E
         TkXvcCe+SfIzu2VaVVUn+OJDr499M08gFdPwJgKnKcJU7zDtsyM0LvjVlxWo2fgbAiHM
         gx39WMCroNvj3O4xZZ1ShVyqPrw8Ko1HV0ryCiaAJ72XRoBk6jrxH7ZZzMu022Avlsy4
         J38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1dIPQoWyftPmIiGZ7bnGzVMHwKLifufczvlCSX3EG1w=;
        b=tg+Oy4C0OzKr8qlt9VAwgg3Ft1vM+XrsuBIucILYTccQG3AzBrVoVCZuzfxzs5VDL0
         wLW9gvp1MKIDV/Wd0bbq3dIdjfwaG9WSsHjGh0wBN+IZQNOYINbf5FzS+t/QPOFR7wtf
         6qxpQcRLm+EiXL9famUAyBVXWCqCFZgJNuThLG8y0BIryO90CsZftAEcmSa/C2YycWNr
         dgFMvWdXwWoOymiDQEAnkJ7WYQQtOT6R7C7eCagZkJSEuRwREudFGZ1R5KFSsXb8zLkd
         5l9iSm6/DK60IOqfo+ymcciZx4VqP/5FobKZDBxKK5qw8mQRN6rwlZfX/FYbIp0X21qj
         S5Yw==
X-Gm-Message-State: AOAM533CWLJVQ6r5jEeV+kKIwnZ8sswdpDtoxhDQqMhLaHr2VKH477KS
        wGn0izkEq8RHrTHLFks6k4YllyWBWAqo6g==
X-Google-Smtp-Source: ABdhPJzp1mmUX8nlci/vOl0gLyKDPoBLlS4rVJjGZY5jj/3T55L4YK892bTlqiJPPr47dPxF7D7ubA==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr15217468wrp.6.1600075538591;
        Mon, 14 Sep 2020 02:25:38 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id x24sm19633590wrd.53.2020.09.14.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 02:25:38 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks consistent
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com>
Date:   Mon, 14 Sep 2020 11:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/09/2020 07:31, Lukas Bulwahn wrote:
> Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
> support") does not mention that linux-mediatek@lists.infradead.org is
> moderated for non-subscribers, but the other eight entries for
> linux-mediatek@lists.infradead.org do.
> 
> Adjust this entry to be consistent with all others.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Maybe rephrase the commit message to something like:
"Mark linux-mediatek@lists.infraded.org as moderated for the MediaTek PCIe host 
controller entry, as the list actually is moderated."

Anyway:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> applies cleanly on v5.9-rc5 and next-20200911
> 
> Ryder, please ack.
> 
> Bjorn, Matthias, please pick this minor non-urgent clean-up patch.
> 
> This patch submission will also show me if linux-mediatek is moderated or
> not. I have not subscribed to linux-mediatek and if it shows up quickly in
> the archive, the list is probably not moderated; and if it takes longer, it
> is moderated, and hence, validating the patch.

I can affirm the list is moderated :)

> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e6e36542c62..83c83d7ef2a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13485,7 +13485,7 @@ F:	drivers/pci/controller/dwc/pcie-histb.c
>   PCIE DRIVER FOR MEDIATEK
>   M:	Ryder Lee <ryder.lee@mediatek.com>
>   L:	linux-pci@vger.kernel.org
> -L:	linux-mediatek@lists.infradead.org
> +L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/pci/mediatek*
>   F:	drivers/pci/controller/*mediatek*
> 
