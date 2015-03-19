Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:34899 "EHLO smtp-o-3.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbbCSM01 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Mar 2015 08:26:27 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 15A602802AB
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 13:19:43 +0100 (CET)
Received: from ZITSWEEP1.win.desy.de (zitsweep1.win.desy.de [131.169.97.95])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id E44121318
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 13:19:42 +0100 (MET)
Received: from smtp-intra-3.desy.de (lb-40-26.desy.de) by ZITSWEEP1.win.desy.de
 (Clearswift SMTPRS 5.5.0) with ESMTP id <Tb93e9948b783a9615f1310@ZITSWEEP1.win.desy.de> for <linux-pci@vger.kernel.org>;
 Thu, 19 Mar 2015 13:19:42 +0100
Received: from [131.169.146.36] (mcspetros.desy.de [131.169.146.36])
	by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id 46BE813D1
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 13:19:42 +0100 (MET)
Message-ID: <550ABEDE.6030907@desy.de>
Date: Thu, 19 Mar 2015 13:19:42 +0100
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: ACPI PCIe Hot Plug or pciehp
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

we are using PCIe hotplug for a few years in MTCA crates. We are using
pciehp driver to handle hotplug events
and it is fine. To force load the pciehp we used to use boot parameters
pciehp.pciehp_force=1 and pci-ports=native.
But today's more people talking about using ACPI hotplug instead of pciehp.
I have tried to get some information, but could not find good description.
Could some one help me to understand which is "better" and which one has
to be used, ACPI hotplug or pciehp

Thanks for help

with best regards

Ludwig

