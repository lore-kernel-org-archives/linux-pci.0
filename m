Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56104 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbbHTRuT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 13:50:19 -0400
Date: Thu, 20 Aug 2015 10:50:17 -0700 (PDT)
Message-Id: <20150820.105017.921228882849805352.davem@davemloft.net>
To: bhelgaas@google.com
Cc: benh@kernel.crashing.org, wangyijing@huawei.com,
	linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
References: <20150819221624.GA8150@google.com>
	<1440023349.2737.21.camel@kernel.crashing.org>
	<CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Aug 2015 23:01:19 -0700

> Easier said than done.  AFAIK, we won't crash after we add Yijing's
> patch.  But it's unreasonable to expect people writing to the spec to
> know the peculiarities of sparc64/powerpc, so there may be future
> things we discover the hard way.  We'll just have to deal with them as
> we find them.

I think it is unreasonable to assume that the PCI root complex is
presented as a device in the full PCI bus hierarchy.

If one wanted to chop the system up into multiple physical components,
hiding the PCI root complex behind some controlled entity (hypervisor
or whatever) is the only way to accomplish that.

Therefore it is a very reasonable and perhaps even expected design
decision to do what both powerpc and sparc64 have done.
