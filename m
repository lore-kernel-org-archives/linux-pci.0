Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:47560 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbaIPIt4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Sep 2014 04:49:56 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 16 Sep 2014 14:19:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id A9B413940043
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 14:19:46 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s8G8oCBs59441398
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 14:20:13 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s8G8njfN016100
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 14:19:46 +0530
Date: Tue, 16 Sep 2014 16:49:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	David Henningsson <david.henningsson@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Richter <thor@math.tu-berlin.de>,
	gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
Message-ID: <20140916084942.GA15258@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20140913031818.GA25656@google.com>
 <1410732627-25445-1-git-send-email-andreas.noever@gmail.com>
 <20140915095305.GA7669@richard>
 <20140915190319.GA15350@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140915190319.GA15350@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 15, 2014 at 01:03:19PM -0600, Bjorn Helgaas wrote:
>On Mon, Sep 15, 2014 at 05:53:05PM +0800, Wei Yang wrote:
>> On Mon, Sep 15, 2014 at 12:10:27AM +0200, Andreas Noever wrote:
>> ...
>
>> >@@ -840,8 +863,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>> >
>> > 		if (max >= bus->busn_res.end) {
>> > 			dev_warn(&dev->dev, "can't allocate child bus %02x from %pR\n",
>> >-				 max, &bus->busn_res);
>> >-			goto out;
>> >+				 max + 1, &bus->busn_res);
>> >+			/* Try to resize bus */
>> >+			if (pci_grow_bus(bus, max + 1))
>> >+				goto out;
>> 
>> On some platforms, like powerpc, we have some limitations of the bus number a
>> bridge could have. Sometimes, we need the start bus number to be power 2
>> aligned.
>
>Huh.  I have to admit that I'm getting tired of all the powerpc-specific
>PCI hacks.  It's hard enough to get this stuff working on hardware that
>conforms to the spec, and scattering pcibios_*() hooks around makes the
>code even harder to follow.
>

Yep, those powerpc-specific things are not friendly :-(

I feel very sad it brings a lot difficulties to maintain it in linux mainline.
Sorry to bring so many trouble to you.

>What would happen if powerpc used PCI_PROBE_ONLY?  Do you really depend on
>the PCI core to configure anything for you, or does your firmware set
>everything up the way it needs to be?
>

Hmm... I had a try with PCI_PROBE_ONLY set, sounds can't bring up the machine.
Currently, we rely on the kernel to assign devices' resources. When
PCI_PROBE_ONLY is set, device resources will not be setup properly.

>Changing bridge configuration seems like something we should avoid under
>PCI_PROBE_ONLY (I haven't read Andreas' patch in detail, so I don't know if
>that's how it works).  If PCI_PROBE_ONLY would work for powerpc, then we
>wouldn't have an issue here.
>
>Bjorn

-- 
Richard Yang
Help you, Help me

