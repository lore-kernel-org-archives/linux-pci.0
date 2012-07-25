Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56079 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2GYDdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2012 23:33:54 -0400
Received: by lbbgm6 with SMTP id gm6so319889lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 20:33:52 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Jul 2012 21:33:32 -0600
Message-ID: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
Subject: PCI mini-summit
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We're planning a PCI mini-summit on Tuesday, August 28, in San Diego.
If you'd like an invitation, let me know.

We haven't drafted an agenda yet, but based on ideas we've heard so
far, we'll likely talk about some of the following topics:

      Host bridge hotplug
      PCI hotplug core rework
      VFIO v2 for KVM
      Dynamic resource assignment
      SRIOV
          Management: driver (module parms) vs core (sysfs?)
          Dynamic/static: changing number of VFs requires driver cooperation
      Candidates for unification/moving from arch code to the core:
          res->parent usage
          Claiming resources
          Unassigned BAR detection
          ECAM (a.k.a. MMCONFIG)
          Domain (a.k.a. PCI segment) support
          MPS config
          MPS safety with respect to hotplug

I've also heard that PCI-on-ARM may be of interest, so if you want to
talk about that and possibly add some topics, let me know.

Bjorn
