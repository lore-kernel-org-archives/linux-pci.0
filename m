Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64FC37124
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B01C217D4
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548118137;
	bh=hDyljWay4TrClI/lQisUIW4uMsNGtHXq6hmBsKfIV+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mW6kD3mXU/9wD+2OVVrvEC6MWyMLTp/n7sDJKIV155cHxkDU5ilHUcPQMWPf/ZSKW
	 fsOA9ZyP8ddE/phwuAVVJj20sgCrffosRMXYfFQFH7t/lHg02QFbN9mt5oMbaXvPZG
	 QZLANJX8JC625iF+klMs5ERD3t/N/2hppHokpDhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfAVAsv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:48:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43266 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAVAsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 19:48:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so16019240oie.10;
        Mon, 21 Jan 2019 16:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=apg/K9vsqOLZb/5a+8Dv5Qcyv+LHOSOj0Lx4oMOMONE=;
        b=cwWHiaNk6ESUD2KMHaNtf10+jKoMKFlXkNq5nWhchNn8OJltlnU1H8WFn7IVOqlIt3
         sNQRNmN2bBYd+hSHq9OrmJkCuYISgTHEBRwpiTpi2BvboOkq4bxOZAN9gkuBW8RMFFGh
         ue/1Mjft1MYElHsdAOvpJpXPFU0ud/qXeGNSfS74SLpRm7Gn1QppOOnx5wbSMasE37lI
         /6JtKC65RKsoEbI9/HnjG1TLMDYLVRUJibnlLGtP/RlkL8Fv0QV0xtN5pzhZuWR1J0sd
         DLZSm8tAmooIy+gxwE9+xnQ9/xFc5Hq2Lpj7oTAGXOaTQz1d+5wvbR73xRNWqf46Z8JV
         jpng==
X-Gm-Message-State: AJcUukcAKudaOR1gPH4VCJE4AwGshkGjnZY58l99zftZUb/quGH7I/Ic
        EG4olXq6FUkkSLv/bGAjAg==
X-Google-Smtp-Source: ALg8bN7m/yeMIcgXjYHLYG/V1Ig0h8QVNKS+hiEd1RWtWxC2pcdZTNUnb5YUfek+johVISHf4b3R4A==
X-Received: by 2002:aca:3a83:: with SMTP id h125mr6661746oia.308.1548118129926;
        Mon, 21 Jan 2019 16:48:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm6536909otm.63.2019.01.21.16.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:48:49 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:48:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
Subject: Re: [PATCH 13/24] dt-bindings: PCI: Add PCI RC dt binding
 documentation for AM654
Message-ID: <20190122004848.GA26023@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-14-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-14-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 14 Jan 2019 18:54:13 +0530, Kishon Vijay Abraham I wrote:
> Add devicetree binding documentation for PCIe in RC mode present in
> AM654 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
