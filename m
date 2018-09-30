Return-Path: <SRS0=75lR=MM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6F2C004D2
	for <linux-pci@archiver.kernel.org>; Sun, 30 Sep 2018 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3BB2075E
	for <linux-pci@archiver.kernel.org>; Sun, 30 Sep 2018 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhnzrjnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3BB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeI3PrY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:47:24 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46315 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeI3PrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Sep 2018 11:47:24 -0400
Received: by mail-oi1-f176.google.com with SMTP id k64-v6so8816223oia.13
        for <linux-pci@vger.kernel.org>; Sun, 30 Sep 2018 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OtwEtit3KgQISQYCP2aKX7Mk9vT6KonUKrTj4V0UU0o=;
        b=vhnzrjnOs6LByh6DgkGIgMBK5HSQpmdLJ4UbYA/BoS+hruePefI4OV5REOzIN2E3B/
         aaG1woJYAq3G+vOFHNjyH3meRgtetbkCF6et07KP6UnokTcJkINJ2WcI+2tbdrKTVNdY
         KEPdJAmQ16LJHU+sEiLBHCJaJcpsr1TcgknR1llyYs3JXUOKkfvD1pmpgOBi7QDDmaxj
         t2K3o2tulrTU2fmDZMhJ0Elscw8XATL+h9Sat1ruCH87dTUPyYJSmeE+mcF0TFPfqhDE
         abzwhB2kOxKZNCHgxjzZqDDjGkdwwRitclCNy9PsLwDOU1fU74GdcUx2lvLVH1VpXZjF
         mdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OtwEtit3KgQISQYCP2aKX7Mk9vT6KonUKrTj4V0UU0o=;
        b=YRB2T9IAtYJ4JI2kQesSyP6Aq+Fu91qkvBE2GJrnz5aG4N11B8whOIXweZGd5MM76m
         n5YUamvCQCAmFJZQO2fxNp95qvMz94/I7aoDcPVeibwRdtr1JBGaf2zBLZlj4N2ugPVQ
         M3tt/db2tJvGnqsuaBn32IHTNndmlQzegm528uK9fkLGK8tAwmjpPKDLRexazbLwuZNE
         NMqjEdmtD6avcivum0k/HN9yrJhX6h7VgZ6FKb1PjmJ9CzrDCA9J48E1b+/oVb806dl1
         riOABw0limxTnT1sNBcCX3kwmJqXB0qQETfywF4vN+MMgnHy2TX8Tm6061vq9aBR3Zs7
         a19g==
X-Gm-Message-State: ABuFfogUwropavvKB2dC2nRbqORB609N2ze4lV+uUAmAQANXsOEabdEg
        7RZuRw6JhaW0mw1NgdWsh3DS5LSxBWS512bhcS3IXkhY
X-Google-Smtp-Source: ACcGV63awAxFd/6QQIjnFTLY8cQiqtqt3+9IheV9wZmoC3jsfEdOyWdxPTVj+7wbQmWgN4j5Znkc2kwFvfWpxaswSbg=
X-Received: by 2002:aca:50c1:: with SMTP id e184-v6mr3042436oib.264.1538298912873;
 Sun, 30 Sep 2018 02:15:12 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Wilson <wkevils@gmail.com>
Date:   Sun, 30 Sep 2018 12:15:01 +0300
Message-ID: <CAGXs5wXBdmjp-3XcuNHFCykLdT5LJj=tMPJnqLexAL18n=wLNg@mail.gmail.com>
Subject: A question about pcim_iomap_regions() and Managed Device Resource API
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI, linux-pci developers,

There are very few Ethernet drivers which use
pcim_iomap_regions(); for example,
drivers/net/ethernet/realtek/r8169.c.

My question is: why do they use this
Managed Device Resource API and not
the regular Device Resource API (ioremap() for example), which is used in
**most** Ethernet Linux device drivers, for example, in I40E driver:

...
    err = pci_request_mem_regions(pdev, i40e_driver_name);
    ...
    hw->hw_addr = ioremap(pci_resource_start(pdev, 0), pf->ioremap_len);
...

Is there some inherent HW feature in r8169 (or the other
drivers, see list below) which requires using this API ? Is usage
of this API (the managed devices, with pcim_iomap_regions(), etc) is
mandatory for these device drivers, and cannot be
use in most drivers (like I40E and most of the others) ?

The other Linux Ethenet drivers that use
pcim_iomap_regions() are:
amd/xgbe, cavium/common/cavium_ptp.c, intel/ice/ice_main.c,
oki-semi/pch_gbe/pch_gbe_main.c, stmicro/stmmac/stmmac_pci.c,
synopsys/dwc-xlgmac-pci.c and toshiba/tc35815.c.

Regards,
Kevin W.
