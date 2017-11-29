Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41734 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934551AbdK2R24 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 12:28:56 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kelvin Cao <kelvin.cao@microsemi.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:28:43 -0700
Message-Id: <20171129172844.21468-2-logang@deltatee.com>
In-Reply-To: <20171129172844.21468-1-logang@deltatee.com>
References: <20171129172844.21468-1-logang@deltatee.com>
Subject: [PATCH 1/2] switchtec: Added Global Fabric Manager Server (GFMS) event
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a new event type that is newly exposed by recent firmware. The event will
never occur if the firmware is too old. If user space tries to use this
event in an older kernel, it will just get an EINVAL which is perfectly
acceptable in the existing user space code.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c       | 1 +
 include/linux/switchtec.h            | 3 +++
 include/uapi/linux/switchtec_ioctl.h | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 730cc897b94d..7668d270725d 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -707,6 +707,7 @@ static const struct event_reg {
 	EV_GLB(SWITCHTEC_IOCTL_EVENT_CLI_MRPC_COMP_ASYNC,
 	       cli_mrpc_comp_async_hdr),
 	EV_GLB(SWITCHTEC_IOCTL_EVENT_GPIO_INT, gpio_interrupt_hdr),
+	EV_GLB(SWITCHTEC_IOCTL_EVENT_GFMS, gfms_event_hdr),
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_PART_RESET, part_reset_hdr),
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP, mrpc_comp_hdr),
 	EV_PAR(SWITCHTEC_IOCTL_EVENT_MRPC_COMP_ASYNC, mrpc_comp_async_hdr),
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 09d73d0d1aa8..42d121174fe2 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -100,6 +100,9 @@ struct sw_event_regs {
 	u32 gpio_interrupt_hdr;
 	u32 gpio_interrupt_data;
 	u32 reserved16[4];
+	u32 gfms_event_hdr;
+	u32 gfms_event_data;
+	u32 reserved17[4];
 } __packed;
 
 enum {
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index 75df44373034..4f4daf8db954 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -88,7 +88,8 @@ struct switchtec_ioctl_event_summary {
 #define SWITCHTEC_IOCTL_EVENT_FORCE_SPEED		26
 #define SWITCHTEC_IOCTL_EVENT_CREDIT_TIMEOUT		27
 #define SWITCHTEC_IOCTL_EVENT_LINK_STATE		28
-#define SWITCHTEC_IOCTL_MAX_EVENTS			29
+#define SWITCHTEC_IOCTL_EVENT_GFMS			29
+#define SWITCHTEC_IOCTL_MAX_EVENTS			30
 
 #define SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX -1
 #define SWITCHTEC_IOCTL_EVENT_IDX_ALL -2
-- 
2.11.0
