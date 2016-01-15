Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6464 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbcAOUCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 15:02:07 -0500
Date: Fri, 15 Jan 2016 13:02:05 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Veal, Bryan E" <bryan.e.veal@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115200205.GA7467@localhost.localdomain>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <8D943B239464E04C9184454D8B3F5CFF0ABF18EC@ORSMSX101.amr.corp.intel.com>
 <20160115195407.GA14947@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115195407.GA14947@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 07:54:08PM +0000, Keith Busch wrote:
> On Fri, Jan 15, 2016 at 11:48:11AM -0800, Derrick, Jonathan wrote:
> > Hi folks,
> > 
> > The VMD driver can be built as a module, so the following symbols need to be exported:
> > pci_msi_create_irq_domain
> > msi_desc_to_pci_dev
> 
> Hi Jon,
> 
> Your tree is a little old. It's added in commit a4289dc2ec3a5:
> 
>  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a4289dc2ec3a5821076a78ee9678909b4eff297e
> 
> But since you mention it, this is not in the pci repo yet either, but
> it's a clean cherry-pick for us to test.

Aha, good catch
