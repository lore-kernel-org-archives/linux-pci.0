Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43346 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaK0KOR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Nov 2014 05:14:17 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1Xtw5X-0007Nw-6u
	for linux-pci@vger.kernel.org; Thu, 27 Nov 2014 10:14:15 +0000
Received: by mail-oi0-f52.google.com with SMTP id h136so3246019oig.39
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2014 02:14:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2081877.zLc8dS8vkP@wuerfel>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
	<2081877.zLc8dS8vkP@wuerfel>
Date: Thu, 27 Nov 2014 18:14:14 +0800
Message-ID: <CACVXFVN=M6VX31QWVzFj8MwBskjc5aYe3zJmcM1OG9xj-Y_WOA@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
From: Ming Lei <ming.lei@canonical.com>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jon Masters <jcm@redhat.com>,
	Dann Frazier <dann.frazier@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 27, 2014 at 5:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Regarding the pcibios_add_device() function, I'd rather see the existing
> code moved into the PCI core and the function removed, since it also
> is not architecture specific. We should be able to delete the entire
> arm64/pci.c file eventually.

I totally agree.

Looks pcibios_*() are misused by ARCHs, which should have been
designed for addressing ARCH pcibios things, now these functions
are just a hook for ARCH code.

Specifically pci host controller driver can't be arch independent
at all because of ARCH's pcibios_*() implementation and
the specific data type defined by ARCH code.

Thanks,
Ming Lei
