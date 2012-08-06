Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48899 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab2HFEv4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 00:51:56 -0400
Message-ID: <501F4D69.9060100@gmail.com>
Date: Sun, 05 Aug 2012 22:51:53 -0600
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Account for virtual buses in pci_acs_path_enabled
References: <20120804181445.6598.6505.stgit@bling.home>
In-Reply-To: <20120804181445.6598.6505.stgit@bling.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/4/12 12:19 PM, Alex Williamson wrote:
> It's possible to have buses without an associated bridge
> (bus->self == NULL).  SR-IOV can generate such buses.  When
> we find these, skip to the parent bus to look for the next
> ACS test.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>
> David Ahern reported an oops from iommu drivers passing NULL into
> this function for the same mistake.  Harden this function against
> assuming bus->self is valid as well.  David, please include this
> patch as well as the iommu patches in your testing.

Tested-by: David Ahern <dsahern@gmail.com>
