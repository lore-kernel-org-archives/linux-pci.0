Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A427C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 26 May 2022 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiEZUiF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 May 2022 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbiEZUiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:38:05 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99574A91F
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 13:38:03 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id q8so3443242oif.13
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 13:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AiYDEqPV+oOVWwS/4IbNHV60WDAlRWTR1i9WwfqIX04=;
        b=DKY1rA+bxOf5vDvq5jneJYlB4SuF7Im9/d9yOvmgc6+Gln4QNm6UeqRiuHb16PHZY4
         OHrprbzvsEq0m4O7dL4ZZ5OEA3lT9budzpxoetkvgBPLZ7ZZZu+sbBAnY99Lv2sci0V2
         EZxQOc0OWPJRHKmbB/D9IYZcsKeSkQyLOp6RSJa6FE1rGeJHVeCGcsjXla+OhJIH044P
         097zQHzCthnmG1McijUTrN5Thb3ZnYQA2Y8ev4V7pOd17xa9PxXjQbXxO5qIJBEvbRyG
         gTNFtKbJRz9SDp/ZE7lY8nbdFWUsPr192bngcInOuLfVjQbiOnDq0uAnXf8SfYYHT1sC
         NWnA==
X-Gm-Message-State: AOAM532lWol7iWATX6oYWh1mIFI7jzjnLih8G5VUNVjXp22ZBdr6Vwkv
        FqIOshuhqHlOkh24H2G2/w==
X-Google-Smtp-Source: ABdhPJz6JCFHGEfc+kEqqQcD8a2+lTL43mN6u1Z1U/nqT+YYDQPNKurd5ggUqubVx3iPFSIIOzl04A==
X-Received: by 2002:a05:6808:1788:b0:32b:1f1a:75e0 with SMTP id bg8-20020a056808178800b0032b1f1a75e0mr2276973oib.255.1653597483064;
        Thu, 26 May 2022 13:38:03 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id h24-20020a056830035800b0060b1fefeb52sm1018774ote.66.2022.05.26.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:38:02 -0700 (PDT)
Received: (nullmailer pid 224666 invoked by uid 1000);
        Thu, 26 May 2022 20:38:01 -0000
Date:   Thu, 26 May 2022 15:38:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: aardvark: Add support for AER registers on
 emulated bridge
Message-ID: <20220526203801.GI54904-robh@kernel.org>
References: <20220524132827.8837-1-kabel@kernel.org>
 <20220524132827.8837-2-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524132827.8837-2-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 03:28:26PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Aardvark controller supports Advanced Error Reporting configuration
> registers.
> 
> Export these registers on the emulated root bridge via the new .read_ext
> and .write_ext methods.
> 
> Note that in the Advanced Error Reporting Capability header the offset
> to the next Extended Capability header is set, but it is not documented
> in Armada 3700 Functional Specification. Since this change adds support
> only for Advanced Error Reporting, explicitly clear PCI_EXT_CAP_NEXT
> bits in AER capability header.
> 
> Now the pcieport driver correctly detects AER support and allows PCIe
> AER driver to start receiving ERR interrupts. Kernel log now says:
> 
>     [    4.358401] pcieport 0000:00:00.0: AER: enabled with IRQ 52
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Did you mean Reviewed-by? Signed-off-by is only correct if Lorenzo 
applied or rewrote these. If he applied them, then Bjorn will pick them 
up.

Rob
