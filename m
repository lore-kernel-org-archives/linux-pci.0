Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34913 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab2FVVor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 17:44:47 -0400
Received: by lbbgm6 with SMTP id gm6so4171256lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 14:44:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Jun 2012 15:44:25 -0600
Message-ID: <CAErSpo4tRTzhmcpPR+VD9=-8t8kTo1iZmz7bKmGO=b4VPPGqxA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Coverity and trivial fixes
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2012 at 6:16 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These fix a few issues reported by the Coverity checker and a trivial
> style issue (__weak).
>
> Only two should have interesting effects:
>
>  - The OBFF/LTR enable functions should panic without this fix, so
>    I don't think they've ever been tested.
>
>  - The P2P bridge I/O window fix doesn't affect x86, which never uses
>    32-bit I/O decoding.  But other architectures might notice because
>    we incorrectly sign-extended I/O port addresses of 0x80000000 and
>    above.
>
> I'll wait for comments before putting them in "next" (targeted for 3.6).
> ---
>
> Bjorn Helgaas (6):
>      PCI: use __weak consistently
>      PCI: fix upstream P2P bridge checks when enabling OBFF and LTR
>      PCI: fix P2P bridge I/O port window sign extension
>      PCI: shpchp: remove dead code
>      PCI: acpiphp: check whether _ADR evaluation succeeded
>      PCI: remove useless pcix_set_mmrbc() dev->bus check
>
>
>  drivers/pci/hotplug/acpiphp_glue.c |   13 +++++++++----
>  drivers/pci/hotplug/shpchp_ctrl.c  |    3 ---
>  drivers/pci/pci-sysfs.c            |    2 +-
>  drivers/pci/pci.c                  |   15 +++++++--------
>  drivers/pci/probe.c                |   18 ++++++++++--------
>  5 files changed, 27 insertions(+), 24 deletions(-)

I applied these to my "next" branch.  Let me know if you see any issues.
