Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:47223 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3DZHPq convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:6:1>);
	Fri, 26 Apr 2013 03:15:46 -0400
Message-Id: <517A45E602000078000D0F78@nat28.tlf.novell.com>
Date: Fri, 26 Apr 2013 08:16:22 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>,
	"Gavin Shan" <shangw@linux.vnet.ibm.com>,
	<xen-devel@lists.xensource.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v4 18/22] xen/pci: Pay attention to
 PCI_MSIX_TABLE_OFFSET
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
 <20130422231214.32621.37394.stgit@bhelgaas-glaptop>
 <CAErSpo6BF0Uvf=7LwYYT2Qn6kf5uk+rVqY-cKOe2qnVwcj4-+w@mail.gmail.com>
 <5179164902000078000D0A26@nat28.tlf.novell.com>
 <20130425164238.GA3052@google.com>
In-Reply-To: <20130425164238.GA3052@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 25.04.13 at 18:42, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Apr 25, 2013 at 10:40:57AM +0100, Jan Beulich wrote:
>> Recent hypervisors will actually
>> only consume this to issue a warning if not matching what gets
>> read from the corresponding BAR. Earlier hypervisors used this
>> instead of reading the BAR.
> 
> Note that pci_resource_start() gives you a CPU address, and what you
> read from the BAR is a PCI bus address.  These are not in the same
> address space and can't be directly compared.  I assume the
> hypervisors take that into account and do the appropriate
> conversions?

I suppose Xen has never been run on a system where the two
would differ, and it's quite likely that it would break on such
systems. Question is - are there any x86-based systems where
this is the case?

Jan

