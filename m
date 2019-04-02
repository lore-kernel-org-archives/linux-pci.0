Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3486BC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10312070B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554228470;
	bh=lAMZlPOe2midBvWJDuHP7RuXcCyneM7lM2v31z/PEm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWz5ajqGRkXncYIHYFTsARqiealtuGfbrG3R2fp/PzajIfhNWWF/MPa5cedSU8ILX
	 NDIlJmuetAugW7QVPE6D89r8lNwnxnntoHVjLr56jXyHFESSZi4jTfFqX2joJNH/mS
	 GwDfPoIqAr+x6jUGG0t85WbsZpGF/dyaKQLlIVH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfDBSHt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBSHt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 14:07:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33782070B;
        Tue,  2 Apr 2019 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554228468;
        bh=lAMZlPOe2midBvWJDuHP7RuXcCyneM7lM2v31z/PEm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8VPES2ZJXfO8oNa1vATGg0HRlsWDW9Oux6axR4vZVdmy5N82rGCX8swiar0B+kSd
         NUzE4U+Xox0TRB28opbDBiqGUIz73oRcgSdreW51N8h0HR4FOBWesGTTsqG/9j++jl
         MI9htjPk8ArOGGEtpb6cfZLiXIkU64+rHSFKFF30=
Date:   Tue, 2 Apr 2019 13:07:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190402180744.GD141706@google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190401230321.GB141706@google.com>
 <20190402150852.juugbq7gripqbrmz@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402150852.juugbq7gripqbrmz@mail.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 11:08:54PM +0800, Changbin Du wrote:
> On Mon, Apr 01, 2019 at 06:03:21PM -0500, Bjorn Helgaas wrote:
> > On Sat, Mar 30, 2019 at 12:04:01AM +0800, Changbin Du wrote:
> > > Changbin Du (12):
> > >   Documentation: add Linux PCI to Sphinx TOC tree
> > >   pci doc: convert PCI/pci.txt to rst format
> > >   pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
> > >   pci doc: convert PCI/pci-iov-howto.txt to rst format
> > >   pci doc: convert PCI/MSI-HOWTO.txt to rst format
> > >   pci doc: convert PCI/acpi-info.txt to rst format
> > >   pci doc: convert PCI/pci-error-recovery.txt to rst format
> > >   pci doc: convert PCI/pcieaer-howto.txt to rst format
> > >   pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
> > >   pci doc: convert PCI/endpoint/pci-endpoint-cfs.txt to rst format
> > >   pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
> > >   pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format
> > 
> > Thanks for doing all this work!
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There's not a real convention yet for subject lines in Documentation/,
> > but I would propose:
> > 
> >   Documentation: PCI: Convert pci.txt to reST
> >   Documentation: PCI: Convert endpoint/pci-endpoint.txt to reST
> > 
> > because that at least goes with some recent Documentation/PCI changes
> > and it identifies "reST" as something other than a plain English word
> > (RST or ReST would also work for me).
> > 
> I agree. I am just a little lazy to update all of them this time :)
> Thanks for your ACK!

Well, I guess I'm too lazy to fix them all for you, so I personally
wouldn't apply these.  But maybe Jonathan will be more accommodating.

Bjorn
