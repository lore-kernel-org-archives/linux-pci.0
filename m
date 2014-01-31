Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36448 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaAaBiT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 20:38:19 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so4549094oag.20
        for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 17:38:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7120202.A2h3LvJsyn@vostro.rjw.lan>
References: <20140130131236.GW18029@intel.com>
	<3365345.z6P9Wo4Pau@vostro.rjw.lan>
	<CAE9FiQUmuaarJEhOQogusyv3EpBPDjRTtRvbh4U4QCJqfs0Vvw@mail.gmail.com>
	<7120202.A2h3LvJsyn@vostro.rjw.lan>
Date: Thu, 30 Jan 2014 17:38:18 -0800
Message-ID: <CAE9FiQUoTzt39O8po1WMPesHMyof0wgCNgPMZUKTPhnxQ2Rk4Q@mail.gmail.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 30, 2014 at 4:39 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, January 30, 2014 03:39:02 PM Yinghai Lu wrote:
>
> So I gather all of bus->devices list walks during which devices may be removed
> should be done in the reverse order, right?

Yes.

Yinghai
