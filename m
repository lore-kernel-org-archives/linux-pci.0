Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2EC37124
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76DA21736
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548118095;
	bh=guIB4MCCt+LSjdRktmu3w5jxVs57UPm+xrt+9vGx9bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SM0+X2sKrRrrfoIiMWtj9LeOkU7MUZ9tBJlapS1RKo9YHBd7xmYSqTsgtmADhqK87
	 8yzkfmjM2HJQzuDbY2zStI9Zb+MoCFfz9R4PU3FZ2dI6fldR9Dj+RN7fitmYWuSQZX
	 zDS4uWjdBXB7Uw1mVRZpSS519GpLWRtn96zuCG0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAVAsJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:48:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40793 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVAsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 19:48:09 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so16030426oie.7;
        Mon, 21 Jan 2019 16:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdz3AySOWc37zBjAyPNQE0AtCWFwpBdKiIR9Wnn8T0k=;
        b=kj5H0LspfEnLSWsY5KIXCL9rZwTT8Qpgmc1bFbtQGcNlIsXTm/f0oGoIQu69UucD7S
         H2HxC1UzVQCaAMJL9lccqofdTqlarc110kRcEhGgzgL+aba5UUxjM7Ra4riDpJScKAe7
         PlenKrJmyEX/SgTXFhkbrYmqtlLghR60Qkq3x1fI7h7Ad9/lt43unc5E9rHG1LEbdE5N
         EzGUiJSqJFp8LQ5iEr0k4X4HKE9zsAi9dSgqeF2j9EktkFwhtNv+79HGSbvFZPFMRimG
         CiicnxBR4d+xCcwD9OHkqj7wn9Mq1GSELbWhZXS6nkBWxE/whY8jslrmmKytrtClY4NW
         h4aA==
X-Gm-Message-State: AJcUukf4lCBYDZMOUreT5cG0XFnYYHCgQkGsRWYkdKIdxLXcpjd3cUTM
        mNnFuhhkLQWzPlnfUC6xvA==
X-Google-Smtp-Source: ALg8bN4meCILV1rwD9Ze0PSruuOmQHSm7866wqkZ90BVvM8+qY7l/POl0NVHJPyg4nUEIr9+VQQjZQ==
X-Received: by 2002:aca:5205:: with SMTP id g5mr7192901oib.149.1548118087942;
        Mon, 21 Jan 2019 16:48:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm6959854oif.0.2019.01.21.16.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:48:07 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:48:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 09/24] dt-bindings: PCI: Document "atu" reg-names
Message-ID: <20190122004806.GA32204@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-10-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-10-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 06:54:09PM +0530, Kishon Vijay Abraham I wrote:
> Document "atu" reg-names required to get the register space for ATU in
> Synopsys designware core version >= 4.80.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index c124f9bc11f3..5561a1c060d0 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -4,8 +4,11 @@ Required properties:
>  - compatible:
>  	"snps,dw-pcie" for RC mode;
>  	"snps,dw-pcie-ep" for EP mode;
> -- reg: Should contain the configuration address space.
> -- reg-names: Must be "config" for the PCIe configuration space.
> +- reg: For designware cores version < 4.80 contains the configuration
> +       address space. For designware core version >= 4.80, contains
> +       the configuration and ATU address space
> +- reg-names: Must be "config" for the PCIe configuration space and "atu" for
> +	     the ATU address space.

I'm pretty sure we already have other platforms with an ATU. Those all 
just represent it with the other ctrl registers? So maybe this is TI 
specific that it is separate. Or should have some conditional like 'if 
the ATU space is separate, the reg-name should be atu'.

>      (The old way of getting the configuration address space from "ranges"
>      is deprecated and should be avoided.)
>  - num-lanes: number of lanes to use
> -- 
> 2.17.1
> 
