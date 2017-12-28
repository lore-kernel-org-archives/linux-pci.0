Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdL1W6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 17:58:04 -0500
Date: Thu, 28 Dec 2017 23:57:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
In-Reply-To: <20171228225014.GE10658@chirva-slack.chirva-slack>
Message-ID: <alpine.DEB.2.20.1712282357380.1899@nanos>
References: <20171228142117.GA10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281531120.1899@nanos> <20171228154835.GB10658@chirva-slack.chirva-slack> <20171228160522.GC10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281706010.1899@nanos>
 <20171228172250.GD10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281823140.1899@nanos> <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu> <alpine.DEB.2.20.1712281930590.1899@nanos> <alpine.DEB.2.20.1712282253180.1899@nanos>
 <20171228225014.GE10658@chirva-slack.chirva-slack>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:

> Attached.
> 
> I don't have a 4.14 family kernel available at the moment on that
> machine. What I'm attaching comes from the 4.13 one I was playing with
> yesterday, what with kexec and all.

Good enough. Thanks !
