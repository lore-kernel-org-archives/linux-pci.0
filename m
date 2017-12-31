Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:59208 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdLaR2f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Dec 2017 12:28:35 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 727A01C00DF
        for <linux-pci@vger.kernel.org>; Sun, 31 Dec 2017 18:19:16 +0100 (CET)
Date: Sun, 31 Dec 2017 18:19:16 +0100
From: Martin Mares <mj@ucw.cz>
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciutils: Add the support for a DOS/DJGPP environment
Message-ID: <mj+md-20171231.171835.6705.albireo@ucw.cz>
References: <13afd9a4-3b56-b60d-19fc-1bad7b96e0ee@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13afd9a4-3b56-b60d-19fc-1bad7b96e0ee@assembler.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Here is bit a blast from the past. The flashrom still supports the DOS/DJGPP environment, which requires
> pciutils to be compiled with DJGPP. I originally developed this patch in 2010,
> and I respun it for latest pciutils.
> 
> * Add DJGPP as an OS target
> * Stop if endianess macros are not defined
> * Introduce new intel_io_lock/unclock function to synchronize
>   I/O operations.
> 
> There is a small issue left that "lspci" and "lspci.exe" are created. The ".exe" variants
> are not installed and also not cleaned. No idea if you want to fix that or not.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Every program in development at MIT expands until it can read mail.
