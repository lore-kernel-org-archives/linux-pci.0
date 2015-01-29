Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:42351 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbbA2Ght convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 01:37:49 -0500
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <2000255.rnmr9HfSOg@wuerfel>
Date: Thu, 29 Jan 2015 07:37:48 +0100
In-Reply-To: <2000255.rnmr9HfSOg@wuerfel> (Arnd Bergmann's message of "Wed, 28
	Jan 2015 14:53:07 +0100")
MIME-Version: 1.0
Message-ID: <m3y4omw0qr.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> The recent patch to convert the cns3xxx PCI code added an
> extraneous opening bracket, which makes the build fail,
> so remove this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Acked-by: Krzysztof Hałasa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
