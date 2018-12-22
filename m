Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CBEC43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A38218D9
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mShVEmsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390587AbeLVSTL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:19:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36122 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbeLVSTL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Dec 2018 13:19:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so7389522oix.3;
        Sat, 22 Dec 2018 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tIoUx+rDCOr9dfitvi3SphB8uxcVWDTDEjxEkguAV0o=;
        b=mShVEmsaIyGDscM18GNsQM+8gat122oxMnNezgmK1ixmrcDhgDObBWb3uJMGKSdh5U
         RKMXmSy8s/aa57c7nvvqBfiEOoYDSutC6568LTuL2FEFI43RG46diOdUdUNNTeaza6fJ
         FkZGnOJOWolQCFxSCH7a5um6khRSROnEXHwwP4CVLTiRHA9hYb4C8H8HnUBqg+kPBdP2
         GYomW0yLSx7dRSqUJxXB6CH1asYVCymK6CmIpup38+obI63iDSEiZNPIAjHF+ic0RgEd
         H43B8/W3JxLy/mKRWPRDH65WhWClx2BoPeM6CsanXi63ux3l/jwYyHqfXfMfC/3Qn/dP
         eSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tIoUx+rDCOr9dfitvi3SphB8uxcVWDTDEjxEkguAV0o=;
        b=mXk1plJdpOKfknapvkSry0T7xc7o2GZdxZhT05M8F2HRRFm2XEyw76KCyQmiuCcw/9
         higCisF74iPSZC5eDFAZ7oNMcaWsbzGwqbqUmGCmQTnBcMU9/tCnyqnWlN0gSvdQn+Qp
         ED0Vy7tIhWk3Pp0ve0fvJVeqvih03gv4e4b97zB/KKEm1mHFjnZ76cnbt2Vy6/sAdSq5
         sSzTiOnOh+THDqsKuxFEC1/N6b2nUjnC4F/PMn/Cw1FLyQIdmrl6fqoutTga9vExdjll
         kzG4hL9C0n5oPGAXFBiF/n0zTPmHLpdJ9IulU9Lyei7HE107+tv0Ax3BtN2bm0wsrG/j
         op0g==
X-Gm-Message-State: AA+aEWYVJTu5cU9op4BF1j1+owytasTBeY55SmETnfMSK9c5tOgExlwH
        wPn4AgSjjJ/722Qn+Fiq/7bhlofDI17isB8flpzEngYu
X-Google-Smtp-Source: AFSGD/XlYaheX39oagiP0NS/EBWwQFRM7HxE7n/E8Kqzp6MDI6rT9NK6j01OetvxgwzvzS+H70jzcBwAATLbSgZvXv8=
X-Received: by 2002:aca:3c06:: with SMTP id j6mr3028326oia.126.1545454230904;
 Fri, 21 Dec 2018 20:50:30 -0800 (PST)
MIME-Version: 1.0
From:   yu <kkndyu@gmail.com>
Date:   Sat, 22 Dec 2018 12:50:19 +0800
Message-ID: <CADayL-pxr_dpJykyiTeQDO13XmKPoKUs544zVrB2taHTVEx9Pw@mail.gmail.com>
Subject: How to force RC to forward p2p TLPs
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kkndyu <kkndyu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

We have a PCIE card which has a PEX8732 switch on-board,  and there
are two endpoint SOCs like graphic decoder behind the switch, and by
default the ACS is enabled in 8732.

We use the p2p DMA to transfer data between these two endpoint SOCs,
and if the host server is not enable ACS in BIOS, the p2p works well,
but when ACS is enabled in BIOS, the p2p is always failed. With the
help of a protocol analyzer, we can see that the TLP is redirected to
RC, and RC just discard it.

I tried to find how to make RC forward redirected TLP to its original
target, but nothing found, it seems this is highly related to the RC
vendors.

In the PCIE 4.0 spec, the section of the RC behavior of the p2p
request redirect  said that ''implementation-specific logic within the
RC that determines whether the request is directed towards its
original target, or blocked as an ACS Violation error. the algorithms
and specific controls for making this determination are not
architected by this spec''.


So is there some spec or document to describe how to set the RC? Any
suggestion is appreciated.

Regards,
Eric
