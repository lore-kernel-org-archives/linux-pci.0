Return-Path: <SRS0=8YRl=UM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87523C31E45
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5636B21537
	for <linux-pci@archiver.kernel.org>; Thu, 13 Jun 2019 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560459578;
	bh=GZDbaL2k9OYKJxecLPsZwuk4MD+KYk2hYCLWTdmOMus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z+86+gexzu4RR3Spq1Dznfri5wbyXuprvK4AW5l7YChHGh5Uapoys8K1rHXx+n6tX
	 eVWJkzxvX4R6bf9tIVFqnEY7oCzCfc24q50l15br1SIrRB90o7VVap8EFUBGzWiH3d
	 +ATBiRnzX3naQmJVg+6lzxt8p8V490DPnvCqE78c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfFMU7e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:59:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38238 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMU7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 16:59:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so319832qkk.5;
        Thu, 13 Jun 2019 13:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gS1dRlTY9NF+DtZtqCgP0hW6HfTe3z8OAdjlpLy23g=;
        b=O+nUy6mlM1Acb1uaXMUi/UQ3OSQC2PRTJt4JPYscNf+uCfMxsyEt2/fWzy4rJSqoOb
         nJjZHuof4++QM0Unq+bxy4lsjwi+Ro7ZRnebFqw//Pf237DPh4qfZMbfaAA+gZBnH4PZ
         XYPYCEU6z9u0pCwkzS6l0yWNpPrH6tQDwPDKCjVBDRj9m3wv9AirYbq5q1d4PGX5g2w/
         ZLi48FXGU2NxMJ800WA74HCxTZCdDjMnTsgIGaOqulE7TyQaRWTJ4mZMimal+KhG77gL
         Bl1FXLxX5MhUu5uVNegRktKKYsgEG/kUhUtoFQ4ADWeRRAuOYyGWYHk+ur0DJsviWNf6
         xltA==
X-Gm-Message-State: APjAAAX1ZGdE6xetIlwMdVNZ8I8Speyk8xiJT47FAq7G9tU2mHhrK3Bs
        b3U96fWgJcE2l6HobAAqqg==
X-Google-Smtp-Source: APXvYqwDgSwF2dSbUU9DX5FRctIU1tJHSsxmp68E6P2oHV84xkfNE37T6Ih+B8DDpnB0ICrYTBnkTA==
X-Received: by 2002:a37:a48e:: with SMTP id n136mr233325qke.223.1560459572884;
        Thu, 13 Jun 2019 13:59:32 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id a11sm431020qkn.26.2019.06.13.13.59.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:59:31 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:59:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1028a-pcie"
Message-ID: <20190613205930.GA9003@bogus>
References: <20190515072747.39941-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515072747.39941-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 May 2019 15:27:45 +0800, Xiaowei Bao wrote:
> Add the PCIe compatible string for LS1028A
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
