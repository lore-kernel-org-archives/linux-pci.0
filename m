Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, mihailm@parallels.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ACPI: container hot remove support.
Date: Wed, 24 Oct 2012 14:05:48 +0800
Message-Id: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The container hotplug handler container_notify_cb() didn't implement
the hot-remove functionality. So, these 2 patches implement it like
the following way:

patch 1. Do not use kacpid_wq/kacpid_notify_wq to handle container hotplug event,
         use kacpi_hotplug_wq instead to avoid deadlock.
         Doing this is to reuse acpi_bus_hot_remove_device() in container
         hot-remove handling.

patch 2. Introduce a new function container_device_remove() to handle
         ACPI_NOTIFY_EJECT_REQUEST event for container.


change log v1 -> v2:

1. In patch1: Based on the lastest for-pci-split-pci-root-hp-2 branch from Lu Yinghai, 
   use alloc_acpi_hp_work() to add container hotplug work into kacpi_hotplug_wq.

2. In patch2: Allocate ej_event after container is stopped, so that we don't need to
   kfree the ej_event if stopping container failed.


This is based on Lu Yinghai's job.
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-split-pci-root-hp-2

Tang Chen (2):
  Use kacpi_hotplug_wq to handle container hotplug event.
  Improve container_notify_cb() to support container hot-remove.

 drivers/acpi/container.c |   75 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 65 insertions(+), 10 deletions(-)

