Return-Path: <linux-kernel-owner@vger.kernel.org>
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] ARM: cns3xxx: pci: avoid potential stack overflow
References: <2273145.0Ls8cProhs@wuerfel> <m3fv6i8qnh.fsf@t19.piap.pl>
	<201510072201.51697.arnd@arndb.de> <12713701.B4epxIQJNF@wuerfel>
Date: Thu, 08 Oct 2015 12:03:18 +0200
In-Reply-To: <12713701.B4epxIQJNF@wuerfel> (Arnd Bergmann's message of "Wed,
	07 Oct 2015 22:05:49 +0200")
Message-ID: <m3vbahy8wp.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Arnd Bergmann <arnd@arndb.de> writes:

> With those two changes in place, we no longer need the fake
> pci_sys_data/pci_bus structures for faking config space writes,
> and the stack usage goes down as well.

>  arch/arm/mach-cns3xxx/pcie.c | 71 +++++++++++++++++++++++++++++----------------------------------------

I'm ATM unable to test this change, but will do that at some point.
Meanwhile, I guess there is nothing I can say against this patch.
Thanks.

Acked-by: Krzysztof Hałasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
