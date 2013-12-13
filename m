Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36483 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3LMQyi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2013 11:54:38 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so3174949ieb.36
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2013 08:54:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52AB1B20.3030105@desy.de>
References: <52AB1B20.3030105@desy.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Dec 2013 09:54:17 -0700
Message-ID: <CAErSpo7kyQ3g6KQhRfEO6jJu_fzsrW09VtRVGrA6x0n+e=MY_g@mail.gmail.com>
Subject: Re: pciehp
To: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 13, 2013 at 7:35 AM, Ludwig Petrosyan
<ludwig.petrosyan@desy.de> wrote:
> Hi All
>
> we are working at DESY (Deutsches Elektronen-Synchrotron, Hamburg Germany)
> and involved in evaluation of MTCA.4 standard (MTCA for Physics)
> I have question concerning PCIe hotplag:
> The Hot-Swap is working, I mean, if there was a PCIe endpoint card in
> the PCIe slot this module could be later removed and inserted back in
> running system. But if the Slot was empty and one insert the new PCIe
> endpoint card in slot, the card will be connected in PCIe bus (I could
> see it in lspci) but memory not enabled. Only after rebooting of the OS
> the memory will be enabled.
> For MTCA.4 standard it is very important to have possibility to add new
> PCIe endpoint card in running system.
> So, my question is:
>  is there some OS boot parameter I could reserve memory for all PCIe
> ports which hase slot implemented (if slot implemented on the PCIe
> switch or RootComplex port this means later could be some PCIe endpoint
> card inserted)

If a Root Port or switch Downstream Port has the PCI_EXP_SLTCAP_HPC
(Slot Capabilities Hot-Plug Capable) bit is set, Linux should reserve
2MB for the port's MMIO aperture.  That isn't very much, but you can
change that amount with the "pci=hpmemsize=" boot option.  And I think
if you have firmware that configures a larger aperture, Linux will
keep that.

A complete dmesg log and "lspci -vv" output would be the place to
start investigating if Linux isn't doing this correctly.

Bjorn
