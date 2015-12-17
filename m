Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:37509 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308AbbLQK6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 05:58:04 -0500
From: "Seymour, Shane M" <shane.seymour@hpe.com>
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Hannes Reinecke" <hare@suse.com>
Subject: RE: [PATCH 1/2] pci: Update VPD definitions
Date: Thu, 17 Dec 2015 10:57:22 +0000
Message-ID: <DDB9C85B850785449757F9914A034FCB444F9255@G4W3219.americas.hpqcorp.net>
References: <1450339169-52542-1-git-send-email-hare@suse.de>
 <1450339169-52542-2-git-send-email-hare@suse.de>
In-Reply-To: <1450339169-52542-2-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> The 'end' tag is actually 0x0f, it's the representation as a
> small resource data type tag that's 0x78 (ie shifted by 3).
> This patch also adds helper functions to extract the resource
> data type tags for both large and small resource data types.
>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Tested-by: Shane Seymour <shane.seymour@hpe.com>

