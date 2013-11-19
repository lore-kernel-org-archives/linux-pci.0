Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39199 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab3KSJ73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Nov 2013 04:59:29 -0500
Date: Tue, 19 Nov 2013 12:06:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [3.11.4] Thunderbolt/PCI unplug oops in pci_pme_list_scan
Message-ID: <20131119100607.GK2281@intel.com>
References: <CAMxnaaUim-MCDpaTiLmBqN3wfxjn9V6XE_n4SMfuO=vqeT6rVA@mail.gmail.com>
 <CAErSpo4KU9VAC=SnKuYH3EPz8NuozixAhUQBKv+=Y=76wywdTg@mail.gmail.com>
 <20131015024452.GA31951@srcf.ucam.org>
 <20131016202123.GA17866@google.com>
 <CAMxnaaV1DhaxKo6h85Upa8sPQz2jSYSaW1OJ7+JtvR5F9sAYZw@mail.gmail.com>
 <CAErSpo4q0rcvkHX3_L2rcJrwT-Ofu4My8JXxtxH8gyULLxTDEw@mail.gmail.com>
 <CAE9FiQUMKSak4tWiyZ-N1_50M5ytUp-JAhb7GTG29Y1aRBPuSQ@mail.gmail.com>
 <CAErSpo5yhg1EgJmmOtJeh0myd50tJuu6qVMdVnwR276WTxL8kg@mail.gmail.com>
 <20131115115235.GA2281@intel.com>
 <20131119013343.GA17294@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131119013343.GA17294@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 18, 2013 at 06:33:43PM -0700, Bjorn Helgaas wrote:
> I fixed the changelog (the extra disable was actually added by d899871936,
> not by dc5351784e) and put the patch below in my for-linus branch.  I'll
> ask Linus to pull it later this week.
> 
> Sorry for the delay, and thanks for the reminder.

Thanks!
