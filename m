Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:59139 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbcEVH7E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 22 May 2016 03:59:04 -0400
Date: Sun, 22 May 2016 09:59:00 +0200
From: Martin Mares <mj@ucw.cz>
To: Ian Stakenvicius <axs@gentoo.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Fix lack of exposure of pci_init for LIBPCI_3.0 on
 pciutils-3.5.0
Message-ID: <mj+md-20160522.075835.65452.nikam@ucw.cz>
References: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> The changes included in commit ab61451d47514c473953a24aa4f4f816b77
> were not sufficient to maintain ABI compatibility with older versions
> of libpci.so.3, as pci_init is only exposed under symbol version
> LIBPCI_3.5.
> 
> This patch uses the code pattern for the versioning of pci_fill_info()
> to ensure a pci_init symbol is exposed with LIBPCI_3.0 version.

Oops. Thanks for spotting this.

Fixed and released as version 3.5.1.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Even nostalgia isn't what it used to be.
