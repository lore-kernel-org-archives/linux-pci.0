Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbbLQH7d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 02:59:33 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/2] PCI: Safe VPD access
Date: Thu, 17 Dec 2015 08:59:27 +0100
Message-Id: <1450339169-52542-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI VPD suffers from two problems: it has a very rudimentary interface
and it relies on correctly formatted data. And essentially it provides
a direct channel into the card hardware. In other words, plenty of
chances to mess things up.
With the original implementation we would just read the VPD space,
blissfully ignorant of the data formatting of the VPD data. This
would work if the VPD space happens to be properly implemented.
However, I've had several reports where a simple 'cat' on the vpd
attribute would return garbage (if you're lucky), trigger a timeout
with a kernel warning (which actually triggered this patchset), or
hang your machine (if you're really unlucky).
So this patchset validates the VPD data, setting the VPD attribute to
the correct size or disabling VPD access altogether if no valid data
is found.

Hannes Reinecke (2):
  pci: Update VPD definitions
  pci: Update VPD size with correct length

 drivers/pci/access.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  | 27 +++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 2 deletions(-)

-- 
1.8.5.6

