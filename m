Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35229 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbDFWfl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2015 18:35:41 -0400
MIME-Version: 1.0
In-Reply-To: <20150406220638.GH10892@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
Date: Mon, 6 Apr 2015 15:35:40 -0700
Message-ID: <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 6, 2015 at 3:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> But this is a general change that affects all platforms, and it's late in
> the cycle for something as invasive as this.  I'd rather include your patch
> in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
> windows to fit in upstream windows") for v4.0.

How about applying first two in this patchset for v4.0, and leaving
this one for v4.1?

Thanks

Yinghai
