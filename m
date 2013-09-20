Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab3ITIXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Sep 2013 04:23:09 -0400
Date: Fri, 20 Sep 2013 10:24:59 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
References: <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Michael et al.

The identifiable options sounded so far were:

* Do not change anything

* Make pci_enable_msix() return 0/-errno

* Make pci_enable_msix() return 0/-errno and introduce arch_get_msix_limit()/
  arch_get_msi_limit()

* Make pci_enable_msix() return 0/-errno and introduce pci_get_msix_limit()/
  pci_get_msi_limit() and arch_get_msix_limit()/arch_get_msi_limit() so that:
	pci_get_msix_limit() = min(arch_get_msix_limit(), pci_msix_table_size())
	pci_get_msi_limit()  = min(arch_get_msi_limit(),  pci_get_msi_cap())

Can we have a conclusion here?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
