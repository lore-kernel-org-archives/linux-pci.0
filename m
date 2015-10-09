Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36840 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbbJIBUe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 21:20:34 -0400
Received: by ioii196 with SMTP id i196so76708344ioi.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2015 18:20:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444015275-5668-1-git-send-email-festevam@gmail.com>
References: <1444015275-5668-1-git-send-email-festevam@gmail.com>
Date: Thu, 8 Oct 2015 22:20:33 -0300
Message-ID: <CAOMZO5B6KHKDDg16L3c=BoE__LNmjE+Ph-Esk8xT77tM_3GxeQ@mail.gmail.com>
Subject: Re: [RFC] PCI: spear: Fix definition of LTSSM_STATE_MASK
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 5, 2015 at 12:21 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Designware PCI block uses 0x3f for the LTSSM_STATE_MASK.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Murali,
>
> I am doing some consolidation on the PCI DW drivers and I noticed that
> keystone uses a different LTSSM_STATE_MASK definition.
>
> Could you please double check it?

Ok, checked in http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf and
LTSSM_STATE_MASK is only 5 bits, so the current code is correct.
