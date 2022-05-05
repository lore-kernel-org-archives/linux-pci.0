Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C7C433F5
	for <linux-pci@archiver.kernel.org>; Thu,  5 May 2022 12:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359373AbiEEMHB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 May 2022 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbiEEMHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:07:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F063D2AC7F;
        Thu,  5 May 2022 05:03:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8C73B92009C; Thu,  5 May 2022 14:03:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8024592009B;
        Thu,  5 May 2022 13:03:19 +0100 (BST)
Date:   Thu, 5 May 2022 13:03:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Arnd Bergmann' <arnd@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: RE: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
In-Reply-To: <145b4021c7b14ada95ba0acf6f294b96@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2205051254010.52331@angie.orcam.me.uk>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com> <20220503233802.GA420374@bhelgaas> <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com> <145b4021c7b14ada95ba0acf6f294b96@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 4 May 2022, David Laight wrote:

> I think you can find cardbus cards that have a pci bridge and a cable
> link to an expansion chassis into which you can insert standard PCI cards.
> If you are really lucky the initial enumeration allocates the
> 'high field' bus numbers, io addresses and plenty of memory
> space to the bridge - otherwise you lose.

 No need to rely on luck as (given that no single size fits all) we have 
the `hpbussize', `hpiosize', `hpmemsize', `hpmmioprefsize', `hpmmiosize', 
options to the `pci=...' kernel parameter for people to tune the settings 
according to their needs.  I don't have such a CardBus option, but I do 
have a couple of such ExpressCard devices, and mixed PCIe/PCI expansion 
backplanes for them.

  Maciej
