Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122ADC10F00
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959E20989
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 09:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="FEA7MlnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfBYJ6w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:58:52 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41054 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfBYJ6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 04:58:52 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id EBCE925B784;
        Mon, 25 Feb 2019 20:58:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551088730; bh=2uj2UM4pG6gCZ6ElCwkiUw9RKOzklyeqpHCWht7x/2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEA7MlnSha65da6ZZzWhlio4OPiUf+SwvouQrQjLUeQSzXhppyoXdQ7FS4zXUFsXI
         D+WJjcR6F9IsS8wEDSrLLNz/4MvIXAzFt6tu9EMptxR30gcVYrHsUrrup9IEMpuDEb
         8zsMAahBEGSMZXPqjL/08UUitdTSK3ClUx4aJdvs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 22FDF94056F; Mon, 25 Feb 2019 10:58:48 +0100 (CET)
Date:   Mon, 25 Feb 2019 10:58:48 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20190225095847.53fppllriqc4yg36@verge.net.au>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190219172420.d4reyw3zwgmc3a7g@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219172420.d4reyw3zwgmc3a7g@ninjato>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 06:24:20PM +0100, Wolfram Sang wrote:
> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> > From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > 
> > Reestablish the PCIe link very early in the resume process in case it
> > went down to prevent PCI accesses from hanging the bus. Such accesses
> > can happen early in the PCI resume process, in the resume_noirq, thus
> > the link must be reestablished in the resume_noirq callback of the
> > driver.
> > 
> > Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> I am not a deep PCI expert. Still, the patch looks good to me and I
> double checked with the documentation.
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Minor nit would be 'CONFIG_PM' protection around the new code. But I
> have no strong opinion on that.

I agree that would be a nice enhancement but I also do not feel strongly
about it.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

