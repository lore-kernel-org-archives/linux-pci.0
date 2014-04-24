Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.parallels.com ([199.115.105.18]:55831 "EHLO
	mx2.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbaDXRve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 13:51:34 -0400
From: James Bottomley <jbottomley@parallels.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "DL-MPTFusionLinux@lsi.com" <DL-MPTFusionLinux@lsi.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-linux-scu@intel.com" <intel-linux-scu@intel.com>,
	"iss_storagedev@hp.com" <iss_storagedev@hp.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"pv-drivers@vmware.com" <pv-drivers@vmware.com>,
	"qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
	"agordeev@redhat.com" <agordeev@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"support@lsi.com" <support@lsi.com>,
	"iscsi-driver@qlogic.com" <iscsi-driver@qlogic.com>
Subject: Re: [PATCH v2 RESEND 00/23] scsi: Use pci_enable_msix_range()
 instead of pci_enable_msix()
Date: Thu, 24 Apr 2014 17:51:09 +0000
Message-ID: <1398361868.6766.0.camel@dabdike>
References: <cover.1397461652.git.agordeev@redhat.com>
	 <20140424170903.GA29593@google.com>
In-Reply-To: <20140424170903.GA29593@google.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-04-24 at 11:09 -0600, Bjorn Helgaas wrote:
> On Mon, Apr 14, 2014 at 10:05:24AM +0200, Alexander Gordeev wrote:
> > Hello,
> > 
> > This series is against 3.15-rc1.
> > 
> > As result of deprecation of MSI-X/MSI enablement functions
> > pci_enable_msix() and pci_enable_msi_block() all drivers
> > using these two interfaces need to be updated to use the
> > new pci_enable_msi_range()  or pci_enable_msi_exact()
> > and pci_enable_msix_range() or pci_enable_msix_exact()
> > interfaces.
> 
> Hi James,
> 
> These depend on f7fc32c, which appeared in v3.15-rc1.  I had intended
> to merge these scsi updates at the same time, but I failed.  Would you
> like to take them now that f7fc32c is upstream?

OK, will add them.  I'm planning to base the scsi-misc tree on -rc3 once
we have our current crop of fixes upstream.

James

