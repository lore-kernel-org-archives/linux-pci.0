Return-Path: <vkuznets@redhat.com>
Return-Path: <vkuznets@redhat.com>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, Bjorn Helgaas <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>
Subject: Re: [PATCH 0/2] PCI: hv: fix a couple of issues in hv_pci_onchannelcallback()
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
	<20160610235336.GA16462@localhost> <20160617174451.GA1977@localhost>
Date: Sun, 19 Jun 2016 10:37:33 +0200
In-Reply-To: <20160617174451.GA1977@localhost> (Bjorn Helgaas's message of
	"Fri, 17 Jun 2016 12:44:51 -0500")
Message-ID: <87fus9k20i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Jun 10, 2016 at 06:53:36PM -0500, Bjorn Helgaas wrote:
>> On Mon, May 30, 2016 at 04:17:57PM +0200, Vitaly Kuznetsov wrote:
>> > kmemleak helped me to identify a memory leak in hv_pci_onchannelcallback()
>> > and while fixing it I stumbled upon an unrelated issue(s) there.
>> > 
>> > Vitaly Kuznetsov (2):
>> >   PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
>> >   PCI: hv: handle all pending messages in hv_pci_onchannelcallback()
>> 
>> I applied both to for-linus for v4.7 with Jake's acks, thanks, Vitaly.
>
> Somehow I must have been thinking these were fixes for things we
> merged or broke during the v4.7 merge window, but that doesn't look
> like the case.  So I'm going to merge these for v4.8 instead, on the
> theory that the v4.7-rc cycles are primarily for stabilization.

Right, this is not a 4.7 regression.

Thanks!

-- 
  Vitaly
