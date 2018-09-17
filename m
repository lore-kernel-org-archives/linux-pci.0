Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:45724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQU1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 16:27:39 -0400
Date: Mon, 17 Sep 2018 07:59:56 -0700 (PDT)
Message-Id: <20180917.075956.2226248627299867563.davem@davemloft.net>
To: stephen@networkplumber.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hv_netvsc: associate VF and PV device by serial
 number
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180914195457.20433-1-sthemmin@microsoft.com>
References: <20180914195457.20433-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 14 Sep 2018 12:54:55 -0700

> The Hyper-V implementation of PCI controller has concept of 32 bit serial number
> (not to be confused with PCI-E serial number).  This value is sent in the protocol
> from the host to indicate SR-IOV VF device is attached to a synthetic NIC.
> 
> Using the serial number (instead of MAC address) to associate the two devices
> avoids lots of potential problems when there are duplicate MAC addresses from
> tunnels or layered devices.
> 
> The patch set is broken into two parts, one is for the PCI controller
> and the other is for the netvsc device. Normally, these go through different
> trees but sending them together here for better review. The PCI changes
> were submitted previously, but the main review comment was "why do you
> need this?". This is why.
> 
> v2 - slot name can be shorter.
>      remove locking when creating pci_slots; see comment for explaination

Series applied, thanks.
