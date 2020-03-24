Return-Path: <SRS0=Xfzt=5J=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E0C2BAEE
	for <linux-pci@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305662073E
	for <linux-pci@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585066738;
	bh=uDZ6xONe7hN/cEt7/U9oDokxJ0lmH4fwXrNK8vvyKVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=RdnYzqdApIXtW4Vfa3xoI0fGiYyF8WLU5/8R+kAI8jvzXQgE0fk2y+10lEXX+0tXP
	 JfmTsGITOwORbWU3uzbSgXzdgnWRA6igHSOV9lykpgDu3BsY9dnEQz2L5v0ZnmdM7p
	 YE9iIoIXZ38+vWQ3xPjQsD9uMaaXW5vRwkU/FX4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCXQSx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCXQSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 12:18:53 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59DD2073E;
        Tue, 24 Mar 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585066733;
        bh=uDZ6xONe7hN/cEt7/U9oDokxJ0lmH4fwXrNK8vvyKVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AcvVmc3x3bcZ5BQ/b8glBwgfTorqH4jecAYdlA2CmUJBin3jpPVoHRCdor/hsgnzI
         UT3pA7P6R3FsxdDqbLqCB4P2XTXb1XjGp87E51omh9yC/O7WSgoHyXq3SmeyK1WrQq
         jmtsxpEy7vig+QCl2e1G4hFbG0Y1GJbqGJoKA/5M=
Date:   Tue, 24 Mar 2020 11:18:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
Message-ID: <20200324161851.GA2300@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62819368-150e-6b49-3ab3-9a2ab28481b3@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
> On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> 
> 
> on x86_64:
> 
> ../drivers/pci/controller/dwc/pcie-tegra194.c: In function ‘tegra_pcie_dw_parse_dt’:
> ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_phy_get’? [-Werror=implicit-function-declaration]
>   pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
>                         ^~~~~~~~~~~~~~
>                         devm_phy_get

Thanks a lot for the report!

This was found on mmotm, but I updated my -next branch with Lorenzo's
latest pci/endpoint branch (current head 775d9e68f470) and reproduced
this build failure with the .config you attached.

I dropped that branch from my -next branch for now and pushed it.

Bjorn
