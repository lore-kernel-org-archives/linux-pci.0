Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbbLUCrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 20 Dec 2015 21:47:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1aAqVd-00025s-7f
	for linux-pci@vger.kernel.org; Mon, 21 Dec 2015 03:47:41 +0100
Received: from 124.123.164.209 ([124.123.164.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2015 03:47:37 +0100
Received: from valmikibow by 124.123.164.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2015 03:47:37 +0100
To: linux-pci@vger.kernel.org
From: Valmiki <valmikibow@gmail.com>
Subject: Re: What is meant by chained interrupt handlers, when to use them.
Date: Mon, 21 Dec 2015 02:47:29 +0000 (UTC)
Message-ID: <loom.20151221T034553-263@post.gmane.org>
References: <loom.20151220T112828-725@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Valmiki <valmikibow <at> gmail.com> writes:

> 
> I'm seeing that chained_irq_enter/exit functions are being used in 
cained 
> irq handlers. 
> 
> These chained_irq_enter/exit functions are doing ack, mask, unmask 
> functions from irq chip. 
> Already when an interrupt handler is being executed that IRQ line will 
be 
> disabled by linux, so what is the purpose of masking/unmasking them.
> 
> What is term chained referring to, does it mean reading interrupt 
status 
> register and check for bit set one after and another handle that 
> corresponding IRQ, so in a chain fashion.


When we use irq_set_chained_handler the irq line will not be disabled, 
unlike request_irq ? 
If that is the case calling chained_irq_enter which does mask/unmask to 
only current irq line, but i see in some pcie root port drivers after 
calling this they are handling all the available interrupts but only one 
is masked ? Is this method correct ?

> 
> Valmiki
> 
> 




