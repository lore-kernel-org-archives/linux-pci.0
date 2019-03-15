Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D937C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E019218B0
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="BQv2h3bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCOLyL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:54:11 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35689 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCOLyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 07:54:11 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 764A625BE91;
        Fri, 15 Mar 2019 22:54:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552650848; bh=Xs2Ph133XYLhEoYXMwjQPOrR2LlELLZNfoVn2ClUQUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQv2h3boxdUCOD8wKLfWWRCDjUy0u9Jt+laaMGIzRKgAd74QpWlNRe0Ur0dkZko7s
         y5zfoUaf49JLWo37HgXEoQpNQDRQ4AEVZ6Xfv9zFSC2aEmgV1eiSTm93cL39tyoa8s
         5MOGFn3zBhCS9h8e0KIdP6cVKTg3mpIiV9ygGdsA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id CEBCA9403F2; Fri, 15 Mar 2019 12:54:06 +0100 (CET)
Date:   Fri, 15 Mar 2019 12:54:06 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: pcie-rcar: fix a potential NULL pointer
 dereference
Message-ID: <20190315115406.h7pgtvnzzl6ytavr@verge.net.au>
References: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
 <20190315072943.22923-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315072943.22923-1-kjlu@umn.edu>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 15, 2019 at 02:29:43AM -0500, Kangjie Lu wrote:
> In case __get_free_pages fails and returns NULL, the fix returns
> -ENOMEM and releases resources to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

