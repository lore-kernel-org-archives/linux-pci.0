Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:20020 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbaHDPWm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 11:22:42 -0400
Message-ID: <53DFA53A.4080401@solarflare.com>
Date: Mon, 4 Aug 2014 16:22:34 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: Don Dutile <ddutile@redhat.com>, <linux-pci@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com> <53DA82AF.7000503@redhat.com> <53DA8745.2070405@solarflare.com> <53DF92B4.1040505@solarflare.com> <53DF9A9F.9060600@intel.com>
In-Reply-To: <53DF9A9F.9060600@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I must be really bad at explaining things, I keep confusing everyone...

On 04/08/14 15:37, Alexander Duyck wrote:
> How is it you get yourself into the PF-IOV mode?  Is this something that
> is stored in the NVM of the adapter, or is it something where the driver
> has to issue a request for it?  Also does each PF advertise SR-IOV
> support in PF-IOV mode or only function 0?
It's stored in the card's NVM, yes.
Each PF will advertise SR-IOV support (if it has VFs configured -
another NVM setting).
> Modifying the total VFs and/or the initial VFs in the configuration
> space is not practical.  You would likely run into issues as one of
> these fields is read at probe time and the other is read at SR-IOV
> enablement and if the two differ you cannot enable SR-IOV.
I wasn't suggesting modifying configuration space at probe time.  The
suggestion was for the firmware to do it at power-on.  But it was
decided impractical, hence why I want to use pci_sriov_set_totalvfs instead.
> I'm not sure what davem has to do with any of this.  We are discussing
> PCI at this point, not the network drivers.  As such Dave won't be the
> one accepting the pci_sriov_set_totalvfs changes you proposed.
I just meant that if and when this PCI patch gets accepted, it'll be
followed by a driver patch (against davem's tree) to use this function,
and at that point there's likely to be another discussion of whether
it's the right thing for the driver to do.
> rather than trying to change the SR-IOV API to match
> your use case.
Here's the thing: I don't feel like I'm changing the API, I feel like
I'm fixing a bug.  Now what is a bug and what is an undocumented, unused
feature is of course subjective.  But I haven't seen any arguments so
far why pci_sriov_set_totalvfs(dev, 0) _should_ have the old behaviour,
while it's easy to argue that the old behaviour is an inconsistent
interface with an undocumented and surprising pitfall.
So can someone please explain to me why this isn't a bug?

-Edward
