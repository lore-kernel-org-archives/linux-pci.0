Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod7og125.obsmtp.com ([64.18.2.28]:38206 "EHLO
	exprod7og125.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab2GTXn2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2012 19:43:28 -0400
Message-ID: <5009ECDF.4090305@genband.com>
Date: Fri, 20 Jul 2012 17:42:23 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
CC: Don Dutile <ddutile@redhat.com>,
	David Miller <davem@davemloft.net>, yuvalmin@broadcom.com,
	gregory.v.rose@intel.com, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: New commands to configure IOV features
References: <5003DC9B.8000706@broadcom.com>	<5005BD00.4090106@redhat.com>			<5005D45D.1040302@genband.com>		 <20120717.141153.46613285253481776.davem@davemloft.net>		 <500978C7.5050004@genband.com> <50097FBD.9080202@redhat.com>	 <1342806146.2678.31.camel@bwh-desktop.uk.solarflarecom.com>	 <5009B186.6000806@genband.com> <1342814473.2678.65.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1342814473.2678.65.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/20/2012 02:01 PM, Ben Hutchings wrote:
> On Fri, 2012-07-20 at 13:29 -0600, Chris Friesen wrote:

>> Once the device exists, then domain-specific APIs would be used to
>> configure it the same way that they would configure a physical device.
>
> To an extent, but not entirely.
>
> Currently, the assigned MAC address and (optional) VLAN tag for each
> networking VF are configured via the PF net device (though this is done
> though the rtnetlink API rather than ethtool).

I actually have a use-case where the guest needs to be able to modify 
the MAC addresses of network devices that are actually VFs.

The guest is bonding the network devices together, so the bonding driver 
in the guest expects to be able to set all the slaves to the same MAC 
address.

As I read the ixgbe driver, this should be possible as long as the host 
hasn't explicitly set the MAC address of the VF.  Is that correct?

Chris
