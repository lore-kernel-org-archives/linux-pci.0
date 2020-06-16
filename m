Return-Path: <SRS0=/yVf=75=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FDC433E1
	for <linux-pci@archiver.kernel.org>; Tue, 16 Jun 2020 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF57214F1
	for <linux-pci@archiver.kernel.org>; Tue, 16 Jun 2020 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322611;
	bh=ZA8j5WqRei9ADYlTjOJG9AlPyaO9kaM1e46RYsUIRSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SqxNvirYKD4adzgB96JbWq1C/UWQZzHwGyaliuIu5AjwDop2CP17/1T0mYQdd+Bbz
	 2FnjPWLhzDxesaDgVnwohN8hs48SqMx38whWU7FitDZsC4yoaR6KQ5Wh8EHh6DwV8D
	 7VY10Ni25L1wZGNvn/kC7j4d1WLduuEvYmWGjx+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbgFPPuJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbgFPPuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 11:50:07 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02290214F1;
        Tue, 16 Jun 2020 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322607;
        bh=ZA8j5WqRei9ADYlTjOJG9AlPyaO9kaM1e46RYsUIRSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hv7CDE1f09U9T8Dbm2NdIvxnDyzUKqh38iLINrGJ55qKG9Vyk5n9hxhPIaefZMunF
         uYU6dQPT9/Iz22twkm217Kxwp6KY+Fr8qZJ7iGwGTxSOilsfjp09LvLxFmnd8YQ2eR
         yAnek6/UmQfvax8A18Gyv9HwdAVah6vGFFrQOWOE=
Date:   Tue, 16 Jun 2020 21:20:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: dmaengine: renesas,usb-dmac: Add
 binding for r8a7742
Message-ID: <20200616155001.GH2324254@vkoul-mobl>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24-05-20, 22:37, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.

Applied, thanks

-- 
~Vinod
