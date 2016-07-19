Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53100 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbcGSD4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jul 2016 23:56:52 -0400
Date: Tue, 19 Jul 2016 05:56:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH next] genirq: fix missing irq allocation affinity hint
Message-ID: <20160719035650.GA16838@lst.de>
References: <1467621574-8277-4-git-send-email-hch@lst.de> <1468875386-31662-1-git-send-email-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468875386-31662-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine, but I'm pretty sure irq_reserve_ipi didn't exist by the
time we did these changes..
