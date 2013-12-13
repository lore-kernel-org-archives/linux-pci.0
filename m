Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:43658 "EHLO smtp-o-1.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab3LMOky (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Dec 2013 09:40:54 -0500
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
	by smtp-o-1.desy.de (DESY-O-1) with ESMTP id E86522805A5
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2013 15:35:13 +0100 (CET)
Received: from ZITSWEEP1.win.desy.de (zitsweep1.win.desy.de [131.169.97.95])
	by smtp-map-1.desy.de (DESY_MAP_1) with ESMTP id D177313EC2
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2013 15:35:12 +0100 (MET)
Received: from smtp-intra-3.desy.de (lb-40-26.desy.de) by ZITSWEEP1.win.desy.de
 (Clearswift SMTPRS 5.5.0) with ESMTP id <Taff901a99583a9615f15d0@ZITSWEEP1.win.desy.de> for <linux-pci@vger.kernel.org>;
 Fri, 13 Dec 2013 15:35:12 +0100
Received: from [131.169.146.36] (mcspetros.desy.de [131.169.146.36])
	by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id 348152D6E
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2013 15:35:12 +0100 (MET)
Message-ID: <52AB1B20.3030105@desy.de>
Date: Fri, 13 Dec 2013 15:35:12 +0100
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: pciehp
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All

we are working at DESY (Deutsches Elektronen-Synchrotron, Hamburg Germany)
and involved in evaluation of MTCA.4 standard (MTCA for Physics)
I have question concerning PCIe hotplag:
The Hot-Swap is working, I mean, if there was a PCIe endpoint card in
the PCIe slot this module could be later removed and inserted back in
running system. But if the Slot was empty and one insert the new PCIe
endpoint card in slot, the card will be connected in PCIe bus (I could
see it in lspci) but memory not enabled. Only after rebooting of the OS
the memory will be enabled.
For MTCA.4 standard it is very important to have possibility to add new
PCIe endpoint card in running system.
So, my question is:
 is there some OS boot parameter I could reserve memory for all PCIe
ports which hase slot implemented (if slot implemented on the PCIe
switch or RootComplex port this means later could be some PCIe endpoint
card inserted)

with best regards

Ludwig Petrosyan
