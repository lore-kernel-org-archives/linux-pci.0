Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34083 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbJLPrz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 11:47:55 -0400
Received: by iow1 with SMTP id 1so155739343iow.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2015 08:47:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444659102.3364.19.camel@pengutronix.de>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	<1444645188.3364.5.camel@pengutronix.de>
	<1444645685.3364.8.camel@pengutronix.de>
	<CAOMZO5CyGybRSJfCNwJAXrPuKpJqsA_w0Qfb+vhUXCyCe-PKiQ@mail.gmail.com>
	<1444656873.3364.14.camel@pengutronix.de>
	<CAOMZO5CKWj9tWCOZV65xwFCB7b120weq3Aq7_de-aMdEYAZWpA@mail.gmail.com>
	<1444659102.3364.19.camel@pengutronix.de>
Date: Mon, 12 Oct 2015 12:47:55 -0300
Message-ID: <CAOMZO5AsfsRiYLmAZVAoZgso_xuT0vTMAakn24yTH8y+8McQHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to pcie-designware.h
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 11:11 AM, Lucas Stach <l.stach@pengutronix.de> wrote:


> Still I would love to have a definition in the common header that's
> usable for all drivers. So unless there is a reason to use 0x3f (and we
> don't have any LTSSM state defines which would use the extra bit) keep
> it at 0x1f. Simpler, cleaner... IMHO.

Sure, just did as suggested in v3. Thanks
