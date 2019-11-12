Return-Path: <SRS0=oUFn=ZE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D3C17441
	for <linux-pci@archiver.kernel.org>; Tue, 12 Nov 2019 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13F021925
	for <linux-pci@archiver.kernel.org>; Tue, 12 Nov 2019 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573586250;
	bh=Wt3rFYctydOjbIfuhPKesLt74dXSwwsHPoiS7XNLSqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DSEptK48slJ8hxlhKjv4fOvqWGObGqa57QBXqdGwltcX7gZnxF3yJQOiSdS7PGbYw
	 8EBQOt4auvYaJ/9FZk0Imr6NN8HdLsBz4Ul8VuxCcxCct06oLZlKD3zZVDXwwXmUg6
	 TM/wDq9ONG4mLojOHFFE3/+Lfg21vz9l83kqjLBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKLTRa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:17:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39296 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLTRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 14:17:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id v138so15866565oif.6;
        Tue, 12 Nov 2019 11:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOxaXG+TZhstIZVYqS22mLzGBLiEMvGN3yM+TwStSBM=;
        b=JiAQGmiW3P+CAzmp5YZu1/e3wXw1Gt9DXKKdMD8R309/6Q/BP0o/EodtSdMiRab/J+
         iCNuW2z4/V9Ex7IXPkxDWbNP8rtKmrnX/uaTcVPctqd6Mze845afVR0G0ixzEvHfOK+d
         hDPBf/vCnDNNU1mHAmgL2eJDVFU4cnetEg5/ZifM6eZwVUclO34lz1F7spAqbygKmtak
         eJt8BiUeo6F9S9tRUsocETjmpgeZUdb7k/fWZYqFiv2XEFWJ2LRbwU68ESWsp5/GWozI
         WL95wJ9rWFDxhS3Vit1T/DnjMvTK6CpSgvJpEicx/JHw9KEfY72WA39b0fMcseCMWhiA
         Rs7w==
X-Gm-Message-State: APjAAAXmo3Cx0lLPMtLfeg/Xz1cS+1eLQEmu5r9DLo/RjI4xpNTVawTt
        Jk4o+aIgMikGop84abEk2Q==
X-Google-Smtp-Source: APXvYqwB55rTeoE/9VgMp/1/IaxWGe0DHNYKNm7RGK1FZv/6GHDEAhjinAxPJdRKz5XEmcQISuEpSw==
X-Received: by 2002:aca:edd8:: with SMTP id l207mr484171oih.102.1573586248860;
        Tue, 12 Nov 2019 11:17:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2sm1557043otn.20.2019.11.12.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:17:28 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:17:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20191112191727.GA31422@bogus>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <73655e49e80ac08826ad2d470e1387ba1b662d83.1572950559.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73655e49e80ac08826ad2d470e1387ba1b662d83.1572950559.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 11:44:01AM +0800, Dilip Kota wrote:
> Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
> which is Synopsys DesignWare based PCIe core.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
> Changes on v5:
> 	Add Reviewed-by Andrew Murray.
> 	Add possible values and default value for max-link-speed.
> 	Remove $ref and add maximum and default for reset-assert-ms.
> 	Set true flag for linux,pci-domain.
> 	Define maxItems for ranges and clock.
> 	Define maximum for num-lanes.
> 	Update required list:
> 	  Add #address-cells, #size-cells, #interrupt-cells.
> 	  Remove num-lanes and linux,pci-domain.
> 	Add required header files in example.
> 	Remove status entry in example.
> 
> changes on v4:
> 	Add "snps,dw-pcie" compatible.
> 	Rename phy-names property value to pcie.
> 	And maximum and minimum values to num-lanes.
> 	Add ref for reset-assert-ms entry and update the
> 	 description for easy understanding.
> 	Remove PCIe core interrupt entry.
> 
> changes on v3:
>         Add the appropriate License-Identifier
>         Rename intel,rst-interval to 'reset-assert-us'
>         Add additionalProperties: false
>         Rename phy-names to 'pciephy'
>         Remove the dtsi node split of SoC and board in the example
>         Add #interrupt-cells = <1>; or else interrupt parsing will fail
>         Name yaml file with compatible name
> 
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

I'm working on a common PCI schema which will shrink this, but in the 
meantime:

Reviewed-by: Rob Herring <robh@kernel.org>
