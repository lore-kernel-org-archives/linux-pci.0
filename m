Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:43185 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbbLQLH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 06:07:56 -0500
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH 2/2] pci: Update VPD size with correct length
Date: Thu, 17 Dec 2015 11:06:53 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB444F927F@G4W3219.americas.hpqcorp.net>
References: <1450339169-52542-1-git-send-email-hare@suse.de>
 <1450339169-52542-3-git-send-email-hare@suse.de>
In-Reply-To: <1450339169-52542-3-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tested with a HP AE311-60001 PCIe card. It used to repeat the same VPD every 4k
for 32k now only the 154 bytes are returned and lspci -vvvv reports that the data up
to and including the end and that the check sum is good:

...
        Capabilities: [74] Vital Product Data
                Product Name: PCI-Express 4Gb Fibre Channel HBA
                Read-only fields:
                        [PN] Part number: AE311-60001
                        [EC] Engineering changes: C-4830
                        [SN] Serial number: CN80847W3U
                        [V0] Vendor specific: PW=15W
                        [V2] Vendor specific: 4847
                        [MN] Manufacture ID: 50 58 32 35 31 30 34 30 31 2d 37 30 20 20 42
                        [V1] Vendor specific: 02.22
                        [V3] Vendor specific: 05.03.15
                        [V4] Vendor specific: 03.13
                        [V5] Vendor specific: 02.03
                        [YA] Asset tag: NA
                        [RV] Reserved: checksum good, 0 byte(s) reserved
                End
...
---
Tested-by: Shane Seymour <shane.seymour@hpe.com>
