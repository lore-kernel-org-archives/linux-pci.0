Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jon Mason <jon.mason@intel.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Nicholas Bellinger <nab@risingtidesystems.com>
Subject: [RFC v4 0/2] PCI-Express Non-Transparent Bridge Support 
Date: Thu, 27 Sep 2012 15:42:52 -0700
Message-Id: <1348785774-12607-1-git-send-email-jon.mason@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Version 4 of the patch that adds support for PCI-Express Non-Transparent
Bridges in Linux.  This version removes the transport transmit tasklet
(per Dave Miller's request).

Thanks,
Jon

