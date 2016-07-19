Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55346 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbcGSMac (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2016 08:30:32 -0400
Date: Tue, 19 Jul 2016 14:03:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: =?ISO-8859-15?Q?Vincent_Stehl=E9?= <vincent.stehle@laposte.net>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH next] genirq: fix missing irq allocation affinity hint
In-Reply-To: <20160719035650.GA16838@lst.de>
Message-ID: <alpine.DEB.2.11.1607191403060.3596@nanos>
References: <1467621574-8277-4-git-send-email-hch@lst.de> <1468875386-31662-1-git-send-email-vincent.stehle@laposte.net> <20160719035650.GA16838@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Jul 2016, Christoph Hellwig wrote:

> Looks fine, but I'm pretty sure irq_reserve_ipi didn't exist by the
> time we did these changes..

It did, but I simply forgot to fix it up.

