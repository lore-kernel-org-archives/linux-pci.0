Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC4AC37124
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D3121721
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548117105;
	bh=IPtXGsL91pfW8SgPsairRpUvuIKPKfH68fmVNeO21/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYcUuKeBv85DWmEvXvouVVmc4wY1vZcV/gHbgTAeWluJUhPCh0tao7w7rKdzEKWNa
	 /rV2WfPhPuSdtXvgODt/0CJ2Jt7yKWhfY2m1iIR1vvPKED94zPgLawAAc/md1/pkG6
	 euLi2YrEcNR9Fxswi8C2LBu3ASjeepFdRvgextgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfAVAbj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:31:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38321 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAVAbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 19:31:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so16006037oii.5;
        Mon, 21 Jan 2019 16:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JWoG3DHHJ3PJYTklhTubbZN/R0wYZS7KWMnjHDZtnIs=;
        b=JsvZpLRBp8P+awBi5RsEvBpD4HBkQmtm+G90KBycpjnFS6vrpRLiCzn28WRHYcitHe
         9blBfPFyu2oGEwO2wgsub4APodyyVGlqvI37SvSXebtfLqqvNo+4d67rhlNn1htGHx9+
         bERw+fATTfrI6GqIKeXrBLsiQImIHIVdsPElO8/u0QQ6DvSL5VVpxAj6YPzLIQRLnqRc
         Y72ccIn4y/EzFcCZcxzjKENgfbEADKDh9bGfk5alasqxNypIA5R6mFzi4Y+6qGONdvHR
         wMe0YU/LbPqGR3Lg37Qpm05aWskIcL5zfav4bBatqZu/EH5rzJdkh2kjdZWjfoopWdVN
         g0kA==
X-Gm-Message-State: AJcUukeaOJ3+Z4jNH0WFVT5nKbwqHCDsRHuC2wtNrzBmzVsOt5jlfnpY
        ak5f2Wmh1gH7mz/fFf/QSQ==
X-Google-Smtp-Source: ALg8bN6rm9MBZBYIOmoNq8rKDAN88J0am2wZTgXOQfF4BF4TGfZ8w7fAOQ2gKlwNHvMyoL8wkTI4uQ==
X-Received: by 2002:aca:b102:: with SMTP id a2mr7204461oif.180.1548117098243;
        Mon, 21 Jan 2019 16:31:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k130sm7158547oia.47.2019.01.21.16.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:31:37 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:31:36 -0600
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
Subject: Re: [PATCH 03/24] dt-bindings: PCI: keystone: Add "reg-names"
 binding information
Message-ID: <20190122003136.GA30537@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-4-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 14 Jan 2019 18:54:03 +0530, Kishon Vijay Abraham I wrote:
> Add "reg-names" binding information in order for device tree node
> to be populated with the correct register strings. This will break
> old dt compatibility. However Keystone PCI has never worked
> in upstream kernel due to lack of SERDES support. Before SERDES
> support is added, cleanup the Keystone PCI dt-bindngs. This new
> binding will also be used by PCI in AM654 platform.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
