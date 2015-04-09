Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48758 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933539AbbDII5L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Apr 2015 04:57:11 -0400
Message-ID: <1428569815.18187.71.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Thu, 09 Apr 2015 18:56:55 +1000
In-Reply-To: <CAE9FiQUnpKmQmeHvBpk1t-NSAPuWAC9tX7LXeGpVR1w78i658g@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	 <1427857069-6789-4-git-send-email-yinghai@kernel.org>
	 <20150406220638.GH10892@google.com>
	 <20150406.203533.1356187749826485194.davem@davemloft.net>
	 <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	 <20150408154759.GN10892@google.com>
	 <1428527527.18187.28.camel@kernel.crashing.org>
	 <CAE9FiQXQN-VqN3ynLEhHh5WUYE+8tLR8ubKKMeHZ3h=BQ0rA9A@mail.gmail.com>
	 <1428549459.18187.56.camel@kernel.crashing.org>
	 <CAE9FiQUnpKmQmeHvBpk1t-NSAPuWAC9tX7LXeGpVR1w78i658g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-04-08 at 21:11 -0700, Yinghai Lu wrote:
> That way should be more intrusive to current code, as we are using
> type_mask checking to share the code among
> parent(pref)/child(pref), parent(no-pref)/child(pref), and
> parent(no-pref)/child(pref)

That's fine, as long as the helper knows which one is the parent and
which one is the child.

In fact, as "cute" as the mask trick is, I think it would generally make
the code more self explanatory if it explicitly tested for the
combinations that are supported, ie something like

	if (parent_is_pref && !child_is_pref && child->pcie_only)
		...
	else if (!parent_is_pref)
		...
etc...

The impact in performance would be in the noise and the logic of the
algorithm a LOT more explicit.

Cheers,
Ben.


