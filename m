Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:42556 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbcFALJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 07:09:04 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Wed, 01 Jun 2016 13:08:59 +0200
In-Reply-To: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	(Bjorn Helgaas's message of "Tue, 31 May 2016 16:58:02 -0500")
Message-ID: <m3inxt17zo.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> This reverts commit 498a92d42596a7a32c042319eb62a4c3d8081cf1.
>
> Krzysztof reported that this change broke Cavium CNS3xxx, ARMv6 (Laguna
> GW-2388) because the MRRS setting is never written to the hardware.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Krzysztof Hałasa <khalasa@piap.pl>
> ---
>  arch/arm/mach-cns3xxx/pcie.c |   71 ++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 30 deletions(-)

This, applied to v4.7-rc1, fixes the problem on my Laguna boards.

Tested-by: Krzysztof Hałasa <khalasa@piap.pl>

And as well

Acked-by: Krzysztof Hałasa <khalasa@piap.pl>

Thanks.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
