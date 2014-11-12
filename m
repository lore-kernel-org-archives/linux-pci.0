Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:39318 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbaKLGTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 01:19:31 -0500
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1415287936-31203-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1415287936-31203-2-git-send-email-lorenzo.pieralisi@arm.com>
Date: Wed, 12 Nov 2014 07:12:48 +0100
In-Reply-To: <1415287936-31203-2-git-send-email-lorenzo.pieralisi@arm.com>
	(Lorenzo Pieralisi's message of "Thu, 6 Nov 2014 15:32:13 +0000")
MIME-Version: 1.0
Message-ID: <m38ujhgd5r.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: pci: remove artificial dependency on pci_sys_data domain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On cns3xxx platforms the PCI controller probing code relies on an
> artificial dependency on the domain number to look-up the internal
> data structures.
>
> This patch reworks the host controller control data structure and
> adds a domain equivalent field named port in it so that the dependency on
> pci_sys_data domain field can be eventually removed.

Looks sane.
Acked-by: Krzysztof Hałasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
