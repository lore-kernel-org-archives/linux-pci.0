Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32990 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbIBT0L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 15:26:11 -0400
Received: by wicmc4 with SMTP id mc4so76569284wic.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 12:26:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150902174612.GA2700@sean.stalley.intel.com>
References: <1440089947-2839-1-git-send-email-sean.stalley@intel.com>
 <1440089947-2839-3-git-send-email-sean.stalley@intel.com> <CAE9FiQUQacSJXPqv9GQJ4AF0TN7uxcBiAYHVbHwvFhEfWgWKHg@mail.gmail.com>
 <20150902174612.GA2700@sean.stalley.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 2 Sep 2015 14:25:50 -0500
Message-ID: <CAErSpo4qZ9AXskyo86gXG1cb3AqCn-HB05nj7qT9wovZdLt2Tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Add support for Enhanced Allocation devices
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 2, 2015 at 12:46 PM, Sean O. Stalley <sean.stalley@intel.com> wrote:

> Would it be better to modify pci_claim_resource() to support EA instead of adding pci_ea_claim_resource()?
> That way, EA entries would be claimed at the same time as traditional BARs.

Yes, I think so.

Why wouldn't pci_claim_resource() work as-is for EA?  I see that
pci_ea_get_parent_resource() defaults to iomem_resource or
ioport_resource if we don't find a parent, but I don't understand why
that's necessary.
