Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:1384 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbcAOBIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 20:08:09 -0500
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <helgaas@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Babu Moger <babu.moger@oracle.com>
Subject: RE: [PATCHv2 0/4] PCI VPD access fixes
Date: Fri, 15 Jan 2016 01:07:14 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB4450CEC7@G9W0766.americas.hpqcorp.net>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
In-Reply-To: <1452684335-46107-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For the series. Tested with AE311 PCI-Express 4Gb Fibre Channel HBA.
Truncation of the vpd data returned works (154 bytes) and lspci -vvv
prints out the VPD tags the same way with and without the changes.
This card did not require any quirks it was capable of returning 32k
of data (although it repeated every 4k).
---
Tested-by: Shane Seymour <shane.seymour@hpe.com>
