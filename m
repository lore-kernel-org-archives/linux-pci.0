Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36003 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbJDLkd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2015 07:40:33 -0400
Received: by vkfp126 with SMTP id p126so82245554vkf.3
        for <linux-pci@vger.kernel.org>; Sun, 04 Oct 2015 04:40:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443906691-14642-1-git-send-email-festevam@gmail.com>
References: <1443906691-14642-1-git-send-email-festevam@gmail.com>
Date: Sun, 4 Oct 2015 17:10:32 +0530
Message-ID: <CAHM4w1nzT0dnPG4hjNErmCYN-yRzOUz2_GHV9Wn_aqbezOKh4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: spear: Move LTSSM state definitions to pcie-designware.h
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 4, 2015 at 2:41 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Move LTSSM state definitions to common pcie-designware.h so that other
> drivers can make use of them.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Yes, they are designware specific. So can be moved.

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
