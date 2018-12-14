Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCB2C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DD820672
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DD820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeLNNLm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:11:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbeLNNLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 08:11:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A2D5129D868;
        Fri, 14 Dec 2018 21:11:37 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 21:11:27 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port PMU driver.
Date:   Fri, 14 Dec 2018 21:10:55 +0800
Message-ID: <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Hip08 SoCs contain relatively detailed performance units for the
PCIe Transport Layer at each port.

The support here is a subset of what will come, but is intended to
provide some initial basic functionality.

Note that there is a _lot_ more functionality in this hardware unit
so this is the first RFC of several.

RFC questions:

1. There is no standard for PCIe PMUs.  However, there are things that
   are elements of the PCIe protocol so any similar PMU is likely to
   support them.  Do we want to have a go at some consistent naming?
2. We are using an ACPI DSDT description to find what is basically a
   platform device that is associated with a PCIe device. Is this an
   acceptable thing to do?

Not yet fully established.

1. I haven't done enough testing with high performance devices to
   establish the 'minimum' frequency of the high resolution timer.
   It may be that we just end up dropping some of the counters
   because the load is too high to sample them often enough.
   Once the basic approach is established I'll run the numbers
   on this. These are up to Gen4x16 ports so things go pretty quick.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/Kconfig         |   9 +
 drivers/pci/pcie/Makefile        |   2 +
 drivers/pci/pcie/hisi_pcie_pmu.c | 528 +++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h       |   1 +
 4 files changed, 540 insertions(+)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 44742b2e1126..983783c42cf0 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -47,6 +47,15 @@ config PCIEAER_INJECT
 	  gotten from:
 	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
 
