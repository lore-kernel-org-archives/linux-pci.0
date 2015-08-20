Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46178 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbbHTGix (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Aug 2015 02:38:53 -0400
Message-ID: <1440052702.9177.8.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Meelis Roos <mroos@linux.ee>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Eric Snowberg <eric.snowberg@oracle.com>
Date: Thu, 20 Aug 2015 16:38:22 +1000
In-Reply-To: <CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
	 <20150818184943.GA26431@google.com>
	 <20150818.121004.1891242587946602543.davem@davemloft.net>
	 <20150819221624.GA8150@google.com>
	 <1440023349.2737.21.camel@kernel.crashing.org>
	 <CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-08-19 at 23:01 -0700, Bjorn Helgaas wrote:
> Easier said than done.  AFAIK, we won't crash after we add Yijing's
> patch.  But it's unreasonable to expect people writing to the spec to
> know the peculiarities of sparc64/powerpc, so there may be future
> things we discover the hard way.  We'll just have to deal with them as
> we find them.

I agree in general, you can't plan for all possible spec violations but
it's also pretty standard defensive coding to now blow up if stuff
doesn't look expected :)

Anyway, this one is sorted.

Cheers,
Ben.

