Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:41954 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752917AbaHDRI7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 13:08:59 -0400
Message-ID: <53DFBE21.1010802@solarflare.com>
Date: Mon, 4 Aug 2014 18:08:49 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: Ethan Zhao <ethan.kernel@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vasundhara Volam <vasundhara.volam@emulex.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com> <53DB84E6.1070206@solarflare.com> <107835EF-8941-4621-952F-E1583F7E3636@gmail.com> <53DFAA8C.2010602@solarflare.com> <53DFB78D.4080309@intel.com>
In-Reply-To: <53DFB78D.4080309@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/14 17:40, Alexander Duyck wrote:
> Edward,
>
> The concern isn't what is out there, but what will come of it as a
> result.  The question is should we allow setting the value to 0 to
> change the behavior from disabling the override to essentially disabling
> SR-IOV.
I still don't see why any driver would set an override and then want to
disable it; moreover, it seems like unnatural semantics to use 0 for
this (something like -1 would seem much more sensible) since most people
will expect 0 to mean, well, 0.

> If we consider it acceptable to use 0 as a disable value, and there are
> several people on this thread that don't, the secondary issue of this is
> the error return for sriov_numvfs_store which hasn't been addressed.
> Should we still be returning ERANGE if SR-IOV has essentially been
> disabled, or should we be returning some other error such as EBUSY,
> ENOMEM, ENODEV, or ENOSYS to indicate that there are no resources
> available for SR-IOV.
In my opinion we should still return ERANGE, as that's the immediate
error - user requested more VFs than were advertised.  I.e. it's exactly
the same as if someone requested 8 VFs on igb after igb reduced totalvfs
to 7; we don't return a different error code to say _why_ igb can only
support 7 VFs.  I don't see why 0 is special in this regard.

> I think you would be much better off just implementing sriov_configure
> for your PCI driver and placing your own error return there if you
> cannot allocate a vswitch.
It just seems silly to advertise VFs when we already know at PF probe
time that we've failed to allocate the vswitch.

-Edward
