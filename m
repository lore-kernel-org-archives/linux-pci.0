Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3DC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA940218D8
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551137953;
	bh=0QoR7jDmGuAGmar4o4iUzxZvpUyBkVI1kSkxlN+MUgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZHs40qquWrcIJV7lZAuTN/bGVbsXRzBB8Pwwewve/IbP8fCja4SUz6HTh5uAUvCpr
	 wHK8ECA2KyVb0JXXOtj71wgyrMPPxyNJq5P7BDrYQUsTPEmsueKTMEZZ2zXVGqtZNF
	 y0eHup5ndnVVcWE7P9mms02t/zErScDwuVunphb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfBYXjN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:39:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35481 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYXjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 18:39:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id u128so8857885oie.2;
        Mon, 25 Feb 2019 15:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3skj6VwdsJWrWyxCk6FDLLniIo4F8rwKPSvilmcScKo=;
        b=KauMVDOf/l7hC6Zvo0/jmDON/FJr6QACCvL89Evu8N+bdEvfDgzr1eP+uC5YPd4Fi5
         Z2KF4lL6z6YjoZf7qQqbn/g7NhB2+DE2CmRyrUgZnSL2tw7OK5v5FVnoV8IAAQ0+sst5
         G8zRDHwX8OHp+bDOyZzkDCgQLJqte11Wrqa2dTQBtn3/qghuWlouKEtbZgignuY+emgm
         pycQIXVn4AUbRLSi7qo9kZ1jJoFgbD4wwOV9nNjDSbewGn5Ng3E+aoqmhxqG4RlDiqmo
         b1aao+ggkmbz6eH11otn0oib22BPRdlPi982Z3d5X0YyzTVdqBTEcyUsHaztQWl/Y7cN
         pAAA==
X-Gm-Message-State: AHQUAuanXmTLxHFAOX7Vvdgi0sLm1Qj6S3ihQDWJ6pN+82UsoMjpQIXq
        ABxT0OkKbPLfDpZm1p26GQ==
X-Google-Smtp-Source: AHgI3IYSpE6y0er9F0bJSprmJD1D5l1k+sEl4k75wI9rsYhTmTg6RHlQ/9fVBiprcw8TvDJ2Y5A8NA==
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr573604oie.64.1551137951909;
        Mon, 25 Feb 2019 15:39:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n187sm4710378oia.34.2019.02.25.15.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:39:11 -0800 (PST)
Date:   Mon, 25 Feb 2019 17:39:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: imx6q-pcie: Add "pcie_aux" clock for
 imx8mq
Message-ID: <20190225233910.GA2334@bogus>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190212015108.16952-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212015108.16952-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Feb 2019 17:51:07 -0800, Andrey Smirnov wrote:
> Add a binding for an extra clock required on i.MX8MQ.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
