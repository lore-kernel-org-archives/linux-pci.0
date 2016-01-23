Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50416 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbcAWUJy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jan 2016 15:09:54 -0500
Subject: Re: [PATCH v2] pci: aer: wait till the workqueue completes before
 free memory
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20151217143243.GA9654@linutronix.de>
 <20160106232758.GE16231@localhost> <20160115183625.GG3781@linutronix.de>
 <20160121205717.GA21798@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <56A3DE10.9040809@linutronix.de>
Date: Sat, 23 Jan 2016 21:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <20160121205717.GA21798@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/21/2016 09:57 PM, Bjorn Helgaas wrote:
> Hi Sebastian,

Hi Bjorn,

> I propose to merge this patch unchanged, but with the following
> changelog.  I want to add a bit more detail about the concurrency
> problem and remove a bit of the specific detail about your FPGA:

perfect, thanks.

Sebastian
