Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A3C38145
	for <linux-pci@archiver.kernel.org>; Thu,  8 Sep 2022 21:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIHVAH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIHVAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 17:00:01 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC46A4B9;
        Thu,  8 Sep 2022 13:59:59 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-127f5411b9cso16368248fac.4;
        Thu, 08 Sep 2022 13:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ht96cST8yQVzZBwVWRMco1CmpG7NqtflpXw8c4bPalc=;
        b=Z3pM56AR1hrKoJdOrQekdW09etL9hObXei4FGjwJcZlWJA+kF4UT2/hOC43SitJyLS
         fvho7hXiII63yHXP+vjhgi4qLx9Y9Qjkk1PopBDzBvvcJ/ctk0PZ/KTquyeFUmicfN02
         ldG/VR9ZDFAV5QqqoLAv7XjCujQ+oUxtdeK5iDKViAFRnLsxAy0r87XHE4V4pcoXAVNJ
         8KByy7FSlZBoADhsNntwmg2/J8xgSP8KhRACz27UP8boMnI1QrqKY/PESl+0nilvtrPB
         7adEM3ZFL4LW35PTXvBBkHbtS+NHCgcZyK9wNP3VFrW1t4s2nqyUpUhy3fKbqzNYGAR1
         LT5w==
X-Gm-Message-State: ACgBeo2ANtRtdiZFh0HaadwLkspYqbsmzJheXwMLPNS9KPX8tis/dWgg
        wfoFeo/AJps6MxwTmhpxWQ==
X-Google-Smtp-Source: AA6agR6skDdRn/PXQvtpF4wFOybY+PCqKSviHzZig+83x2LieXx6i5By8KhuwT1kbLOGTGYdrWiC0g==
X-Received: by 2002:aca:acc6:0:b0:34d:1b3b:6437 with SMTP id v189-20020acaacc6000000b0034d1b3b6437mr1669384oie.286.1662670798794;
        Thu, 08 Sep 2022 13:59:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h18-20020a056870d35200b0010e3cb4c98fsm117130oag.9.2022.09.08.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:59:58 -0700 (PDT)
Received: (nullmailer pid 3332296 invoked by uid 1000);
        Thu, 08 Sep 2022 20:59:57 -0000
Date:   Thu, 8 Sep 2022 15:59:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     aou@eecs.berkeley.edu, bhelgaas@google.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        lpieralisi@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, cyril.jean@microchip.com,
        padmarao.begari@microchip.com, heinrich.schuchardt@canonical.com,
        david.abdurachmanov@gmail.com
Subject: Re: [PATCH v1 4/4] of: PCI: tidy up logging of ranges containing
 configuration space type
Message-ID: <20220908205957.GB3240357-robh@kernel.org>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
 <20220902142202.2437658-5-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902142202.2437658-5-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 03:22:02PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> PCI ranges can contain addresses where phys.high part can have a type
> of 0, signifying 'configuration space'.  Change
> devm_of_pci_get_host_bridge_resources() to print 'CFG' instead of 'err'
> for a PCI range containing such a 'configuration space' type.

Generally, putting config space into ranges is wrong. It should be in 
'reg'

Rob
