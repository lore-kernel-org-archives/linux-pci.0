Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Feb 2012 16:54:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jbarnes@virtuousgeek.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: export constants from shpc.h?
Message-ID: <20120216145447.GA25979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've implemented an shpc controller emulator
in qemu, so I needed a bunch of constants
similar to what drivers/pci/hotplug/shpc.h has.

Any objections to adding a PCI_SHPC_XXXX prefix
so these and moving them to pci_regs.h?
PCI utilities can then use them from /usr/include/linux.

One can see how a utility that looks at slot LED and MRL
states might be useful
(we'd need to export the base offset through sysfs
to make it possible to use such in parallel with shpc).

-- 
MST

