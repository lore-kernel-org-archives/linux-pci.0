Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Subject: [PATCH] xen-pciback features for v3.4 (FLR). v2
Date: Thu, 12 Jan 2012 12:06:45 -0500
Message-Id: <1326388007-19178-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please pull these patches in your v3.4 branch. A bunch of folks using
Xen chatted a bit about this and it is a worthwile to have this functionality
in the kernel.

Thanks!

The two patches are:
 [PATCH 1/2] pci: Introduce __pci_reset_function_locked to be used
 [PATCH 2/2] xen/pciback: Support pci_reset_function, aka FLR or D3

 drivers/pci/pci.c                  |   25 ++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c |   41 +++++++++++++++++++++++++++++++++--
 drivers/xen/xen-pciback/pciback.h  |    1 +
 include/linux/pci.h                |    1 +
 4 files changed, 65 insertions(+), 3 deletions(-)
