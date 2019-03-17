Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D3DC10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF6C217F4
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 08:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="p/DsFWIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfCQIEK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 04:04:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33885 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQIEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 04:04:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so9608949lfe.1
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2019 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z+Lfqgd/bBmOpo8j6K1V2cUM9xDec2zJ+xMbUMDIPPo=;
        b=p/DsFWIGxAWS2wI0dJoQjUATDc2hG5B5toLc4awjFDaIAfCOFX9gFNHqSCXiEcvraM
         kO2v6AXJyauPl3kZxlmrHl/yHh6XDIAwLR95DNi2Khc/GxNNESSctphPxDj0ZlkK2rwe
         3QvfCvUo6Yg76KfnkCOJ6m1yh/JHW+frBeC0ITKpZT2KF0GT55qAYlZ3E6o/zBpHTvz2
         7VyTZxv6TxENqMDb+xfWY+izHOCVBmHIlFJ1QoNBVAChf69JhR9P+ZaY/YFl8BBaSt0g
         VfQXN8wWk5+Yigd/PwLLWQF1oF1MoK/50FwGSGVigPVlYxC8s82uH1LOz4Ml+44HM4Xg
         4fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z+Lfqgd/bBmOpo8j6K1V2cUM9xDec2zJ+xMbUMDIPPo=;
        b=WYaVY1zvUy9h5Cb1+4bbRyY9dcdmd6phXmF4fBZmmahVLARs4dw78FKMx9wIhJGvAU
         MMsB/YUSNMim7YXF6pEK9/H5G0qaf9FXs+caK/YhF2YvtFnWaQ6/b+o+/+iA3i77ukHT
         w+SpuzwW/5rDuaX+V7omxZ02BagxCSYOZCksqrJr+DNYJAlCox5kiNG7l7unVyu4sEgB
         uAf20IcPGmkZwBG/tR6yRKKGMwOwiQsa3+ba+jYWCT0H82Bs892homklA8O9gB7mb/5+
         cgSnGUedkaQnIK/+n/NjeR0oZ4CEHRMJTMb34YUrh2qB/656+v1sNMwRs2uKyhI3ASe0
         3CsA==
X-Gm-Message-State: APjAAAX2vLozaEDxocXfQrBXB+fZLC1bAK1lwfyfsERSqUhEcv+mXaWn
        KRO34HxFPR0o/rZX2wzNghIQGQ==
X-Google-Smtp-Source: APXvYqxwgZozuGfyd5RSdBI2su0I+Ncb0VcAn+Wu3SBBit3vMxuW64dDgpajF3ZCXlzkQBgddYvOiw==
X-Received: by 2002:a19:c314:: with SMTP id t20mr6712534lff.114.1552809847887;
        Sun, 17 Mar 2019 01:04:07 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.73])
        by smtp.gmail.com with ESMTPSA id y25sm1331424lja.61.2019.03.17.01.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 01:04:07 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8c60a8c1-76ba-02c5-5306-1122eca2bcbf@cogentembedded.com>
Date:   Sun, 17 Mar 2019 11:03:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190317000608.24881-2-marek.vasut@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 17.03.2019 3:06, marek.vasut@gmail.com wrote:

> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The MSI address can be 64bit. Switch the data type used to hold the
> result of virt_to_phys() to phys_addr_t to reflect it's properties

    Its.

> correctly and program the top 32bits of PA into PCIEMSIAUR.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
[...]

MBR, Sergei
