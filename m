Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4431FC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118A320873
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545251939;
	bh=WrewN3pP+xXagxVdkwsPCFljB9lgVCIfSx3Z2tMQQbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pO2UwZEomBCBUeCj7oIrHol7r6K3YgJeH6OYtcPexVqzaRVqKlrahRqRcURkIAghE
	 SkVSsqSQLl6uAl3+L+29nb2LDfqJw3uvgvIWJzt8rEldN5p5nQO8JKNqm8W2fIQ2+0
	 Vc3FQQ6FMkpSFwf2CLu+dV9qiMWewOLyMuIJZNvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeLSUix (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:38:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41728 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSUix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 15:38:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so2712548oii.8;
        Wed, 19 Dec 2018 12:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9EDmUb25eCGRB3VLJKp5doexQ0zWLS4cH4s5eq7g5c=;
        b=HevrCZi/9dEk7TI4LgGYRI2eLbb2G8ZV24C8xVCbqHdVgyIIywado0YJxUEa9JkVrD
         M5wV5/Nc0rTZXJZZUiKWyBwLxAwWwM5jZDjqEOYnS1VOFBaBEHWwKY8Ehf4nPv6gtJAm
         uB+5Dg6MxOwgm253K97B5wCXnalZ0cPWjmqTy0aU9uQ/971/6N2BpL026Sx+852+VnR1
         4DI7qROWYFLNNgxzLS5hrWb4YjXmw+kDt9rx0KIqc/BFHpGr42EXKFzSdfnTfyZAv7+7
         r43oiLFVh/nJKNWXqd6ABQo51W59sGfiqqP2xj3YMOzn+PcrUh03pSPAuJPUJk1lgtrY
         z/Jg==
X-Gm-Message-State: AA+aEWa8l8/LO+2VLy4C/H5c+WkYHFOkqoHIOV5lQ6dpGiprs0qv0fSw
        M7gxSPnL+Ek7KUHUQ3dutA==
X-Google-Smtp-Source: AFSGD/XvKotdNnZpmSD7TKdK4qZuEYF5GqjjNE66L1B4YLvKB4dvjRIVz19SZ5LxL8yHjtyc2M+2jQ==
X-Received: by 2002:aca:49cb:: with SMTP id w194mr240905oia.114.1545251932056;
        Wed, 19 Dec 2018 12:38:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm10399529otp.10.2018.12.19.12.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 12:38:51 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:38:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     ryder.lee@mediatek.com, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        honghui.zhang@mediatek.com, youlin.pei@mediatek.com,
        Jianjun Wang <jianjun.wang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add support for MT7629
Message-ID: <20181219203850.GA31173@bogus>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-2-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544058553-10936-2-git-send-email-jianjun.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Dec 2018 09:09:12 +0800, Jianjun Wang wrote:
> MT7629 is an arm platform Soc which has the same PCIe IP with MT7622.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
