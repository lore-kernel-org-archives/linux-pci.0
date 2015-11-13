Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34879 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbbKMAXc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 19:23:32 -0500
Received: by pasz6 with SMTP id z6so83571366pas.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2015 16:23:32 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
In-Reply-To: <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 11:23:27 +1100
Message-ID: <87bnayzr0g.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Following some discussion on IRC, it looks like there are roughly 2
machines on the planet with skiboot and p5ioc2, so I'm not worried about
that any more.

I am still vaguely concerned about a failing fundamental reset.

Regards,
Daniel
