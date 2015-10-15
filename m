Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37006 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbbJORQF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 13:16:05 -0400
Received: by igbhv6 with SMTP id hv6so45937632igb.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2015 10:16:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <561FD30E.20203@ti.com>
References: <1444042389-8036-1-git-send-email-festevam@gmail.com>
	<561FD30E.20203@ti.com>
Date: Thu, 15 Oct 2015 14:16:04 -0300
Message-ID: <CAOMZO5AfQrdv4zJT9rs=irkASZ_3fdeR_nth4JP6gUo-2TadSA@mail.gmail.com>
Subject: Re: [RFC v2] PCI: keystone: Fix definition of LTSSM_STATE_MASK
From: Fabio Estevam <festevam@gmail.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 1:23 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:

> NACK
>
> The mask should be 0x1f as was originally as per document
>
>
> 4-0                LTSSM_STATE        LTSSM current state. Please see
> Appendix
> A.1 for the names of the LTSSM states corresponding to
> the encoded values.
>
> refer the document at http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf

Yes, in the last version of the patch I use the 0x1f mask for all
Designware PCI drivers.
