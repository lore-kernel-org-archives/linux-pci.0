Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:48968 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbDIOh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 10:37:29 -0400
Date: Thu, 9 Apr 2015 16:37:26 +0200
From: Martin Mares <mj@ucw.cz>
To: Felix Janda <felix.janda@posteo.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils] pread.h: Remove support for libc5
Message-ID: <mj+md-20150409.143708.45807.nikam@ucw.cz>
References: <20150329085931.GA8259@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150329085931.GA8259@euler>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The support code for libc5 breaks building on linux i386 with
> other libcs that don't define __GLIBC__.

Thanks, applied.  I will release pciutils-3.3.1 in a couple of minutes.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Immanuel doesn't pun, he Kant.
