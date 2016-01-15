Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39322 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbcAOSD5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:03:57 -0500
Date: Fri, 15 Jan 2016 19:03:54 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: aer: wait till the workqueue completes before free
 memory
Message-ID: <20160115180354.GF3781@linutronix.de>
References: <20151217143243.GA9654@linutronix.de>
 <20160106232758.GE16231@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160106232758.GE16231@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Bjorn Helgaas | 2016-01-06 17:27:58 [-0600]:

>Hi Sebastian,
Hi Bjorn,

>Your change looks reasonable.  But I'm curious about the wait_event()
>just below it.  That *looks* like it's intended to do the same thing
>as your flush_work().
Indeed.

>Can you explain why the wait_event() isn't working?  If we add the

aer_isr() invokes get_e_source() which increments rpc->cons_idx. So
the condition is valid after that and the function does not terminate
yes it invokes aer_isr_one_error().
That means if we have one CPU doing the ISR + workqueue task and another
CPU doing the aer_remove() removal thingy then the latter CPU evaluates
the condition to true and continues cleanup while the former is still in
aer_isr_one_error() wondering where the memory went.

>flush_work(), can we remove the wait_event() stuff?

I think so since its only purpose is to sync against removal which does
not work on SMP. So let me remove this and the wait_release member.

>Bjorn

Sebastian
