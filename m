Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32963 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab2IQKvf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 06:51:35 -0400
Date: Mon, 17 Sep 2012 11:56:19 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan Schreiber <info@fs-driver.org>
Cc: linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	679545@bugs.debian.org, jrnieder@gmail.com
Subject: Re: [RFC/PATCH] ia64, SR870, EFI bug breaks ata_piix, uninitialized
 ICH4 IDE EXBAR mem resource
Message-ID: <20120917115619.13d3a3cb@pyramind.ukuu.org.uk>
In-Reply-To: <20120916183914.Horde._TGALdjz9kRQVgCy6ATxxJA@webmail.df.eu>
References: <20120916183914.Horde._TGALdjz9kRQVgCy6ATxxJA@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

My only disagreement here would be putting it in the ia64 paths. If
someone does the same for x86-32 (and this is EFI so it'll presumbly
smell the same on all platforms) then we'll want the same.

Better I think to generically catch the 0/0 case.

Alan

