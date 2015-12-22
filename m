Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:42686 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbbLVPgJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 10:36:09 -0500
Date: Tue, 22 Dec 2015 16:36:08 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode DevCap SlotPowerLimit for all components
 with Upstream Ports
Message-ID: <mj+md-20151222.153554.16681.nikam@ucw.cz>
References: <20151210195001.8111.55134.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151210195001.8111.55134.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The SlotPowerLimit in the Slot Capability indicates how much power the slot
> can supply to a downstream device.  A Root Port or Switch Downstream Port
> communicates the limit via a Set_Slot_Power_Limit Message on the link.  The
> component on the other end of the link copies the limit from the message to
> the Captured Slot Power Limit in its Device Capability [see PCIe r3.0, sec
> 2.2.8.5].
> 
> The Captured SlotPowerLimit is relevant for all devices on the downstream
> end of a Link.  This includes Endpoints and Bridges as well as
> Switch Upstream Ports.
> 
> Decode the DevCap Captured SlotPowerLimit for Endpoints and Bridges as well
> as Switch Upstream Ports.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
To understand a program you must become both the machine and the program.
