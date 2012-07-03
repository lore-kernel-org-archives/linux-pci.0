Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:52921 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2GCHB3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 03:01:29 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 3 Jul 2012 01:01:28 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3327A19D804A
	for <linux-pci@vger.kernel.org>; Tue,  3 Jul 2012 07:01:23 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6371E0V176852
	for <linux-pci@vger.kernel.org>; Tue, 3 Jul 2012 01:01:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6371AET017022
	for <linux-pci@vger.kernel.org>; Tue, 3 Jul 2012 01:01:13 -0600
Date: Tue, 3 Jul 2012 15:01:06 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	bhelgaas@google.com, yinghai@kernel.org, benh@kernel.crashing.org,
	linuxram@us.ibm.com
Subject: Re: [PATCH V5 0/7] minimal alignment for p2p bars
Message-ID: <20120703070106.GA13892@shangw>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Could you please review it when you have time?

Thanks,
Gavin

>v1 -> v2:
>	* Shorten the varaible names so that they looks more short.
>	* Changelog adjustment so that they looks more meaningful.
>
>v2 -> v3:
>	* Rebase to 3.5.RC4
>
>v3 -> v4:
>	* Merge Yinghai's patches.
>
>v3 -> v4:
>	* Split patch for easy review.
>	* Add function to retrieve the minimal alignment of p2p bridge. 
>
>Lu Yinghai(3):
>  pci: change variable name for find_pci_host_bridge
>  pci: argument pci_bus for find_pci_host_bridge
>  pci: fiddle with conversion of pci and CPU address
>
>Gavin Shan(4)
>  pci: make find_pci_host_bridge global
>  pci: minimal alignment for bars of P2P bridges
>  pci: function to retrieve alignment of p2p bars
>  pci: resource assignment based on p2p alignment
>
> drivers/pci/host-bridge.c |   59 ++++++++++++++++++++++++++++++++++++---------
> drivers/pci/probe.c       |    5 ++++
> drivers/pci/setup-bus.c   |   22 +++++++++++------
> include/linux/pci.h       |   15 +++++++++++-
> 4 files changed, 81 insertions(+), 20 deletions(-)
>
>Thanks,
>Gavin
>

