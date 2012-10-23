Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI: container hot remove support.
Date: Tue, 23 Oct 2012 21:10:37 +0800
Message-Id: <1350997839-13260-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
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


In __acpi_os_execute(), we have the following comments:

        We can't run hotplug code in keventd_wq/kacpid_wq/kacpid_notify_wq
        because the hotplug code may call driver .remove() functions,
        which invoke flush_scheduled_work/acpi_os_wait_events_complete
        to flush these workqueues.

Actually, I run into the deadlock caused by running hotplug code in
kacpid_wq/kacpid_notify_wq. And I'm not quite sure if I did the right
thing in patch1. So, please give some comments if you have a better idea.


This is based on Lu Yinghai's job.
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-split-pci-root-hp-2

Tang Chen (2):
  Use kacpi_hotplug_wq to handle container hotplug event.
  Container hot remove support.

 drivers/acpi/container.c |  102 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 92 insertions(+), 10 deletions(-)

