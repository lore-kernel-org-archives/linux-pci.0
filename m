Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52467 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab2ECS32 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2012 14:29:28 -0400
Message-ID: <4FA2CE85.8080006@linutronix.de>
Date: Thu, 03 May 2012 20:29:25 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org,
	Alessio Igor Bogani <abogani@kernel.org>,
	Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] scripts/modpost: check for bad refernces in .pci.fixups
 area
References: <1336058590-18049-1-git-send-email-bigeasy@linutronix.de> <CAErSpo6kqfxvVU5JvS99-GCdeHHKceWcwnAjpd_gi=O34GCsfQ@mail.gmail.com>
In-Reply-To: <CAErSpo6kqfxvVU5JvS99-GCdeHHKceWcwnAjpd_gi=O34GCsfQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/03/2012 08:12 PM, Bjorn Helgaas wrote:
> Most of the things this finds are quirks for devices one could argue
> are not hot-pluggable, like northbridges, I/O APICs, etc.  But some of
> those are becoming hot-pluggable, and I think it's too easy to make
> the wrong __init/__devinit decision, so I think the safest thing is to
> make them all __devinit.

I got here via a PCIe-bridge quirk. The bridge itself is not removed
but the quirk is executed after "echo 1 > remove" followed by rescan.

> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
>
> I assume this will be merged via a kbuild tree; let me know if otherwise.

I tried to figured who is in charge here. I guess either Marek or
Alessio Bogani will take it. Atleast I have the PCI-ack here :)

> Will you post a follow-up patch to fix the PCI quirk annotations?

Since you are fine with it, let me try to prepare some.

Sebastian
