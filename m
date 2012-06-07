Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48392 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2FGRJv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jun 2012 13:09:51 -0400
Date: Thu, 7 Jun 2012 18:13:05 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <andi@firstfloor.org>
Cc: Matthew Garrett <mjg@redhat.com>, Khalid Aziz <khalid.aziz@hp.com>,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Disable Bus Master on PCI device shutdown
Message-ID: <20120607181305.2c444be6@pyramind.ukuu.org.uk>
In-Reply-To: <m21ulrjbji.fsf@firstfloor.org>
References: <20120427190033.GA17588@ldl.usa.hp.com>
	<20120606135009.GB1517@srcf.ucam.org>
	<20120606215034.257d7549@pyramind.ukuu.org.uk>
	<m21ulrjbji.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> But it also makes my system do kexec successfully for the first time.
> 
> Maybe can make it an option.

More useful might be to report which devices have the bus master bit left
on at the time you tried the kexec, then we might actually find the bug.

Alan
