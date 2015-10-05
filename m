Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:37847 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbJEK2h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 06:28:37 -0400
Date: Mon, 5 Oct 2015 12:21:35 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ruud <netwerkforens@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Enumerate all undiscovered PCIe busses
Message-ID: <mj+md-20151005.101820.16366.nikam@ucw.cz>
References: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
 <20151003143056.GA17684@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151003143056.GA17684@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> This appears to be a patch for pciutils, so I cc'd Martin, who
> maintains that.

Thanks, I manage to follow linux-pci only very loosely these days...

> On Fri, Oct 02, 2015 at 06:23:36PM +0000, Ruud wrote:
> > Multiple root complexes have a different start busnumber.
> > Poll all undiscovered busses for a root complex

Unfortunately, this is not correct to do. Many systems report
junk on unused bus number (for example, they decode bus numbers
only partially, so the buses repeat).

In which situation do you need this? Is it on Linux? Only lspci,
or your own code using libpci?

Does `lspci -M' help?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Please try to fit your code to 80 columns. That's decimal 80." -- A. Morton
