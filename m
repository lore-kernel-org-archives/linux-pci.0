Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60347 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752293AbaBTUmp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 15:42:45 -0500
Date: Thu, 20 Feb 2014 21:42:41 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	jg1.han@samsung.com, Jason Cooper <jason@lakedaemon.net>,
	mohit.kumar@st.com
Subject: Re: Serialization of configuration accesses for mvebu/designware
Message-ID: <20140220214241.633a5a2b@skate>
In-Reply-To: <CAPcvp5FJLcpe8PunwAyjRBvzESqxx1kv4Sqy0Oqc87Gn9AY3Eg@mail.gmail.com>
References: <CAPcvp5FJLcpe8PunwAyjRBvzESqxx1kv4Sqy0Oqc87Gn9AY3Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Andrew Murray,

On Thu, 20 Feb 2014 18:51:32 +0000, Andrew Murray wrote:

> I've noticed that the mvebu and designware both use spinlocks to
> serialize access to the configuration space (pci_ops.[read|write]).
> However the read/write ops are only ever used from the pci core
> (access.c, pci.c) where they are already protected with the pci_lock.
> 
> As far as I can tell these extra spinlocks are superfluous, therefore...
> 
> Can they be removed?
> Can future host bridge drivers assume that calls to the pci_ops are serialized?

Just had a quick look, and indeed all the PCI configuration space
access functions in drivers/pci/access.c seem to be taking the
pci_lock, making the internal driver lock useless. Patches welcome! :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
