Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39984 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755634Ab2HWWgF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Aug 2012 18:36:05 -0400
Received: by lagy9 with SMTP id y9so781225lag.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 15:36:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6hO0p-qS14H4L=iMwjHCc_se0xv+6Hqt58zrxeJ1Av4Q@mail.gmail.com>
References: <1339799852.9220.206.camel@pasglop> <1341993548.3522.10.camel@dabdike.int.hansenpartnership.com>
 <1341994706.18850.33.camel@pasglop> <1341994994.3522.19.camel@dabdike.int.hansenpartnership.com>
 <1341995382.18850.37.camel@pasglop> <1341995569.3522.21.camel@dabdike.int.hansenpartnership.com>
 <CAErSpo7Qb1iVnxKuO58NxPk2Nyg3GdOafMZHKqaj_5s80GhF_w@mail.gmail.com> <CAErSpo6hO0p-qS14H4L=iMwjHCc_se0xv+6Hqt58zrxeJ1Av4Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Aug 2012 16:35:42 -0600
Message-ID: <CAErSpo7=8jKU=SChqhfTXka_iiAABhMH1pp-yX8VQv7dAe36Bg@mail.gmail.com>
Subject: Fwd: [Ksummit-2012-discuss] PCI breakout session
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, I should have sent this to linux-pci to begin with.  Please
speak up if you want to add topics or can help flesh out any existing
ones.

---------- Forwarded message ----------
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, Aug 23, 2012 at 4:10 PM
Subject: Re: [Ksummit-2012-discuss] PCI breakout session
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ksummit-2012-discuss@lists.linux-foundation.org


Ben, do you have any sort of agenda worked up?  I thought I saw some
topics earlier, but I can't find them now.  Here's my list:

  - Host bridge hotplug
  - Hotplug core rework
  - pseries unification, window alignment
      - pcibios_align_resource() vs pcibios_window_alignment()
  - VFIO for KVM (including powerpc)
  - Dynamic resource assignment
  - SR-IOV
      - Static vs. dynamic
      - Configured via driver or core
      - User-visible names
  - Candidates for unification
      - ECAM/MMCONFIG
      - Domain support
      - NUMA node support
      - struct pci_bus.ops
      - MPS config
      - Unassigned BAR detection
      - res->parent usage
      - Claiming BAR resources
      - Core host bridge scan routines
  - Current issues
      - MPS config for hot-add
      - pci_fixup_irqs() for hot-add
      - dev->bus->devices management for SR-IOV

It would be good to have some more details along with the topics to
help get discussions started.  I'll try to put some together, but for
a lot of these topics, I don't know enough even ask good questions.

My current notes are here
https://docs.google.com/presentation/d/1JctUZJQETqGUJIh757YOzLglOmWhS5KYqrQ4VrfUdbw/edit
if anybody wants to comment or add details (right now it's basically
just the info above).

Bjorn
