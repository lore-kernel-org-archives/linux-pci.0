Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from webmail.solarflare.com ([12.187.104.25]:55260 "EHLO
	ocex02.SolarFlarecom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753278Ab2JaRhF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 13:37:05 -0400
Message-ID: <1351705018.2706.9.camel@bwh-desktop.uk.solarflarecom.com>
Subject: RE: [PATCH 3/8] PCI: sysfs per device SRIOV control and status
From: Ben Hutchings <bhutchings@solarflare.com>
To: "Rose, Gregory V" <gregory.v.rose@intel.com>
CC: Don Dutile <ddutile@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Date: Wed, 31 Oct 2012 17:36:58 +0000
In-Reply-To: <C5551D9AAB213A418B7FD5E4A6F30A072D54CD4F@ORSMSX106.amr.corp.intel.com>
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
	 <1351190310-5043-4-git-send-email-ddutile@redhat.com>
	 <1351196234.2662.37.camel@bwh-desktop.uk.solarflarecom.com>
	 <508AA719.2060705@redhat.com>
	 <C5551D9AAB213A418B7FD5E4A6F30A072D54CD4F@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-10-31 at 17:01 +0000, Rose, Gregory V wrote:
> > -----Original Message-----
> > From: Don Dutile [mailto:ddutile@redhat.com]
> > Sent: Friday, October 26, 2012 8:07 AM
> > To: Ben Hutchings
> > Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; yuvalmin@broadcom.com;
> > Rose, Gregory V; yinghai@kernel.org; davem@davemloft.net
> > Subject: Re: [PATCH 3/8] PCI: sysfs per device SRIOV control and status
> > 
>  
> > 
> > Ok, my turn:
> > Any feedback on having the sysfs configure call
> > pci_sriov_[enable/disable](), as well as do the don't-disable if VFs are
> > assigned to guests?
> > 
> 
> Don,
> 
> As I've mentioned before I still prefer to have the sysfs interface
> you've written up make the calls to pci_sriov_enable/disable()

I think that would work for sfc, assuming the driver function is to be
called before either of those.  I don't know whether it would work for
any of the other drivers with SR-IOV back-ends, though.

> and have the checking for whether the VFs are assigned to guests done
> there also,

I agree that this is should be centralised, though I think that could be
done as a later step without too much pain.

> but really it isn't anything worth going to the mats about.  As it
> stands I think if you address the issues brought up by Ben then I'm
> fine with what you've worked up so far.  Since no one else seems to
> have an opinion about it (as demonstrated by a lack of response over
> the last 5 days) then I'd suggest we go forward with the current
> implementation.  I'd really like to see this in 3.8 if possible.
> 
> Thanks for all your work.

Agreed, thanks Don.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

