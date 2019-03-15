Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B29C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDB6218A5
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 10:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="OZ+Bp2b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfCOKN2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:13:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:35068 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfCOKN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 06:13:28 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 06:13:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552644805;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=EKqt1w2UzK2mwQcKVgqaJm6xgFSaLAtGji5C+UisvrM=;
        b=OZ+Bp2b2Y9pSxTUa4G5WJLeGqcQmNphhMrLf63hRwo5VQkxGBh9hdkvJlfHtpp3sr1
        xLs1Jluf7vlzs/nF0zfzNJhwo2l35xK8i+Iws5k+LTlX55M5s2upNPYSzaW3YFtpNjOE
        lHBaGyecHhzh2yhCnRHIjiYrZY4usYZfQvO0PfNdMglmc0WXFIfSSFM/lmwLvSg5etaS
        4P83I9qSKtAaWcwr0qpwPmFb+mqM1CZn8WEk5d8ciDm6ExLjo/2hYmPsg3VQ43kMkDuD
        /0sYgYGQWGQRq0/Zh8IxfgB4Irm9+KU8ufLC4fbYCaKP4Lt6WGmXjD6SU5+kLV5kDrdc
        icTQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.16 AUTH)
        with ESMTPSA id R086cdv2FA7H39H
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 15 Mar 2019 11:07:17 +0100 (CET)
Date:   Fri, 15 Mar 2019 11:07:17 +0100 (CET)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1263138672.859729.1552644437032@webmail.strato.com>
In-Reply-To: <20190315072943.22923-1-kjlu@umn.edu>
References: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
 <20190315072943.22923-1-kjlu@umn.edu>
Subject: Re: [PATCH v2] pci: pcie-rcar: fix a potential NULL pointer
 dereference
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-IP: 188.195.184.203
X-Originating-Client: open-xchange-appsuite
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> On March 15, 2019 at 8:29 AM Kangjie Lu <kjlu@umn.edu> wrote:
> 
> 
> In case __get_free_pages fails and returns NULL, the fix returns
> -ENOMEM and releases resources to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
