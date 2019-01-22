Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90972C37122
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C88217D4
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 00:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548117153;
	bh=rz+/maQz2enAtSLOPmycQo+PLo5eooVOCLEiiT/uR88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WlmEkW3GILu6DpPyz7+DHKz7W8N6vbY4Z+Hml2X+1owpUrhhACpH/bzofSV/7wJbJ
	 86fh+A0RasHJOYIZiIY1DZhcTzYtZSW9b3XbJtHhkUizrLXrGmA2zIeXlEaIkKBZHT
	 tbcZiI13e4hK9mcoW1YXpCz7vFpMy8IXdk8S6EEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfAVAcc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:32:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45492 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 19:32:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so15987357oie.12;
        Mon, 21 Jan 2019 16:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5zXHGW+iRkj12tqNTKOGuFs9OGMy582LkfL8vcrIWE=;
        b=IAZBRfAR+cPJKnsf1EfFZBJpR1F8GIkBg9hgKLjbOXJJ/dCdRBNErY8ZG7dyP10p8r
         UYz5I8efiYGum18UTIGbF0wVjiC+QUsjm/p97QHW2fq6q42DjnzQ5pKX9UpGL/YJ82Na
         lF4TCdG4rMcIvhb7Xuu3K/gcigv7Bs+963VAPbABKxhdCu4LUAAscHarWk17d/+7ztic
         L+hkJN73p9sG4v9FvpD5vaB+BIiTQRofx84jr7H7AcuNehZV5ISOQEZNiizgfybSmRCD
         fQyxRmM4ISJg6uyeT49JlUl1mNCOjx7RZ6K/mRRGJmGFWJ1bTNgUgf3qA6rjhtSaIohp
         dneQ==
X-Gm-Message-State: AJcUukclzZfpzkKZFnAYu4PkkhYb+EN8xJYsMh2d4pk5lJorPhXq9J/j
        ZH/l4/PyZCvCohxPEUtOPQ==
X-Google-Smtp-Source: ALg8bN6RYfvMbB6qz3r+UmOPafGYjJCH16ElCfli0n7ZfMm24qFQt4BHwyIv7Qj6ClXXJqkZcvqM9Q==
X-Received: by 2002:aca:cc0d:: with SMTP id c13mr6858665oig.150.1548117151727;
        Mon, 21 Jan 2019 16:32:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b128sm7087461oif.7.2019.01.21.16.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:32:30 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:32:30 -0600
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
Subject: Re: [PATCH 07/24] dt-bindings: PCI: Add dt-binding to configure PCIe
 mode
Message-ID: <20190122003230.GA32048@bogus>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190114132424.6445-8-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-8-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 14 Jan 2019 18:54:07 +0530, Kishon Vijay Abraham I wrote:
> Add "ti,syscon-pcie-mode" dt-binding to hold phandle to the syscon
> register that should be used to configure PCIe in RC mode or EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
