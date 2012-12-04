Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/3] aerdrv: Enhanced AER logging
Date: Tue, 4 Dec 2012 20:14:10 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F9516EEACD@G4W3218.americas.hpqcorp.net>
References: <20121204170429.31397.50068.stgit@grignak.americas.hpqcorp.net>
	<20121204170436.31397.40857.stgit@grignak.americas.hpqcorp.net>
 <20121204164151.66b9bb37@redhat.com>
In-Reply-To: <20121204164151.66b9bb37@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > +	if (!dev) {
> > +		pr_info("PCI AER Cannot get PCI device
> %04x:%02x:%02x.%d\n",
> > +			pcie->device_id.segment, pcie->device_id.bus,
> > +			pcie->device_id.slot, pcie->device_id.function);
> 
> Hmm... please correct if I'm wrong, but an error happened at PCI, and
> also a
> kernel bug that prevented it to get the proper PCI device...
> 
> IMHO, the message here should be stronger, and likely printed via
> pr_err().
> 

Mauro,

I modeled this message after other places in the kernel where this function failed.  So I figured it would be safe to be consistent there.  I agree though that it should be pr_err().  I can make that change.
