Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18090 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab2JCSRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 14:17:00 -0400
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Yinghai Lu <yinghai@kernel.org>, Don Dutile <ddutile@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
Date: Wed, 3 Oct 2012 18:16:58 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A07153272A0@ORSMSX106.amr.corp.intel.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>	<20121002203951.GA28663@kroah.com>
	<506B575A.4060304@redhat.com>	<20121003031018.GB13391@kroah.com>
	<506C3B11.9010009@redhat.com>
 <CAE9FiQUH9LUwrX2_5zoaDBe3pBHBXC4rOctpNMwGN2nJM5pMRQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUH9LUwrX2_5zoaDBe3pBHBXC4rOctpNMwGN2nJM5pMRQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 -----Original Message-----
> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
> Yinghai Lu
> Sent: Wednesday, October 03, 2012 10:56 AM
> To: Don Dutile
> Cc: Greg Kroah-Hartman; linux-pci@vger.kernel.org; bhelgaas@google.com;
> yuvalmin@broadcom.com; bhutchings@solarflare.com; Rose, Gregory V;
> davem@davemloft.net
> Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
> device level
> 
> On Wed, Oct 3, 2012 at 6:18 AM, Don Dutile <ddutile@redhat.com> wrote:
> > maybe once i figure out the proper sriov sysfs code, I can duplicate
> > that effort in the reset,vga & pm-capabilities section.
> 
> I resent my patcheset in plain mail instead of attached form.
> 
> I am thinking we should ixgbe guys to sort out ixgbe change to use
> set_max_vfs ops.

I'm willing to do that but I'm sort of waiting for things to settle out a bit and see which set of patches everyone settles on before diving into it.

- Greg

> 
> Thanks
> 
> Yinghai
