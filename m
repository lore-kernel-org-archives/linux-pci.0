Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64134 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbbLQSQD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 13:16:03 -0500
Date: Thu, 17 Dec 2015 18:16:00 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv6 6/7] aer_inject: Use 32 bit int type domains
Message-ID: <20151217181600.GC31031@localhost.localdomain>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-7-git-send-email-keith.busch@intel.com>
 <20151217174615.GE23549@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217174615.GE23549@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 11:46:15AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 02:32:28PM -0700, Keith Busch wrote:
> > -	u16 domain;
> > +	int domain;
> 
> If you want 32 bits explicitly, why don't you use u32 here?

It matches the types already defined in struct pci_dev and the
pci_domain_nr return value.

Would you prefer changing all of them to u32, just aer_inject's, or
leave as-is?
