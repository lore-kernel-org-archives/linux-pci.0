Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35962 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbDIELW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 00:11:22 -0400
MIME-Version: 1.0
In-Reply-To: <1428549459.18187.56.camel@kernel.crashing.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
	<20150406.203533.1356187749826485194.davem@davemloft.net>
	<CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	<20150408154759.GN10892@google.com>
	<1428527527.18187.28.camel@kernel.crashing.org>
	<CAE9FiQXQN-VqN3ynLEhHh5WUYE+8tLR8ubKKMeHZ3h=BQ0rA9A@mail.gmail.com>
	<1428549459.18187.56.camel@kernel.crashing.org>
Date: Wed, 8 Apr 2015 21:11:21 -0700
Message-ID: <CAE9FiQUnpKmQmeHvBpk1t-NSAPuWAC9tX7LXeGpVR1w78i658g@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 8, 2015 at 8:17 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-04-08 at 17:06 -0700, Yinghai Lu wrote:

> I'll let Bjorn be the final judge here but I am not fan of the way you
> set/clear/set/clear the IORESOURCE_PREFETCH bit with
> pci_set_pref_under_pref(). It's error prone and confusing, the code is
> already barely readable as it is ...

We only use them to wrapping final pci_claim*, sizing, and assigning.
that is limited places.

>
> I would rather you replace those various masks compares with a helper
> that does something like pci_resource_compatible(parent_res, child_res),
> which has the logic to test. That or a helper that does something like
> pci_calc_compatible_res_flags() which returns a "flags" that has
> PREFETCH set, which you use in place of res->flags in the various
> allocation path.

That way should be more intrusive to current code, as we are using
type_mask checking to share the code among
parent(pref)/child(pref), parent(no-pref)/child(pref), and
parent(no-pref)/child(pref)

        Yinghai
