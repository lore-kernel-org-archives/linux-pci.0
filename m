Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36748 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab2GUAwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2012 20:52:37 -0400
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Chris Friesen <chris.friesen@genband.com>,
	Ben Hutchings <bhutchings@solarflare.com>
CC: Don Dutile <ddutile@redhat.com>,
	David Miller <davem@davemloft.net>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: New commands to configure IOV features
Date: Sat, 21 Jul 2012 00:52:36 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A070C7D6F47@ORSMSX106.amr.corp.intel.com>
References: <5003DC9B.8000706@broadcom.com>	<5005BD00.4090106@redhat.com>
			<5005D45D.1040302@genband.com>
		 <20120717.141153.46613285253481776.davem@davemloft.net>
		 <500978C7.5050004@genband.com> <50097FBD.9080202@redhat.com>
	 <1342806146.2678.31.camel@bwh-desktop.uk.solarflarecom.com>
	 <5009B186.6000806@genband.com>
 <1342814473.2678.65.camel@bwh-desktop.uk.solarflarecom.com>
 <5009ECDF.4090305@genband.com>
In-Reply-To: <5009ECDF.4090305@genband.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Chris Friesen [mailto:chris.friesen@genband.com]
> Sent: Friday, July 20, 2012 4:42 PM
> To: Ben Hutchings
> Cc: Don Dutile; David Miller; yuvalmin@broadcom.com; Rose, Gregory V;
> netdev@vger.kernel.org; linux-pci@vger.kernel.org
> Subject: Re: New commands to configure IOV features
> 
> On 07/20/2012 02:01 PM, Ben Hutchings wrote:
> > On Fri, 2012-07-20 at 13:29 -0600, Chris Friesen wrote:
> 
> >> Once the device exists, then domain-specific APIs would be used to
> >> configure it the same way that they would configure a physical device.
> >
> > To an extent, but not entirely.
> >
> > Currently, the assigned MAC address and (optional) VLAN tag for each
> > networking VF are configured via the PF net device (though this is
> > done though the rtnetlink API rather than ethtool).
> 
> I actually have a use-case where the guest needs to be able to modify the
> MAC addresses of network devices that are actually VFs.
> 
> The guest is bonding the network devices together, so the bonding driver
> in the guest expects to be able to set all the slaves to the same MAC
> address.
> 
> As I read the ixgbe driver, this should be possible as long as the host
> hasn't explicitly set the MAC address of the VF.  Is that correct?

That is correct.

- Greg
Intel Corp.
LAN Access Division

