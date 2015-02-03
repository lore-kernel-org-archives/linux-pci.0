Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53656 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965081AbbBCM6F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 07:58:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
Date: Tue, 03 Feb 2015 13:57:17 +0100
Message-ID: <47577254.MGNlDcIDBf@wuerfel>
In-Reply-To: <54D0B2FA.9080600@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <4324891.mqG6Yyfi6J@wuerfel> <54D0B2FA.9080600@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 03 February 2015 11:37:30 Marc Zyngier wrote:
> Side question: In the probe-only case, should we still allow this write
> to happen?

No, my understanding is that PCI_PROBE_ONLY precisely means that we
do not modify the config space and instead trust what is there to
be sensible.

	Arnd
