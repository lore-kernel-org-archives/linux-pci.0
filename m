Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37936 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638AbbLGJ1u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 04:27:50 -0500
Received: by igbxm8 with SMTP id xm8so78446686igb.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2015 01:27:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1449480357.3118.3.camel@pengutronix.de>
References: <CAOMZO5AxaAr57pYpBEEgk5sm56ey3b60F2E0z2PgD1Z2g7Y_Sg@mail.gmail.com>
	<1449480357.3118.3.camel@pengutronix.de>
Date: Mon, 7 Dec 2015 07:27:49 -0200
Message-ID: <CAOMZO5CxOu0rgQGSKYsvYVojAuMOw0DsH1uc6pSgPL4d+a9oQQ@mail.gmail.com>
Subject: Re: mx6: No bus range found
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Mon, Dec 7, 2015 at 7:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> This one is also harmless, as it is being ignored. But as it generates a
> confusing "err 0x01f00000..0x01f7ffff -> 0x01f00000" above, there is
> already a patch in Shawns tree to remove the bogus range from the DT to
> get rid of this.

Thanks for the clarification!

Regards,

Fabio Estevam
