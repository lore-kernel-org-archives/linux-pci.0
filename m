Return-Path: <SRS0=kFL5=6V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2644C4724C
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 21:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A814A21473
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588888137;
	bh=UDftLhDRq8J/qKQjH7s5qaWP3S1ycsCwHQU0ilqkucE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywU5hi3Omyv12hllWfxAIvXLmTjwEuMevTr0QM38CeoDPbfh/IA2HDBT9cpoJmMOl
	 BW3wbZu2Hjbc+Oli1iBMJcDCJQJ+5w0yE7VVE6PcFdcNsDB4x/rIdWqkAMpVEZpiBp
	 Nf7luWU1+5ERxl6Fr+pun5PWO+5zQD/n1D7TSKMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGVsy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 May 2020 17:48:54 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:46300 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVsx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:48:53 -0400
Received: by mail-oo1-f68.google.com with SMTP id x16so1693185oop.13;
        Thu, 07 May 2020 14:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyOvNQA3NJg04Vl3qR1GzrBNciXfg5ndlqMgNxLCmlc=;
        b=DrtSz9kQxPZ8UnwDja9HuH+k2m8CKUiDDQTDjOuOE6uwMJD8PWmu+m/Pl6EDhKbFly
         OAQLVXZQClC7PTW9XepFqbJgLDvl8N6jWipDIF0mtmUldhnuHpTb3S9W1z11h6AOT0Rl
         jFyvKLI1bcPAQcQiG59FZqyolOVxLQwbYEZQxtu+yiwg0G8GIDakcfcSrSBh5UJVkkkq
         58jRGnoF9rBU1mJMHJtGR+uc8hT1+4C5RTBUrTCY+qoLd20Ddq44thUZjBGjGHgFv3bM
         mqaL0Xhgqg8R/mxtyU42ePV2W0F0z5/y84OuplQaK2p2IyTYrMyx3cXFQlWFzdWVmpsn
         58Pw==
X-Gm-Message-State: AGi0PuY8DI8CJZ0AFlgyrhDEGQFx4oTcLwuyBlWJnaPaAhxxxl7UfXJo
        D+dTuhQz/foh/n9hTUOJCw==
X-Google-Smtp-Source: APiQypLUtvbcTjpx1yfWVlo65zNy+xaZJq/gtce6iSrajljmwU9lTh5B9bBFI0KXlmfUjhwEd5baxg==
X-Received: by 2002:a4a:d8d7:: with SMTP id c23mr13689851oov.8.1588888132533;
        Thu, 07 May 2020 14:48:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w205sm1725186oif.26.2020.05.07.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:48:51 -0700 (PDT)
Received: (nullmailer pid 32707 invoked by uid 1000);
        Thu, 07 May 2020 21:48:51 -0000
Date:   Thu, 7 May 2020 16:48:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-pci@vger.kernel.org, tim.gover@raspberrypi.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/4] soc: bcm2835: Add notify xHCI reset property
Message-ID: <20200507214850.GA32592@bogus>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  5 May 2020 18:13:14 +0200, Nicolas Saenz Julienne wrote:
> The property is needed in order to trigger VL805's firmware load. Note
> that gap between the property introduced and the previous one is due to
> the properties not being defined.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/soc/bcm2835/raspberrypi-firmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
