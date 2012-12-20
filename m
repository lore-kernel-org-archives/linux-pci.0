Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43683 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab2LTW3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Dec 2012 17:29:48 -0500
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v2] PCI SRIOV device enable and disable via sysfs
Date: Thu, 20 Dec 2012 22:29:44 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A073ED843FE@ORSMSX106.amr.corp.intel.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
 <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
 <20121214101911.00002f59@unknown> <50CF7993.9040606@redhat.com>
 <20121217232439.GA9746@google.com> <50D24355.1050100@redhat.com>
 <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com>
In-Reply-To: <CAErSpo7PUZgbD+=wXiQehHgoVtmn-9SLKvDJxQz9Mn18Fmx0TQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, December 20, 2012 1:48 PM
> To: Don Dutile
> Cc: Rose, Gregory V; linux-pci@vger.kernel.org; Yuval Mintz;
> bhutchings@solarflare.com; yinghai@kernel.org; davem@davemloft.net
> Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
> 
> On Wed, Dec 19, 2012 at 3:44 PM, Don Dutile <ddutile@redhat.com> wrote:
> > Overall, yet-another-good-clean-up-by-Bjorn ! :) nits below...
> >
> > oh, you can add
> > Tested-by: Donald Dutile <ddutile@redhat.com>
> >
> > if you'd to the final commit.
> 
> I made the -EPERM change suggested by Greg and added this to my
> pci/for-3.8 branch.  I'll ask Linus to pull it soon after v3.8-rc1.
> 
> Bjorn

Thanks!

- Greg

