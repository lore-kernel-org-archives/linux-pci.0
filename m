Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40010 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbbLTKfM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 20 Dec 2015 05:35:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1aAbKT-0001t3-Hb
	for linux-pci@vger.kernel.org; Sun, 20 Dec 2015 11:35:09 +0100
Received: from 124.123.164.209 ([124.123.164.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 20 Dec 2015 11:35:05 +0100
Received: from valmikibow by 124.123.164.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 20 Dec 2015 11:35:05 +0100
To: linux-pci@vger.kernel.org
From: Valmiki <valmikibow@gmail.com>
Subject: What is meant by chained interrupt handlers, when to use them.
Date: Sun, 20 Dec 2015 10:30:35 +0000 (UTC)
Message-ID: <loom.20151220T112828-725@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm seeing that chained_irq_enter/exit functions are being used in cained 
irq handlers. 

These chained_irq_enter/exit functions are doing ack, mask, unmask 
functions from irq chip. 
Already when an interrupt handler is being executed that IRQ line will be 
disabled by linux, so what is the purpose of masking/unmasking them.

What is term chained referring to, does it mean reading interrupt status 
register and check for bit set one after and another handle that 
corresponding IRQ, so in a chain fashion.

Valmiki

