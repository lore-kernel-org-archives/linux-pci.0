Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233ECC10F06
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC431217F5
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553799556;
	bh=nYhGC1aDZnZ4Uo/922AHTO9Z18cb9wvkL0Nqxrmyfjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mVcvZlMLY3gYo56UXbZ8JhNpYBA+FzhbwNvZo+wo3UAMugE3uN9V6z1VBH9qAcGcD
	 SubClQ/Vi+1fQPrft16eiDF/H9aJpnxrL5XMFRV26qPorvvYiMl9mC+BsHUNa+3aPN
	 AZONmVHycy4Y2EYWVnJ8Fs8W3oCsf6idOgmTEqZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfC1S7P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1S7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 14:59:15 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1A82173C;
        Thu, 28 Mar 2019 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553799554;
        bh=nYhGC1aDZnZ4Uo/922AHTO9Z18cb9wvkL0Nqxrmyfjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0m80E9dJOd8bjFIoy9wQzyOJRr+K8Ov1MozlmZUwrMTWWrhKYPiQoOuYuixkvjg3
         WtTRsy5bfzj5IPmC7YGhmgUUtyyNXEV1A0thYQsaZBhRetYOQyI59BlMXEnl3avych
         nviEutO5l8Hkvlk5HAzWdsTHSYfenVhODCd1D6LU=
Date:   Thu, 28 Mar 2019 13:59:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable <stable@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq()
Message-ID: <20190328185913.GC24180@google.com>
References: <20190325194319.12850-1-marek.vasut@gmail.com>
 <20190328141822.GA156243@google.com>
 <CAMuHMdVsJ1MW40ABuieLq7F6=zG_btAHZUr82Z4_pPVem3h=jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVsJ1MW40ABuieLq7F6=zG_btAHZUr82Z4_pPVem3h=jA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 03:59:11PM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 28, 2019 at 3:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Mar 25, 2019 at 08:43:19PM +0100, marek.vasut@gmail.com wrote:
> > > From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > >
> > > Reestablish the PCIe link very early in the resume process in case it
> > > went down to prevent PCI accesses from hanging the bus. Such accesses
> > > can happen early in the PCI resume process, as early as the
> > > SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
> > > driver resume_noirq() callback.
> > >
> > > Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
> >
> > I'm fine with the fix itself, but since e015f88c368d appeared more
> > than two years ago in v4.5, the justification for merging this after
> > the merge window is a little weak.
> 
> V1 of this fix was posted in November 2017, but IIRC, the series became
> the target of some bike-shedding...
> 
> > Is there a more recent change that exposed this problem?  The usual
> > situation is that we merged something during the v5.1 merge window
> > that caused a regression, and we're now fixing that before v5.1 final.
> 
> There are several reasons most people couldn't even run suspend/resume
> cycles on their systems:
>   1. Early releases of the affected boards came with firmware revisions with
>      non-functional PSCI system suspend,
>   2. Preparing the PMIC for suspend required ugly assistance from i2cset
>      in userspace, until the Linux driver learned to take care of that itself
>      in v4.18/v4.19.
> 
> I guess the fix can survive postponing to v5.2, though...

Ok, I'll merge it to -next for v5.2, thanks.

Bjorn
