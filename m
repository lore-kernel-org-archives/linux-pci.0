Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:20920 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934341AbbLQF0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 00:26:12 -0500
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: Hannes Reinecke <hare@suse.de>,
	Alexander Duyck <alexander.duyck@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.com>
Subject: RE: [PATCHv2] pci: Update VPD size with correct length
Date: Thu, 17 Dec 2015 05:25:27 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB444F8FCC@G4W3219.americas.hpqcorp.net>
References: <1450262992-77276-1-git-send-email-hare@suse.de>
 <4468155.Bdxh8senif@lennox.hannes-reinecke.de>
 <CAKgT0UcT_FxpjFUFF-HELHU7v_g_AcnPTg4tHWt3FsWO4G3fZg@mail.gmail.com>
 <1571929.py3SMrb2RG@lennox.hannes-reinecke.de>
In-Reply-To: <1571929.py3SMrb2RG@lennox.hannes-reinecke.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> The only 'error' cases I've encountered so far is a read of all zeroes (and a
> halting the machine once you've read beyond a certain point) or a read of
> 0xff throughout the entire area. So that approach would work for both of them.

I should add that I'd tested the previous patch and this patch. I'll retest once v3 is available.

I have a card that repeats the vpd data every 4k for all 32k. The patch as it stands truncates that to just the valid data and lspci -vvvv shows the vpd data correctly.
