Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8EFECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F80D2087A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F80D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJSPHN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:07:13 -0400
Received: from verein.lst.de ([213.95.11.211]:43697 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPHM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 11:07:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9C19C68C76; Fri, 19 Oct 2018 09:02:24 +0200 (CEST)
Date:   Fri, 19 Oct 2018 09:02:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181019070224.GB30556@lst.de>
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-5-hch@lst.de> <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 02:07:04PM +0900, Masahiro Yamada wrote:
> We could add 'depends on HAVE_PCI' or something
> to guard it to avoid changing the logic.

I guess that makes sense.

> config PCI_ENDPOINT
>         bool "PCI Endpoint Support"
>         depends on HAVE_PCI     # Is this correct ??
>         depends on HAS_DMA
> 
> 
> or better to have 'depends on PCI' ?

It does not depend on the normal PCI support, so I don't think this
is the right thing to do.
