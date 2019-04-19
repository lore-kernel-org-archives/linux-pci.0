Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5AC282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A62171F
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="Z0ZcKpFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDSVI2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:08:28 -0400
Received: from rfvt.org.uk ([37.187.119.221]:50244 "EHLO rfvt.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfDSVI2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 17:08:28 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 17:08:27 EDT
Received: from wylie.me.uk (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by rfvt.org.uk (Postfix) with ESMTPS id 9A99B80CB5;
        Fri, 19 Apr 2019 22:00:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1555707646;
        bh=2tSLmbz4VBRw+fpC2ODKFPU/2P3hKTPmsDIMG9F0X6g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=Z0ZcKpFjw7KXT3wTFc88aoQQZf0VpQS7Y/VKYYext22qXqWno0FSP5QaM8KxTIQtF
         V7czeAGdTbdrh7DFD/TvwcNmQi55uixykJ7Qj2iRVWp3bKlG8itYeDBsnWjxgGyKho
         X7VmecXsmFrCcaYibGTkCP/nEspK1Vh23PK7ItULIdb4C/GacPskfgDyUDykVsvE2f
         XyPopjwodBfYiTIOy5VuTmK8TzG2w6S4givLF7Vj1lDsJG8gTq1MK9I9M2t6YdELSF
         +HIYEU+d2iQQcClpI2J1R/t8lliQqgUkbqxegAKrw++NuIfzoJ+a7srNjNqgjOh0Ig
         ZiBUSNbarT/0w==
From:   alan@wylie.me.uk (Alan J. Wylie)
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     alex_gagniuc@dellteam.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] PCI: hotplug: Add quirk For Dell nvme pcie switches
References: <20190419000148.GI126710@google.com>
        <20190419152238.12251-1-mr.nuke.me@gmail.com>
        <20190419152238.12251-5-mr.nuke.me@gmail.com>
Date:   Fri, 19 Apr 2019 22:00:46 +0100
In-Reply-To: <20190419152238.12251-5-mr.nuke.me@gmail.com> (Alexandru
        Gagniuc's message of "Fri, 19 Apr 2019 10:22:26 -0500")
Message-ID: <875zr94sn5.fsf@wylie.me.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alexandru Gagniuc <mr.nuke.me@gmail.com> writes:

> These switches are used to fornicate the motherboard's x16 PCIe ports
                             ^^^^^^^^^
I don't think that's the word you intended to use.

-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
