Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:41316 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab3LEAKs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 19:10:48 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so12311135vcb.15
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2013 16:10:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312050049.31019.marex@denx.de>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
	<201312020908.31316.marex@denx.de>
	<CAOMZO5B26G0nAqjAsuR4mkRMtfE6jbSQHfa=ZSLGGEbOP-1smQ@mail.gmail.com>
	<201312050049.31019.marex@denx.de>
Date: Wed, 4 Dec 2013 22:10:47 -0200
Message-ID: <CAOMZO5CpqXEv87CwA5v8_OC0TOnZ1cRu+eerxWnnzWhh_RaCbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
From: Fabio Estevam <festevam@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 4, 2013 at 9:49 PM, Marek Vasut <marex@denx.de> wrote:

> The current behavior is botched then. If this would be compilable as a module

Right, so a separate patch needs to be done in order to fix current behavior.

Regards,

Fabio Estevam
