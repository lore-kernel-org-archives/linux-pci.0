Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <385c18397ac1b9a999672e676641cb62f556b5b5.1458126755.git.lukas@wunner.de>
In-Reply-To: <cover.1458126755.git.lukas@wunner.de>
References: <cover.1458126755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 16 Mar 2016 15:50:35 +0100
Subject: [RFC 2/4] thunderbolt: Fix typos and magic number
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix typo in tb_cfg_print_error() message.
Fix bytecount in struct tb_drom_entry_port comment.
Replace magic number in tb_switch_alloc().
Rename tb_sw_set_unpplugged() and TB_CAL_IECS.
                   ^                   ^

Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/ctl.c     |  2 +-
 drivers/thunderbolt/eeprom.c  |  2 +-
 drivers/thunderbolt/switch.c  | 10 +++++-----
 drivers/thunderbolt/tb.c      |  2 +-
 drivers/thunderbolt/tb.h      |  2 +-
 drivers/thunderbolt/tb_regs.h |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 799634b..1146ff4 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -249,7 +249,7 @@ static void tb_cfg_print_error(struct tb_ctl *ctl,
 		 * cfg_read/cfg_write.
 		 */
 		tb_ctl_WARN(ctl,
-			"CFG_ERROR(%llx:%x): Invalid config space of offset\n",
+			"CFG_ERROR(%llx:%x): Invalid config space or offset\n",
 			res->response_route, res->response_port);
 		return;
 	case TB_CFG_ERROR_NO_SUCH_PORT:
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 0dde34e..47e56e8 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -221,7 +221,7 @@ struct tb_drom_entry_port {
 	u8 micro1:4;
 	u8 micro3;
 
-	/* BYTES 5-6, TODO: verify (find hardware that has these set) */
+	/* BYTES 6-7, TODO: verify (find hardware that has these set) */
 	u8 peer_port_rid:4;
 	u8 unknown3:3;
 	bool has_peer_port:1;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index db73ffe..c6270f0 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -350,7 +350,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
 		return NULL;
 
 	sw->tb = tb;
-	if (tb_cfg_read(tb->ctl, &sw->config, route, 0, 2, 0, 5))
+	if (tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5))
 		goto err;
 	tb_info(tb,
 		"initializing Switch at %#llx (depth: %d, up port: %d)\n",
@@ -426,9 +426,9 @@ err:
 }
 
 /**
- * tb_sw_set_unpplugged() - set is_unplugged on switch and downstream switches
+ * tb_sw_set_unplugged() - set is_unplugged on switch and downstream switches
  */
-void tb_sw_set_unpplugged(struct tb_switch *sw)
+void tb_sw_set_unplugged(struct tb_switch *sw)
 {
 	int i;
 	if (sw == sw->tb->root_switch) {
@@ -442,7 +442,7 @@ void tb_sw_set_unpplugged(struct tb_switch *sw)
 	sw->is_unplugged = true;
 	for (i = 0; i <= sw->config.max_port_number; i++) {
 		if (!tb_is_upstream_port(&sw->ports[i]) && sw->ports[i].remote)
-			tb_sw_set_unpplugged(sw->ports[i].remote->sw);
+			tb_sw_set_unplugged(sw->ports[i].remote->sw);
 	}
 }
 
@@ -484,7 +484,7 @@ int tb_switch_resume(struct tb_switch *sw)
 			|| tb_switch_resume(port->remote->sw)) {
 			tb_port_warn(port,
 				     "lost during suspend, disconnecting\n");
-			tb_sw_set_unpplugged(port->remote->sw);
+			tb_sw_set_unplugged(port->remote->sw);
 		}
 	}
 	return 0;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index d2c3fe3..24b6d30 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -246,7 +246,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 	if (ev->unplug) {
 		if (port->remote) {
 			tb_port_info(port, "unplugged\n");
-			tb_sw_set_unpplugged(port->remote->sw);
+			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
 			tb_switch_free(port->remote->sw);
 			port->remote = NULL;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 8b0d7cf..61d57ba 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -226,7 +226,7 @@ void tb_switch_free(struct tb_switch *sw);
 void tb_switch_suspend(struct tb_switch *sw);
 int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb *tb, u64 route);
-void tb_sw_set_unpplugged(struct tb_switch *sw);
+void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_switch *get_switch_at_route(struct tb_switch *sw, u64 route);
 
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 6577af7..1e2a4a8 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -30,7 +30,7 @@ enum tb_cap {
 	TB_CAP_I2C		= 0x0005,
 	TB_CAP_PLUG_EVENTS	= 0x0105, /* also EEPROM */
 	TB_CAP_TIME2		= 0x0305,
-	TB_CAL_IECS		= 0x0405,
+	TB_CAP_IECS		= 0x0405,
 	TB_CAP_LINK_CONTROLLER	= 0x0605, /* also IECS */
 };
 
-- 
2.7.0