+config PCIE_HISI_PMU
+       tristate "PCI Express Root Port Performance Monitoring for Hisilicon Hip08"
+       depends on PCIEPORTBUS
+       help
+	 The hisilicon Hip08 platform has root ports with integrated
+	 transport layer performance measurement units. These are
+	 exposed within the memory map, so resources must be provided
+	 via ACPI DSDT.
+ 
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index ab514083d5d4..67435abef29d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
+
+obj-$(CONFIG_PCIE_HISI_PMU)     += hisi_pcie_pmu.o
diff --git a/drivers/pci/pcie/hisi_pcie_pmu.c b/drivers/pci/pcie/hisi_pcie_pmu.c
new file mode 100644
index 000000000000..ddd2885a2b17
--- /dev/null
+++ b/drivers/pci/pcie/hisi_pcie_pmu.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Provide performance monitoring for Hisilicon PCIe root ports
+ *
+ * Copyright (C) 2018 Hisilicon
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/cpuhotplug.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+
+#include "portdrv.h"
+
+#define HISI_PP_TL_CNT_CTRL_REG 0x96C
+#define   HISI_PP_TL_CNT_CTRL_TX_FLOW_CNT_EN BIT(0)
+#define   HISI_PP_TL_CNT_CTRL_TX_ERR_CNT_EN BIT(1)
+#define   HISI_PP_TL_CNT_CTRL_TX_NAT_CPL_CNT_EN BIT(2)
+#define   HISI_PP_TL_CNT_CTRL_TX_FLOW_FUN_EN BIT(3)
+#define   HISI_PP_TL_CNT_CTRL_TX_FLOW_CNT_TIME_MASK 0xFFF0
+
+#define HISI_MAX_PERIOD(nr) (BIT_ULL(nr) - 1)
+
+#define HISI_PP_TIMER_PERIOD_NS 10000000
+
+enum hisi_pci_counts {
+	TX_MEM_RD,
+	TX_MEM_WR,
+	TX_CFG_RD,
+	TX_CFG_WR,
+	TX_IO_RD,
+	TX_IO_WR,
+	TX_MSG,
+	TX_CPL,
+	TX_CCIX,
+	TX_ATOMIC,
+	TX_P2P,
+	TX_TLP,
+	TX_PAYLOAD,
+	TX_DW,
+
+	RX_TOTAL_TLP,
+	RX_TOTAL_TR,
+	RX_DROP,
+	RX_POSTED,
+	RX_NONPOSTED,
+	RX_CPL,
+	HISI_PP_EVENTS,
+};
+
+static struct hisi_pcie_cnt {
+	u64 reg_offset;
+	u8 bits;
+} hisi_pcie_cnt_info[HISI_PP_EVENTS] = {
+	[TX_MEM_RD]		= { 0x908, 16 },
+	[TX_MEM_WR]		= { 0x90c, 16 },
+	[TX_CFG_RD]		= { 0x910, 16 },
+	[TX_CFG_WR]		= { 0x914, 16 },
+	[TX_IO_RD]		= { 0x918, 16 },
+	[TX_IO_WR]		= { 0x91C, 16 },
+	[TX_MSG]		= { 0x924, 16 },
+	[TX_CPL]		= { 0x930, 16 },
+	[TX_CCIX]		= { 0x934, 16 },
+	[TX_ATOMIC]		= { 0x938, 16 },
+	[TX_P2P]		= { 0x93C, 16 },
+	[TX_TLP]		= { 0x940, 32 },
+	[TX_PAYLOAD]		= { 0x944, 32 },
+	[TX_DW]			= { 0x948, 32 },
+
+	[RX_TOTAL_TLP]		= { 0xb38, 16 },
+	[RX_TOTAL_TR]		= { 0xb3c, 16 },
+	[RX_DROP]		= { 0xb40, 16 },
+	[RX_POSTED]		= { 0xb44, 16 },
+	[RX_NONPOSTED]		= { 0xb48, 16 },
+	[RX_CPL]		= { 0xb4c, 16 },
+};
+
+struct hisi_event_list {
+	struct list_head list;
+	struct perf_event *event;
+};
+
+struct hisi_pcie_pmu {
+	struct pmu pmu;
+	void __iomem *regs;
+	cpumask_t associated_cpus;
+	int on_cpu;
+	struct hlist_node node;
+	DECLARE_BITMAP(pmu_events, HISI_PP_EVENTS);
+	struct hisi_event_list events[HISI_PP_EVENTS];
+	struct hrtimer timer;
+	struct list_head event_list;
+};
+
+#define to_hisi_pcie_pmu(p) container_of((p), struct hisi_pcie_pmu, pmu)
+
+int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pcie_pmu *dev_info = hlist_entry_safe(node,
+							 struct hisi_pcie_pmu,
+							 node);
+
+	cpumask_set_cpu(cpu, &dev_info->associated_cpus);
+	/* If another CPU is already managing this PMU, simply return. */
+	if (dev_info->on_cpu != -1)
+		return 0;
+
+	/* Use this CPU in cpumask for event counting */
+	dev_info->on_cpu = cpu;
+
+	return 0;
+}
+
+int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_pcie_pmu *dev_info = hlist_entry_safe(node,
+							 struct hisi_pcie_pmu,
+							 node);
+	cpumask_t pmu_online_cpus;
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &dev_info->associated_cpus))
+		return 0;
+
+	if (dev_info->on_cpu != cpu)
+		return 0;
+
+	/* Give up ownership of the PMU */
+	dev_info->on_cpu = -1;
+
+	/* Choose a new CPU to migrate ownership of the PMU to */
+	cpumask_and(&pmu_online_cpus, &dev_info->associated_cpus,
+		    cpu_online_mask);
+	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	/* Use this CPU for event counting */
+	dev_info->on_cpu = target;
+	perf_pmu_migrate_context(&dev_info->pmu, cpu, target);
+
+	return 0;
+}
+
+void hisi_pcie_pmu_event_update(struct perf_event *event)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+	u64 offset = hisi_pcie_cnt_info[hwc->config_base].reg_offset;
+	u8 period = hisi_pcie_cnt_info[hwc->config_base].bits;
+
+	do {
+		new_raw_count = readl(dev_info->regs + offset);
+		prev_raw_count = local64_read(&hwc->prev_count);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				 new_raw_count) != prev_raw_count);
+
+	delta = (new_raw_count - prev_raw_count) & HISI_MAX_PERIOD(period);
+	local64_add(delta, &event->count);
+}
+
+static enum hrtimer_restart event_read(struct hrtimer *timer)
+{
+	struct hisi_pcie_pmu *dev_info =
+		container_of(timer, struct hisi_pcie_pmu, timer);
+	struct hisi_event_list *hevent;
+
+	list_for_each_entry(hevent, &dev_info->event_list, list)
+		hisi_pcie_pmu_event_update(hevent->event);
+	hrtimer_forward_now(timer, HISI_PP_TIMER_PERIOD_NS);
+
+	return HRTIMER_RESTART;
+}
+
+int hisi_pcie_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	hwc->idx = -1;
+	hwc->config_base = event->attr.config;
+
+	dev_info->events[hwc->config_base].event = event;
+
+	return 0;
+}
+
+void hisi_pcie_pmu_enable(struct pmu *pmu)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(pmu);
+	u32 val;
+
+	if (bitmap_empty(dev_info->pmu_events, HISI_PP_EVENTS))
+		return;
+
+	val = readl(dev_info->regs + HISI_PP_TL_CNT_CTRL_REG);
+	/* Disable time period based flow counting */
+	val &= ~HISI_PP_TL_CNT_CTRL_TX_FLOW_CNT_TIME_MASK;
+	val |= HISI_PP_TL_CNT_CTRL_TX_FLOW_CNT_EN |
+		HISI_PP_TL_CNT_CTRL_TX_ERR_CNT_EN;
+	writel(val, dev_info->regs + HISI_PP_TL_CNT_CTRL_REG);
+}
+
+void hisi_pcie_pmu_disable(struct pmu *pmu)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(pmu);
+	u32 val;
+	u32 new_raw_count;
+
+	new_raw_count = readl(dev_info->regs + 0x908);
+
+	val = readl(dev_info->regs + HISI_PP_TL_CNT_CTRL_REG);
+	val &= ~(HISI_PP_TL_CNT_CTRL_TX_FLOW_CNT_EN |
+		 HISI_PP_TL_CNT_CTRL_TX_ERR_CNT_EN);
+	writel(val, dev_info->regs + HISI_PP_TL_CNT_CTRL_REG);
+}
+
+void hisi_pcie_pmu_enable_event(struct perf_event *event)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 offset = hisi_pcie_cnt_info[hwc->config_base].reg_offset;
+
+	/* Register is write to clear */
+	local64_set(&hwc->prev_count, 0);
+	writel(0, dev_info->regs + offset);
+}
+
+void hisi_pcie_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+
+	hisi_pcie_pmu_enable_event(event);
+	perf_event_update_userpage(event);
+}
+
+void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	/* Read hardware counter and update the perf counter statistics */
+	hisi_pcie_pmu_event_update(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+int hisi_pcie_pmu_add(struct perf_event *event, int flags)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	bool prev_empty;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	set_bit(hwc->config_base, dev_info->pmu_events);
+	if (flags & PERF_EF_START)
+		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
+	prev_empty = list_empty(&dev_info->event_list);
+	list_add(&dev_info->events[hwc->config_base].list,
+		 &dev_info->event_list);
+	if (prev_empty)
+		hrtimer_start(&dev_info->timer, HISI_PP_TIMER_PERIOD_NS,
+			      HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+
+void hisi_pcie_pmu_del(struct perf_event *event, int flags)
+{
+	struct hisi_pcie_pmu *dev_info = to_hisi_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	list_del(&dev_info->events[hwc->config_base].list);
+	if (list_empty(&dev_info->event_list))
+		hrtimer_cancel(&dev_info->timer);
+	hisi_pcie_pmu_stop(event, PERF_EF_UPDATE);
+	clear_bit(hwc->config_base, dev_info->pmu_events);
+	perf_event_update_userpage(event);
+}
+
+ssize_t hisi_event_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *page)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sprintf(page, "config=0x%lx\n", (unsigned long)eattr->var);
+}
+
+void hisi_pcie_pmu_read(struct perf_event *event)
+{
+	hisi_pcie_pmu_event_update(event);
+}
+
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct hisi_pcie_pmu *dev_info =
+		container_of(pmu, struct hisi_pcie_pmu, pmu);
+
+	return sprintf(buf, "%d\n", dev_info->on_cpu);
+}
+
+static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
+
+static struct attribute *hisi_pcie_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group hisi_pcie_pmu_cpumask_attr_group = {
+	.attrs = hisi_pcie_pmu_cpumask_attrs,
+};
+
+#define HISI_PP_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]) {				\
+		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+	})[0].attr.attr)
+
+#define HISI_PP_EVENT_ATTR(_name, _config)		\
+	HISI_PP_ATTR(_name, hisi_event_sysfs_show, (unsigned long)_config)
+
+static struct attribute *hisi_pcie_pmu_events_attr[] = {
+	HISI_PP_EVENT_ATTR(tx_mem_rd, TX_MEM_RD),
+	HISI_PP_EVENT_ATTR(tx_mem_wr, TX_MEM_WR),
+	HISI_PP_EVENT_ATTR(tx_cfg_rd, TX_CFG_RD),
+	HISI_PP_EVENT_ATTR(tx_cfg_wr, TX_CFG_WR),
+	HISI_PP_EVENT_ATTR(tx_io_rd, TX_IO_RD),
+	HISI_PP_EVENT_ATTR(tx_io_wr, TX_IO_WR),
+	HISI_PP_EVENT_ATTR(tx_msg, TX_MSG),
+
+	HISI_PP_EVENT_ATTR(tx_tlp, TX_TLP),
+	HISI_PP_EVENT_ATTR(tx_payload, TX_PAYLOAD),
+	HISI_PP_EVENT_ATTR(tx_dw, TX_DW),
+
+	HISI_PP_EVENT_ATTR(tx_cpl, TX_CPL),
+	HISI_PP_EVENT_ATTR(tx_ccix_tlp, TX_CCIX),
+	HISI_PP_EVENT_ATTR(tx_atomic_tlp, TX_ATOMIC),
+	HISI_PP_EVENT_ATTR(tx_p2p_tlp, TX_P2P),
+
+	HISI_PP_EVENT_ATTR(rx_tlp, RX_TOTAL_TLP),
+	HISI_PP_EVENT_ATTR(rx_tr_tlp, RX_TOTAL_TR),
+	HISI_PP_EVENT_ATTR(rx_posted_tlp, RX_POSTED),
+	HISI_PP_EVENT_ATTR(rx_nonposted_tlp, RX_NONPOSTED),
+	HISI_PP_EVENT_ATTR(rx_cpl_tlp, RX_CPL),
+	NULL,
+};
+
+static struct attribute_group hisi_pcie_pmu_events_group = {
+	.name = "events",
+	.attrs = hisi_pcie_pmu_events_attr,
+};
+
+static const struct attribute_group *hisi_pcie_pmu_attr_groups[] = {
+	&hisi_pcie_pmu_events_group,
+	&hisi_pcie_pmu_cpumask_attr_group,
+	NULL,
+};
+
+static int hisi_pcie_pmu_probe(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	struct acpi_device *acpi_dev;
+	struct resource_entry *entry;
+	resource_size_t regs_start, regs_size;
+	struct hisi_pcie_pmu *dev_info;
+	struct list_head list;
+	char *name;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+
+	if (pdev->vendor != PCI_VENDOR_ID_HUAWEI)
+		return -ENODEV;
+
+	acpi_dev = ACPI_COMPANION(&pdev->dev);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	ret = acpi_dev_get_resources(acpi_dev, &list, NULL, NULL);
+	if (ret < 0) {
+		pr_err("Failed to get PMU resources, ret=%d\n", ret);
+		return ret;
+	}
+	entry = list_first_entry(&list, struct resource_entry, node);
+	if (entry) {
+		regs_start = entry->res->start;
+		regs_size = resource_size(entry->res);
+		ret = 0;
+	} else
+		ret = -EINVAL;
+	acpi_dev_free_resource_list(&list);
+	if (ret)
+		return ret;
+
+	dev_info = devm_kzalloc(&pdev->dev, sizeof(*dev_info), GFP_KERNEL);
+	if (!dev_info)
+		return -ENOMEM;
+
+	hrtimer_init(&dev_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dev_info->timer.function = event_read;
+
+	INIT_LIST_HEAD(&dev_info->event_list);
+	dev_info->regs = devm_ioremap_nocache(&pdev->dev, regs_start,
+					      regs_size);
+	if (!dev_info->regs)
+		return -EINVAL;
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_pcie_port%04x_%02x",
+			      pdev->bus->number,
+			      PCI_SLOT(pdev->devfn));
+	if (!name)
+		return -ENOMEM;
+
+	dev_info->pmu = (struct pmu) {
+		.name = name,
+		.task_ctx_nr = perf_invalid_context,
+		.event_init = hisi_pcie_pmu_event_init,
+		.pmu_enable = hisi_pcie_pmu_enable,
+		.pmu_disable = hisi_pcie_pmu_disable,
+		.add = hisi_pcie_pmu_add,
+		.del = hisi_pcie_pmu_del,
+		.start = hisi_pcie_pmu_start,
+		.stop = hisi_pcie_pmu_stop,
+		.read = hisi_pcie_pmu_read,
+		.attr_groups = hisi_pcie_pmu_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_INTERRUPT,
+	};
+
+
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
+				       &dev_info->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug;\n", ret);
+		return ret;
+	}
+
+	ret = perf_pmu_register(&dev_info->pmu, name, -1);
+	if (ret) {
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
+					    &dev_info->node);
+
+		return ret;
+	}
+
+	dev_set_drvdata(&pdev->dev, dev_info);
+
+	return 0;
+}
+
+static void hisi_pcie_pmu_remove(struct pcie_device *dev)
+{
+	struct hisi_pcie_pmu *dev_info = dev_get_drvdata(&dev->port->dev);
+
+	perf_pmu_unregister(&dev_info->pmu);
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
+				    &dev_info->node);
+}
+
+static struct pcie_port_service_driver hisi_pcie_pmu = {
+	.name = "hisi_pcie_root_port_pmu",
+	.port_type = PCIE_ANY_PORT,
+	.service = PCIE_PORT_SERVICE_PMU,
+	.probe = hisi_pcie_pmu_probe,
+	.remove = hisi_pcie_pmu_remove,
+};
+
+static int __init hisi_pcie_service_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
+				      "AP_PERF_ARM_HISI_PCIE_ONLINE",
+				      hisi_pcie_pmu_online_cpu,
+				      hisi_pcie_pmu_offline_cpu);
+	if (ret) {
+		pr_err("PCIE PMU: setup hotplug, ret = %d\n", ret);
+		return ret;
+	}
+
+	pcie_port_service_register(&hisi_pcie_pmu);
+
+	return 0;
+}
+
+static void hisi_pcie_service_remove(void)
+{
+	pcie_port_service_unregister(&hisi_pcie_pmu);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
+}
+module_init(hisi_pcie_service_init);
+module_exit(hisi_pcie_service_remove);
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e0cd2baa8380..73f2bc8a7201 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -161,6 +161,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
 	CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
 	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
+	CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
-- 
2.19.1

