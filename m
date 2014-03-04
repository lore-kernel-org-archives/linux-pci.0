Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27432 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932503AbaCDVLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 16:11:42 -0500
From: "Nelson, Shannon" <shannon.nelson@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Borkmann <dborkman@redhat.com>
CC: "e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: RE: [E1000-devel] kmemleak through e1000?
Date: Tue, 4 Mar 2014 21:11:41 +0000
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418A1ECC8F@FMSMSX102.amr.corp.intel.com>
References: <5315F785.4050602@redhat.com>
 <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com>
In-Reply-To: <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> 
> On Tue, Mar 4, 2014 at 8:55 AM, Daniel Borkmann <dborkman@redhat.com>
> wrote:
> > Hi all, I'm not very familiar with the e1000 code, but on the latest
> > net.git kernel I get reliably the following (not sure if it's actually
> > caused by e1000 though):
> 
> Thanks a lot for the report.  What kernel is this exactly (URL and
> SHA-1 hash)?  We have fixes for a couple leaks already queued up [1,
> 2], so possibly you're seeing those leaks.  If you already have those
> fixes in net.git, then we should investigate further.
> 
> Bjorn


FYI - I've recently seen similar kmemleak reports from ixgbe and i40e drivers, all seemly pointing to the msix allocations.  I didn't have a chance to track them down, but they were seen in variations of net-next 3.14.0-rc3.

sln

