Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32802 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbJ0XeJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 19:34:09 -0400
Received: by igbkq10 with SMTP id kq10so106408002igb.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:34:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151027162056.GA16564@localhost>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20151021184250.28724.41928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20151027151542.GF8660@localhost>
	<CAOMZO5CYTd+VKj8h6iP_g1A_OAHuFYhM=-wfS5+PzshkbFFnyg@mail.gmail.com>
	<20151027162056.GA16564@localhost>
Date: Tue, 27 Oct 2015 21:34:08 -0200
Message-ID: <CAOMZO5ABiT3MSUO0P3m6SExkZYNJ5hLiUHzAJcvR6xEW5a16uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] PCI: designware: Use common LTSSM_STATE_MASK definition
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 2:20 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Well, maybe.  Are those states documented in the DesignWare spec?  I

Unfortunately I cannot find them in DesignWare spec that I have access to.

> don't want to put things in pcie-designware.h that are only common by
> accident or even by convention.  We should only put things there if
> they are documented things that users of that IP can rely on.
>
> LTSSM_MASK is documented in the TI Keystone spec, so its definition
> probably belongs in pci-keystone-dw.c.  The same TI spec also contains
> LTSSM state definitions, so I suspect they're in the same boat --
> things that might accidentally be the same across devices, but they
> don't *have* to be.
>
> So I'm going to drop the following patches from my tree for now:
>
>   1ad5fdbc8410 PCI: designware: Add LTSSM state definitions
>   b09464f77dd2 PCI: designware: Use common LTSSM_STATE_L0 definition
>   fa15c15fd95d PCI: designware: Use common LTSSM_STATE_RCVRY_LOCK definition
>   4788fe6ebf45 PCI: designware: Use common LTSSM_STATE_MASK definition
>
> We can add pieces back if they make sense.  If we add things to shared
> files like pcie-designware.h, I'd like a reference to the DW spec that
> justifies the sharing.

Fair enough, thanks.
