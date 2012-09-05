Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26986 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723Ab2IEUKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Sep 2012 16:10:44 -0400
Message-ID: <5047B1C1.1090403@redhat.com>
Date: Wed, 05 Sep 2012 16:10:41 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: mathew.binkley@vanderbilt.edu
Subject: Re: Determining if PCI device is in slot or on motherboard?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>Is there a simple way using the "lspci" command to tell if a PCI device
>is in a slot, or is on the motherboard?   Thanks.

dmidecode will.  Run "dmidecode | less" and search for "Onboard Devices".  Each
onboard device will have its own entry.

... and not all systems populate SMBIOS with this info so YMMV ;)

P.
