Return-Path: <SRS0=3gZO=IE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421BC433DB
	for <linux-pci@archiver.kernel.org>; Sat,  6 Mar 2021 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7176650D7
	for <linux-pci@archiver.kernel.org>; Sat,  6 Mar 2021 23:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCFX55 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Mar 2021 18:57:57 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43037 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCFX5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 18:57:51 -0500
Received: by mail-wr1-f52.google.com with SMTP id w11so7166803wrr.10
        for <linux-pci@vger.kernel.org>; Sat, 06 Mar 2021 15:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=beocdEScBPeSIr1vaFYZtGBWWyFIKVYuh9rbyBcuAOc=;
        b=OFq1Hf6+6HzbcNO42IUZ9gEZewT2sOepMc/zcdToxeca4Gr7wsXeSXgWJLl9Eco3Gz
         HVNvpox5A4QUioD9noPqvCYyMTxIx5zrLrHrmxf0YFq4Ch/X3gaBTKN1DdyKcbmSUgUS
         6dMXsdy2fMjvcsoSqyT1u+MI0U941TRjSpYXWsM5xXwhxTh+Sl+qM0k1bp3VqfYk+3By
         ONCaEqqt578AYkb563gn25u4kQdsIlBK1ytU+/mQ8OrYxh+PGTzvMtJ9njeGLYGGXm9q
         V6q8/vL1x/TfQJPssWL3tHBvc2JZgcPSBeuB0700gaFbXiozlrvJgitiBvpYFImb1Bb9
         2PHQ==
X-Gm-Message-State: AOAM532Iai0pAv7/2pjHb9TfCTmCXRlRC3tItzB6q+w9S70ph+wgQpLD
        C5hVJjCLeKwt2S0AfmU3hYc=
X-Google-Smtp-Source: ABdhPJzFDayXNGiKRw5E9nfrRiFbbejPupxfptVe6/4oNEdkXo5HD38KIyj65MB6F0PrOE4x0C8N2A==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr15858322wrz.74.1615075070450;
        Sat, 06 Mar 2021 15:57:50 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g16sm10819033wrs.76.2021.03.06.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:57:49 -0800 (PST)
Date:   Sun, 7 Mar 2021 00:57:48 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci for
 QLogic 1077:2261
Message-ID: <YEQW/BFDb2Ny0NaV@rocinante>
References: <20210303224250.12618-1-aeasi@marvell.com>
 <20210303224250.12618-2-aeasi@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303224250.12618-2-aeasi@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arun,

> "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> "Vital Product Data" as "Not readable" today and thus preventing
> customers from getting relevant HBA information. Fix it by removing
> the blacklist quirk.
> 
> The VPD quirk was added by [0] to avoid a system NMI; this issue has
> been long fixed in the HBA firmware. In addition, PCI also has changes
> to check the VPD size [1], so this quirk can be reverted now regardless
> of a firmware update.
> 
> Some more details can be found in the following thread:
>     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> 
> [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> [2] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/
[...]

Looks good!  Assuming that this won't break QLogic ISP2722 with older
firmware, like you say, it's a nice fix.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
