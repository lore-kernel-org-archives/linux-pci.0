Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pavel Fedin <p.fedin@samsung.com>
To: 'David Daney' <ddaney@caviumnetworks.com>,
	'David Daney' <ddaney.cavm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	'Catalin Marinas' <catalin.marinas@arm.com>,
	'Will Deacon' <will.deacon@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, 'Thomas Gleixner' <tglx@linutronix.de>,
	'Jason Cooper' <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org,
	'Robert Richter' <rrichter@cavium.com>,
	'David Daney' <david.daney@cavium.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-3-git-send-email-ddaney.cavm@gmail.com>
 <01a101d0db52$2d23b360$876b1a20$@samsung.com>
 <55D5F0E1.30702@caviumnetworks.com>
In-reply-to: <55D5F0E1.30702@caviumnetworks.com>
Subject: RE: [PATCH 2/5] gic-its: Allow pci_requester_id to be overridden.
Date: Tue, 25 Aug 2015 14:01:22 +0300
Message-id: <012a01d0df25$61515ad0$23f41070$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hello!

> >   What if instead of this function we simply add a field to a struct pci_bus ? Then bus driver
would
> > fill in HW-specific ID bits for every bus.
> >   I can send a patch if interested.
> 
> There is a lot of work being done in the upstream to extract the proper
> information from the device tree.  We are going to piggyback on that for
> the next versions of the patch.

 Where can i take a look at the code?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

