Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B44C433FE
	for <linux-pci@archiver.kernel.org>; Wed,  4 May 2022 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351319AbiEDO2Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 May 2022 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiEDO2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 10:28:17 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D46B2CE39;
        Wed,  4 May 2022 07:24:41 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C615B92009C; Wed,  4 May 2022 16:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C2FE592009B;
        Wed,  4 May 2022 15:24:39 +0100 (BST)
Date:   Wed, 4 May 2022 15:24:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
In-Reply-To: <CAK8P3a2jwv00En13=5mHVA4OGRzDpAsPKy4nqM79L6xP5=aQFQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2205041516110.9548@angie.orcam.me.uk>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com> <20220503233802.GA420374@bhelgaas> <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com> <alpine.DEB.2.21.2205041311280.9548@angie.orcam.me.uk>
 <CAK8P3a2jwv00En13=5mHVA4OGRzDpAsPKy4nqM79L6xP5=aQFQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 4 May 2022, Arnd Bergmann wrote:

> >  POWER9 is another architecture with no port I/O space[1]:
> 
> POWER9 is just an implementation of the power architecture
> that has a particular PCI host bridge. I would assume that
> arch/powerpc/ would continue to set HAS_IOPORT because
> it knows how to access I/O ports at compile-time.

 Well, yes, except I would expect POWER9_CPU (and any higher versions we 
eventually get) to clear HAS_IOPORT.  Generic configurations (GENERIC_CPU) 
would set HAS_IOPORT of course, as would any lower architecture variants 
that do or may support port I/O (it's not clear to me if there are any 
that do not).  Ideally a generic configuration would not issue accesses to 
random MMIO locations for port I/O accesses via `inb'/`outb', etc. for 
systems that do not support port I/O (which it now does, or at least used 
to until recently).

  Maciej
