Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43620 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbbGPRZy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2015 13:25:54 -0400
Date: Thu, 16 Jul 2015 19:25:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Daney <ddaney.cavm@gmail.com>
cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/5] arm64, pci: Add ECAM/PCIe support for Cavium
 ThunderX
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.DEB.2.11.1507161924270.18576@nanos>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 Jul 2015, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The subject pretty much says it all.  The first four patches tweak the
> infrastructure a little so that we can get required behavior.  The

Just that you avoid to describe what the required behaviour is.

Can you please provide a proper description how this looks like from
the HW side and how you want to map that into software?

Thanks,

	tglx

