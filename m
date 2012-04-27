Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:30276
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760223Ab2D0OeU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 10:34:20 -0400
Date: Fri, 27 Apr 2012 16:34:10 +0200
From: Andreas Herrmann <andreas.herrmann3@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/2][RESEND] x86/pci/amd: Restore early_fill_mp_bus_to_node 
Message-ID: <20120427143410.GB27535@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am resending this two patches as the old submission faced starvation

http://marc.info/?l=linux-pci&m=133338730115350&w=2

(Guess this was due to the switch in PCI maintenance.)

The main purpose of the two patches is to correctly set the numa_node
attribute of PCI devices on systems with AMD Interlagos CPUs.

Please apply.


Thanks,

Andreas


