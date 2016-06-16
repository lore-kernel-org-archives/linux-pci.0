Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:39728 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbcFPEjx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jun 2016 00:39:53 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<7440319.e8dDgNlZLB@wuerfel> <m3oa79bbi1.fsf@t19.piap.pl>
	<5441564.aSMx8kbhED@wuerfel>
Date: Thu, 16 Jun 2016 06:39:49 +0200
In-Reply-To: <5441564.aSMx8kbhED@wuerfel> (Arnd Bergmann's message of "Fri, 10
	Jun 2016 23:57:49 +0200")
Message-ID: <m3fusdbvca.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> I'd start by copying the relevant nodes from
> arch/arm/boot/dts/arm-realview-pb11mp.dts, which is the closest
> I can think of. I've put together something completely untested
> below.

Thanks. I will try to handle that. 3+ weeks, unfortunately.

Now, what do we do with the PCIe MRRS?
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
