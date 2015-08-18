Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:32966 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbHRDwY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 23:52:24 -0400
Received: by lbbsx3 with SMTP id sx3so94637504lbb.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 20:52:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439809578-13654-6-git-send-email-l.stach@pengutronix.de>
References: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
	<1439809578-13654-6-git-send-email-l.stach@pengutronix.de>
Date: Tue, 18 Aug 2015 09:22:23 +0530
Message-ID: <CAHM4w1mBTaGiar7b_aWi4z9XZw1R9OsBoVhOtvFEUrjwMqr64w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] PCI: designware: set up high part of MSI target address
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:36 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Set up the high part of the MSI target address in order to allow the
> MSI target to reside above the 4GB mark on 64bit and PAE systems.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
