Return-Path: <SRS0=slvM=EL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C8C55178
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 22:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFD120735
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604615777;
	bh=G1zpSEvPhccEncX/O/6lbcDyzZakCJ4t31HpzqMdYJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pb/lDj1OwiEuWgTGW3jCjEIJ85o+4V2UnnRjnu9z2Xyw9j6ZxvuJgcQekWznoQBuD
	 uGzYzfBdGc+S1NsNQ/xAqJ3rQAqBArvlAoNOhkLCutfhPup95yks4kzqjq2umvEc3d
	 n8AMnW3lZVG32piOWKf/fdXOLndNe2NeTKzYmQ+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgKEWgQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:36:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38822 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKEWgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 17:36:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id 9so3404120oir.5;
        Thu, 05 Nov 2020 14:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qoWQvVII2L+0j8buDT9IhzkPJRxJUA8gWcHIDv53Q4=;
        b=jiMoy8JurtyRTKyGnj4U5MRG4ld5eDc2cCS7Li+6ScpfKAbovxW/CSqdJGRp9F4pG2
         vLRznUwquHEAqGydaSxgRJ2MVA4avy5fMbJkfM3CzcWzLwszfjGPH6hP/XxOvQ+I1mv2
         QbCrW87UlsPoprZR0CF5Z7Xp3ZJaTjiUSy1uhIXWx2XPJXF2ANTnlTbOoldnirkYeP7H
         ak2Aq2SwBYUAumbgADKhLzpEm308VDL0IZOBHdu74IGytxGFHmV069Rfcie0UxVXNzqu
         SaHUan7544YOKSGnnd3L/6MKr5raG+VuM1IL1em80ExK9dvzk1W5ulo3NynQzmbLExE6
         EEVg==
X-Gm-Message-State: AOAM532opphA+racaxWb24Euy6X6kHaa9Gr4Gk9b7MFqwN6G5FO5KKCs
        st/olH5RPsh4vkwQFTqdlw==
X-Google-Smtp-Source: ABdhPJzlrZICjyxFaWJgee7+PdIsmVskPlx9h0vChEBao3eeFBImqsNDGQnz1rh6/i04KvRS/+6sNQ==
X-Received: by 2002:aca:ab81:: with SMTP id u123mr1089163oie.26.1604615775295;
        Thu, 05 Nov 2020 14:36:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm673702oop.6.2020.11.05.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:36:14 -0800 (PST)
Received: (nullmailer pid 1926238 invoked by uid 1000);
        Thu, 05 Nov 2020 22:36:14 -0000
Date:   Thu, 5 Nov 2020 16:36:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: rcar-pci-host: Document
 r8a77965 bindings
Message-ID: <20201105223614.GA1926149@bogus>
References: <1604455096-13923-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1604455096-13923-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604455096-13923-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 04 Nov 2020 10:58:15 +0900, Yoshihiro Shimoda wrote:
> Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
