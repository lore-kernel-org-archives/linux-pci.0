Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:6626 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805AbaGaP50 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 11:57:26 -0400
Message-ID: <53DA674A.9030305@solarflare.com>
Date: Thu, 31 Jul 2014 16:56:58 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: <linux-pci@vger.kernel.org>, Don Dutile <ddutile@redhat.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com>
In-Reply-To: <53DA5EF4.1030500@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/07/14 16:21, Alexander Duyck wrote:
> However if you are wanting to use this as a way to disable SR-IOV for a
> device I wouldn't recommend it.  Based on what you have described I
> would suggest dropping the fix in drivers/pci/quirks that would clear
> dev->is_physfn if you are in the PF-IOV mode.  That way the SR-IOV
> functionality should be fully disabled.
I still don't see how this can go in drivers/pci/quirks, because PF-IOV
mode can only be detected at driver probe time.  The way we find out
that the NIC is in PF-IOV mode is that a request to the MC (the
Management CPU on the card) to create a vswitch fails.  But maybe I'm
wrong about what quirks can do - is there any relevant documentation?

Clearing dev->is_physfn in the driver probe routine isn't safe:
dev->sriov memory can get leaked, for example, as sriov_init will get
called at device add, but sriov_release won't be called at removal.

I'm also unconvinced that having !(dev->is_physfn || dev->is_virtfn) is
a valid state; but maybe I'm misunderstanding and "is_physfn" doesn't
actually mean "is a physical function", but rather "has SR-IOV capability".
> In addition this solution would
> also resolve the fact that the driver wouldn't actually have to be
> loaded for it to work so if someone were to load a driver that didn't
> contain the fix they would be blocked from enabling SR-IOV as well.
The current driver fails to probe the PF because it assumes the vswitch
creation failure is fatal.  There should never be a driver that knows it
can live without the vswitch but doesn't know that that breaks SR-IOV.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
