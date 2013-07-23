Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:61062 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933409Ab3GWQKh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 12:10:37 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so10682018obc.30
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 09:10:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51EEA26E.50700@redhat.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-3-git-send-email-yinghai@kernel.org>
	<51E9B3C7.1010409@intel.com>
	<CAE9FiQXUgSVO8h=+JTY-giQ_jz9DryOXDsFJJeMT-y1J9Sv+fA@mail.gmail.com>
	<51E9CA2F.5050307@intel.com>
	<51EEA26E.50700@redhat.com>
Date: Tue, 23 Jul 2013 09:10:37 -0700
Message-ID: <CAE9FiQUfNWS-wgSbxH1qLnFKQMT0YdkzXt1ivCbrtscWaFvzwQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Stop sriov before remove PF
From: Yinghai Lu <yinghai@kernel.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 23, 2013 at 8:34 AM, Don Dutile <ddutile@redhat.com> wrote:
>>
>> I suspect that is much easier said than done.  We probably need somebody
>> familiar with the KVM side of things to address the feasibility of
>> something like that.  I believe it was Greg and Don that worked on the
>> original patches that made it so that we could leave the VFs in place on
>> driver removal.  They would likely have a better answer as to why it is
>> preferable to leave the VFs in place than panic a non-compliant guest.
>
>
> The virtual effect of leaving the VFs in place was the equivalent of
> unplugging
> the cable from the VF device in the guest. When the PF driver was reloaded,
> it
> caused the virtual effect of the network cable being reconnected.  Before
> that
> patch set (in ixgbe & igb), a PF driver unload in the host would result in
> the VF
> assigned to KVM a guest caused a *host crash*.
> So, start up a KVM (linux) guest, hot-remove the PF with a VF
> assigned to a guest, and with these patches applied, ensure the host doesn't
> crash.
> if it does crash, that's a regression that can't be tolerated, and this
> patch (set)
> will need further work.

at beginning, we have pcie native hotlpug working even with sriov enabled.

later patchset (in ixgbe & igb) will not call disable_sriov, that cause

hotplug does not work anymore, so that is first regression at all.

Anyway, guest host crash is not regression when PF get removed, that
is old behavior when guest/sriov pci passthrough support is added.

So need to pci_stub to notify guest to do hotremove, when PF's driver
get detached?

Thanks

Yinghai
