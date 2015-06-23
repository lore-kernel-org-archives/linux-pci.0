Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56889 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbFWWwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jun 2015 18:52:30 -0400
Message-ID: <1435098868.3996.11.camel@kernel.crashing.org>
Subject: Re: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Wed, 24 Jun 2015 08:34:28 +1000
In-Reply-To: <CAErSpo6SngcV6_Ew0DOjW+xTw8y6j3UmwdPw1x-tk_AB=mapaQ@mail.gmail.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
	 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
	 <CAErSpo6SngcV6_Ew0DOjW+xTw8y6j3UmwdPw1x-tk_AB=mapaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-09-29 at 12:17 -0600, Bjorn Helgaas wrote:
> This seems like more than necessary, but I don't know all the history.
> In particular, I don't know why PCI_PROBE_ONLY should make a
> difference to things like claiming resources.

It shouldn't ... we created that option on ppc originally to avoid
allocation/reallocation of resources. If they are bad, leave them bad,
but it was never a question of disabling all these other things.

(Ok, the MRSS/MPS is debatable, but why not plumb the parent pointers
and why not claim ? That doesn't make sense to me).

Cheers,
Ben.

