Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7162C10F06
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C312206B7
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LTuKsD6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfDCJ2N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:28:13 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35879 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCJ2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:28:12 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8E95725B820;
        Wed,  3 Apr 2019 20:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283690; bh=Rtxopc7s2h8amhLzWsRJFTYQYFJV8SIeJfyU4DBmq4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTuKsD6NztQKhc4nQOTaEleR/5bCWftuorBGfMi1eYAF3gMJld59M+8xP/j4HtM76
         VYQmb5JRe2Lvfv7x/znUZyvHBVQcza24nKoCH5OMvYd923rDenG1WO1mKWx5bxqqxx
         AEzHig90Ablzt0aYItZaNQklRuhFBUmfwpq5Lsp4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A715F940361; Wed,  3 Apr 2019 11:28:08 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:28:08 +0200
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V5 5/6] PCI: rcar: Clean up debug messages
Message-ID: <20190403092808.ifhnocltnjeclr5c@verge.net.au>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-5-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402013307.20912-5-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:06AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Drop useless casts from debug messages, they are no longer needed
> due to the data type cleanup.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

