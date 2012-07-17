Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54856 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2GQVLz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 17:11:55 -0400
Date: Tue, 17 Jul 2012 14:11:53 -0700 (PDT)
Message-Id: <20120717.141153.46613285253481776.davem@davemloft.net>
To: chris.friesen@genband.com
Cc: ddutile@redhat.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: New commands to configure IOV features
From: David Miller <davem@davemloft.net>
In-Reply-To: <5005D45D.1040302@genband.com>
References: <5003DC9B.8000706@broadcom.com>
	<5005BD00.4090106@redhat.com>
	<5005D45D.1040302@genband.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Chris Friesen <chris.friesen@genband.com>
Date: Tue, 17 Jul 2012 15:08:45 -0600

> From that perspective a sysfs-based interface is ideal since it is
> directly scriptable.

As is anything ethtool or netlink based, since we have 'ethtool'
and 'ip' for scripting.
