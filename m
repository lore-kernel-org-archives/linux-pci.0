Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB549504E;
	Fri, 11 Sep 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148835; cv=none; b=Ly6ZtQO5Gs9IG5HIdSCpCWz2G6WVj9bTOS3jez/VPsCxsK/vVTjjqiGuRO0VI27Ri1WOVW7bmeKtvXiLzstEMXPqHk5K40/aKQzVg1Jr7gFCkoeuraP9DJMvCttGQCkrpZzI0M2zJF7R+Zyimec7/jLW0btSYHl1N/Ph3Abq5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148835; c=relaxed/simple;
	bh=FvDNAs1nt85rTHybp22wpHzMFjt6BIQ5aV6U6y0fiV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IffvyC5rf3fY8041CPMjhJzzQaloBeyTZLqC+8VQazMwAa4dkLyoTrRYNGo/q29iE69dRvXSWG/eUUXnlXSUnffYxvOJKJDEoM12xX7rYt8eAR2ScjY+j18zrxUyrFeOmLcDSN7ME4NqbgVQ+pBbyiu5KJv62N3lPA7VOBq7hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=R1B8H1+i; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="R1B8H1+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148831; x=1820684831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJbbk3LWF9sIhfos1AEb1lxm5c8t9hJGGm6Fe8bvX4A=;
  b=R1B8H1+ius2Equ5rxgAw0Hpz73nqL7R3L2Cx6rMmpCnx8bc29HHjCNf3
   dSsQUkKLv8OFb/LkMW2yrTkwsNvObgaTM1z1Tncgb+l313NwFsKJX30u5
   Yyws0MKU61MLaYNi8JjlWKKhnEyUD7rtN209aQbQ6lMS4J/ltW6MmPurM
   dU3/q2P7QUsizz3kNur3svPGUztl6kydwU1x1GZYSEZ0LqIp1UI7Niq8Z
   h2wasY8I5kqpm4R6N1gfQriSIhS+iETw0MdfwOl3Eie8LVMGzg1T0Y0Lp
   p/znf9vdEpsoiCl+SkxclHqCHvAngn3O13nRQAo5jtDc+/CSizdpsBJBO
   A==;
X-CSE-ConnectionGUID: Er41EoCTRJSU+LVC3bObyw==
X-CSE-MsgGUID: WJgDU8iyTbejOMgRaxa3nQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28480116"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:47:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:1792]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.93:2525] with esmtp (Farcaster)
 id 081a47fd-4d6d-4715-9a6a-ce953a42307e; Fri, 11 Sep 2026 17:47:08 +0000 (UTC)
X-Farcaster-Flow-ID: 081a47fd-4d6d-4715-9a6a-ce953a42307e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:47:08 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:47:05 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 6/8] driver core: Defer uevents for devices registered in a staged window
Date: Fri, 11 Sep 2026 19:43:38 +0200
Message-ID: <20260911174414.97060-6-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Staged registration publishes a device's subtree in one step, so nothing
observes the device before it is complete. That does not hold for a
device registered from inside the window: device_add() calls hooks that
can register a child of the device being added, and such a child takes
the eager path and announces itself with KOBJ_ADD while its own path
resolves to nothing. Nothing replays that event, so a consumer that
cannot open the DEVPATH never learns of the child. Neither opt-in in
this series reaches that case: nothing attaches a wakeup source to a
PCI VF or to the VFIO class devices, and pci_acpi_setup() enables
wakeup only for a bridge that can do D3. It is reachable by code the
opt-in caller does not control: dpm_sysfs_add() registers a
wakeup-source device whenever power.wakeup is already attached, and
wakeup_source_register() registers one directly for a device that is
already registered, which a staged device is. The driver core
therefore handles the case rather than forbidding it in the opt-in
contract.

Defer such a registration, composing the idiom block/genhd.c already uses
for a disk's partition tree: suppress the uevents, complete the tree,
then unsuppress and replay KOBJ_ADD. A device whose directory kernfs
marked staged is enqueued suppressed on the window of the nearest
ancestor that opted in, and the window is drained as the ancestor's
device_add() returns, just after its own KOBJ_ADD, each member's ADD
delivered in registration order followed by BIND where a driver bound
in the window. An ancestor whose owner suppresses its uevent and
replays it after registration will see members announced before its
replayed ADD. The window lives in a global hashtable keyed by the
opted-in device, so no struct grows.

Members are expected to be registered synchronously by the opted-in
device_add() that owns the window, the only shape the driver core can
reason about here. Raw uevent_suppress is not reused as the detection
marker, precisely because a subsystem may already own it; a device found
already suppressed is left out of the window entirely. An in-window
KOBJ_CHANGE is dropped rather than replayed, as in the genhd case, since
only the addition can be reconstructed afterwards. A failed opted-in
registration closes its window without replaying anything and leaves
suppression set, so a member's KOBJ_REMOVE is dropped too and userspace
never sees a removal for an addition it never saw.

The staged_device suite gains five cases for the window: the replay of a
member's addition once the owner's device_add() returns, the aborted
window that replays nothing and leaves suppression set, a member behind
a class glue directory, the reconstructed KOBJ_BIND of a driver bound in
the window, and a member found already suppressed being left out of the
window.

If you would rather not carry this until a caller needs it, it can be
dropped and the restriction stated as an opt-in condition instead.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/base/core.c                    | 170 +++++++++++-
 drivers/base/test/staged-device-test.c | 364 +++++++++++++++++++++++++
 fs/sysfs/dir.c                         |  26 ++
 include/linux/device.h                 |  15 +
 include/linux/sysfs.h                  |   6 +
 5 files changed, 579 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index caba5610a04d..7d3784bd2136 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3663,6 +3663,148 @@ static int device_private_init(struct device *dev)
 	return 0;
 }
 
+/*
+ * Deferred uevents for devices registered inside a staged window.
+ *
+ * A hook called from an opted-in device_add() may register a child inside
+ * the still-invisible subtree; announcing it right away would advertise a
+ * path userspace cannot open, so its uevents are suppressed at registration
+ * and replayed once the window's top publishes.
+ *
+ * A window is a record on the top's device_add() stack, hashed by the top
+ * device, so a member is found without a field of its own in struct device,
+ * kobject or kernfs_node.  Membership is decided under @staged_windows_lock,
+ * which also serializes against the drain: a device either joins a window that
+ * has not drained yet, and is replayed, or finds no window -- which means the
+ * subtree is published and announcing immediately is correct.
+ */
+struct staged_window {
+	struct hlist_node	node;
+	struct device		*top;
+	struct list_head	members;
+};
+
+struct staged_member {
+	struct list_head	node;
+	struct device		*dev;		/* holds a reference */
+};
+
+static DEFINE_HASHTABLE(staged_windows, 6);
+static DEFINE_SPINLOCK(staged_windows_lock);
+
+static void staged_window_open(struct staged_window *win, struct device *top)
+{
+	win->top = top;
+	INIT_LIST_HEAD(&win->members);
+
+	spin_lock(&staged_windows_lock);
+	hash_add(staged_windows, &win->node, (unsigned long)top);
+	spin_unlock(&staged_windows_lock);
+}
+
+/*
+ * Suppress and enqueue @dev if it is being registered inside an ancestor's
+ * staged window.  The fast path is one query of @dev's own directory, which
+ * kernfs marked staged when it linked it below a staged parent, so the
+ * non-opted world pays no ancestor walk.  Only a device that is genuinely
+ * inside a window walks up to the nearest opted-in ancestor, the device whose
+ * window it is.
+ */
+static void device_defer_uevents(struct device *dev)
+{
+	struct staged_member *member;
+	struct staged_window *win;
+	struct device *top;
+
+	if (!sysfs_dir_staged(&dev->kobj))
+		return;
+
+	/*
+	 * Suppression already set belongs to whoever set it (block/genhd.c
+	 * suppresses a disk across device_add() and keeps a hidden disk
+	 * suppressed for good); taking no membership at all is what keeps
+	 * the drain from clearing it or announcing on the owner's behalf.
+	 */
+	if (dev_get_uevent_suppress(dev))
+		return;
+
+	for (top = dev->parent; top; top = top->parent)
+		if (dev_sysfs_staged(top))
+			break;
+	/*
+	 * Nothing above @dev opted in, so there is no window to defer into.
+	 * Announce immediately -- the eager behaviour, unresolvable path
+	 * included; a registration is not worth failing over a uevent.
+	 */
+	if (!top)
+		return;
+
+	member = kzalloc_obj(*member);
+	/*
+	 * Same fallback, same reason, for a membership record that cannot be
+	 * allocated: announce immediately rather than fail the registration.
+	 */
+	if (!member)
+		return;
+	member->dev = get_device(dev);
+
+	spin_lock(&staged_windows_lock);
+	hash_for_each_possible(staged_windows, win, node, (unsigned long)top) {
+		if (win->top != top)
+			continue;
+		dev_set_uevent_suppress(dev, 1);
+		list_add_tail(&member->node, &win->members);
+		member = NULL;
+		break;
+	}
+	spin_unlock(&staged_windows_lock);
+
+	if (member) {
+		put_device(dev);
+		kfree(member);
+	}
+}
+
+/*
+ * Close @win.  With @replay the members' suppressed uevents are delivered in
+ * registration order, ADD and then BIND for a member a driver has already bound
+ * to.  Without it -- the top's registration failed -- nothing is delivered and
+ * suppression stays set, so a member's KOBJ_REMOVE is dropped as well and
+ * userspace never sees a removal for an addition it never saw (a member
+ * deleted before publication is likewise never announced).  Emission
+ * sleeps, so the list is spliced out under the lock and walked without it.
+ *
+ * A member is expected to have been registered synchronously, by the top's own
+ * device_add(), so what the drain reads of a member is settled state written by
+ * this thread.  The registration and driver tests below are a guard against
+ * misuse, not an ordering contract with a thread registering members of its
+ * own: nothing here makes that concurrent.
+ */
+static void staged_window_close(struct staged_window *win, bool replay)
+{
+	struct staged_member *member, *tmp;
+	LIST_HEAD(members);
+
+	spin_lock(&staged_windows_lock);
+	hash_del(&win->node);
+	list_splice_init(&win->members, &members);
+	spin_unlock(&staged_windows_lock);
+
+	list_for_each_entry_safe(member, tmp, &members, node) {
+		struct device *dev = member->dev;
+
+		if (replay && device_is_registered(dev)) {
+			dev_set_uevent_suppress(dev, 0);
+			kobject_uevent(&dev->kobj, KOBJ_ADD);
+			/* best effort: members bind in this thread */
+			if (READ_ONCE(dev->driver))
+				kobject_uevent(&dev->kobj, KOBJ_BIND);
+		}
+		put_device(dev);
+		kfree(member);
+	}
+}
+
 /**
  * device_add - add device to device hierarchy.
  * @dev: device.
@@ -3696,6 +3838,7 @@ int device_add(struct device *dev)
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
+	struct staged_window win;
 	int error = -EINVAL;
 	struct kobject *glue_dir = NULL;
 
@@ -3760,6 +3903,17 @@ int device_add(struct device *dev)
 		goto Error;
 	}
 
+	/*
+	 * The directory is invisible from here to publication: open the
+	 * window that devices registered from inside it defer their uevents
+	 * into, or -- for a device that is itself such a registration --
+	 * join the window of the ancestor whose subtree it landed in.
+	 */
+	if (kobject_sd_staged(&dev->kobj))
+		staged_window_open(&win, dev);
+	else
+		device_defer_uevents(dev);
+
 	/* notify platform of device entry */
 	device_platform_notify(dev);
 
@@ -3790,8 +3944,9 @@ int device_add(struct device *dev)
 	 * whose target is this device -- class/bus/ACPI -- are created earlier
 	 * and resolve only at publication.)  Children added by notify hooks
 	 * inside the staged window were created staged-interior and are
-	 * published together with this device; their uevents may precede
-	 * their sysfs visibility.
+	 * published together with this device; their uevents were suppressed at
+	 * registration and are replayed below, once publication has made them
+	 * resolvable.
 	 */
 	if (kobject_sd_staged(&dev->kobj)) {
 		error = sysfs_publish_dir(&dev->kobj);
@@ -3818,6 +3973,10 @@ int device_add(struct device *dev)
 	bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 
+	/* the subtree is visible now: announce what was registered inside it */
+	if (kobject_sd_staged(&dev->kobj))
+		staged_window_close(&win, true);
+
 	/*
 	 * Check if any of the other devices (consumers) have been waiting for
 	 * this device (supplier) to be added so that they can create a device
@@ -3897,6 +4056,13 @@ int device_add(struct device *dev)
 	device_remove_file(dev, &dev_attr_uevent);
  attrError:
 	device_platform_notify_remove(dev);
+	/*
+	 * Matching remove notifications must undo registrations made by
+	 * the add notifications.  Anything still queued is dropped without
+	 * announcement.
+	 */
+	if (kobject_sd_staged(&dev->kobj))
+		staged_window_close(&win, false);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
diff --git a/drivers/base/test/staged-device-test.c b/drivers/base/test/staged-device-test.c
index d32f00214a8b..55891d8426ba 100644
--- a/drivers/base/test/staged-device-test.c
+++ b/drivers/base/test/staged-device-test.c
@@ -858,8 +858,13 @@ static void staged_test_device_add_unwind(struct kunit *test)
 
 /* Deferred bus-klist insertion, on a real bus with a real driver. */
 
+/* Records replayed child uevents; defined with the in-window cases below. */
+static int staged_test_bus_uevent(const struct device *dev,
+				  struct kobj_uevent_env *env);
+
 static const struct bus_type staged_test_bus = {
 	.name = "staged_kunit_bus",
+	.uevent = staged_test_bus_uevent,
 };
 
 static int staged_test_driver_probe(struct device *dev)
@@ -1010,6 +1015,360 @@ static void staged_test_hashed_slot_collision(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, sd_subdirs(priv->parent), base);
 }
 
+/* Uevents deferred for devices registered inside the window. */
+
+/*
+ * A device registered from inside another device's staged window must not
+ * announce itself while its path is unresolvable, and must be announced once
+ * the window's top publishes.
+ *
+ * The seam: the hook has to run between kobject_add() and publication, and the
+ * one such point a test can drive is an attribute group's is_visible()
+ * callback, which device_add_attrs() invokes on the device's own groups inside
+ * the window.  BUS_NOTIFY_ADD_DEVICE cannot serve -- device_add() emits it
+ * after publication.  (The in-tree instance is the wakeup source an ACPI
+ * platform notifier registers under the device being added.)
+ */
+struct staged_window_ctx {
+	struct kunit *test;
+	struct device *top;		/* the staged device being added */
+	struct device *child;		/* pre-allocated, added by the hook */
+	const struct class *child_class;	/* set: a glue dir interposes */
+	const struct bus_type *child_bus;	/* if set, a driver can bind */
+	bool suppress_child;		/* the child's owner suppresses it */
+	bool hook_ran;
+	bool delete_in_window;		/* delete the child while inside */
+	int add_ret;
+	unsigned int suppressed_in_window;
+	bool staged_in_window;
+	bool bound_in_window;
+	unsigned int suppressed_at_delete;
+	unsigned int add_uevents;	/* child ACTION=add bus callbacks */
+	unsigned int bind_uevents;	/* child ACTION=bind bus callbacks */
+	unsigned int uevent_seq;
+	unsigned int add_seq;		/* sequence of the last ADD */
+	unsigned int bind_seq;		/* sequence of the last BIND */
+};
+
+static struct staged_window_ctx *staged_window_ctx;
+
+/*
+ * Records the child's replayed uevents as they are dispatched through the
+ * bus uevent callback -- which runs upstream of netlink broadcast, so this
+ * observes action-specific kernel dispatch and ordering, not reception by
+ * any consumer.  Scoped to the active context's child: the same static bus
+ * serves another case, and teardown emits further events.
+ */
+static int staged_test_bus_uevent(const struct device *dev,
+				  struct kobj_uevent_env *env)
+{
+	struct staged_window_ctx *c = staged_window_ctx;
+	int i;
+
+	if (!c || dev != c->child)
+		return 0;
+
+	for (i = 0; i < env->envp_idx; i++) {
+		if (!strcmp(env->envp[i], "ACTION=add")) {
+			c->add_uevents++;
+			c->add_seq = ++c->uevent_seq;
+		} else if (!strcmp(env->envp[i], "ACTION=bind")) {
+			c->bind_uevents++;
+			c->bind_seq = ++c->uevent_seq;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Outcome-aware deferred cleanup for the window tests' devices: registered
+ * as soon as an initialized reference exists, so a fatal assertion cannot
+ * leak a device whichever side of registration it aborts on.  Explicit
+ * teardown goes through kunit_release_action() so no stale action remains.
+ */
+static void staged_dev_cleanup(void *data)
+{
+	struct device *dev = data;
+
+	if (device_is_registered(dev))
+		device_unregister(dev);
+	else
+		put_device(dev);
+}
+
+static umode_t staged_window_is_visible(struct kobject *kobj,
+					struct attribute *attr, int n)
+{
+	struct staged_window_ctx *c = staged_window_ctx;
+
+	if (!c || c->hook_ran || kobj != &c->top->kobj)
+		return attr->mode;
+	c->hook_ran = true;
+
+	c->add_ret = device_add(c->child);
+	if (c->add_ret)
+		return attr->mode;
+
+	c->suppressed_in_window = dev_get_uevent_suppress(c->child);
+	c->staged_in_window = sd_is_staged(&c->child->kobj);
+	c->bound_in_window = c->child->driver;
+
+	if (c->delete_in_window) {
+		struct device *child = c->child;
+
+		device_del(child);
+		c->suppressed_at_delete = dev_get_uevent_suppress(child);
+		c->child = NULL;
+		/* runs staged_dev_cleanup: unregistered now, so put_device */
+		kunit_release_action(c->test, staged_dev_cleanup, child);
+	}
+	return attr->mode;
+}
+
+static struct attribute in_window_attr = {
+	.name = "in_window_attr", .mode = 0644,
+};
+
+static struct attribute *in_window_attrs[] = { &in_window_attr, NULL };
+static const struct attribute_group in_window_grp = {
+	.attrs = in_window_attrs,
+	.is_visible = staged_window_is_visible,
+};
+
+static const struct attribute_group *in_window_grps[] = {
+	&in_window_grp, NULL,
+};
+
+/* Register @name staged under @parent, with a child added inside its window. */
+static struct device *staged_window_dev_add(struct kunit *test,
+					    struct staged_window_ctx *ctx,
+					    struct device *parent,
+					    const char *name, int want)
+{
+	struct device *top;
+	int ret;
+
+	ctx->test = test;
+	top = staged_dev_alloc(test, parent, NULL, name, true);
+	top->groups = in_window_grps;
+	ctx->top = top;
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_cleanup,
+							top), 0);
+	ctx->child = staged_dev_alloc(test, top, ctx->child_bus, "in_window",
+				      false);
+	ctx->child->class = ctx->child_class;
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_cleanup,
+							ctx->child), 0);
+	/* the genhd shape: an owner suppresses the device before adding it */
+	if (ctx->suppress_child)
+		dev_set_uevent_suppress(ctx->child, 1);
+
+	staged_window_ctx = ctx;
+	ret = device_add(top);
+	staged_window_ctx = NULL;
+
+	/* the success paths below depend on a registered top */
+	if (!want)
+		KUNIT_ASSERT_EQ(test, ret, 0);
+	else
+		KUNIT_EXPECT_EQ(test, ret, want);
+
+	/* the hook ran inside the window, and the child registered there */
+	KUNIT_ASSERT_TRUE(test, ctx->hook_ran);
+	KUNIT_ASSERT_EQ(test, ctx->add_ret, 0);
+	KUNIT_EXPECT_EQ(test, ctx->suppressed_in_window, 1u);
+	KUNIT_EXPECT_TRUE(test, ctx->staged_in_window);
+	return top;
+}
+
+/*
+ * Replay: the child is suppressed and invisible inside the window, and once
+ * the top's device_add() returns it is visible and unsuppressed again.
+ */
+static void staged_test_in_window_uevent_replay(struct kunit *test)
+{
+	struct staged_window_ctx ctx = {};
+	struct device *root, *top;
+
+	root = root_device_register("staged_kunit_replay");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	top = staged_window_dev_add(test, &ctx, root, "replay_top", 0);
+
+	/* published: the deferred addition was announced and is resolvable */
+	KUNIT_EXPECT_EQ(test, dev_get_uevent_suppress(ctx.child), 0u);
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&ctx.child->kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(&top->kobj, "in_window"));
+
+	/* a child goes before the parent directory it lives in */
+	kunit_release_action(test, staged_dev_cleanup, ctx.child);
+}
+
+/*
+ * Unwind: the top's registration fails at publication, after a child was
+ * registered inside the window and deleted again there.  The deletion must
+ * leave suppression set -- userspace saw no addition, so it must see no
+ * removal -- the aborted window must drain without replaying anything, and the
+ * mechanism must still work for the next window.
+ */
+static void staged_test_in_window_uevent_unwind(struct kunit *test)
+{
+	struct staged_window_ctx ctx = { .delete_in_window = true };
+	struct staged_window_ctx retry_ctx = {};
+	struct device *root, *eager, *top, *retry;
+
+	root = root_device_register("staged_kunit_replay_unwind");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	/* the collision winner: the staged top below fails at publication */
+	eager = staged_dev_alloc(test, root, NULL, "collide", false);
+	KUNIT_ASSERT_EQ(test, device_add(eager), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_dev_unregister,
+							eager), 0);
+
+	top = staged_window_dev_add(test, &ctx, root, "collide", -EEXIST);
+
+	/* deleted before publication: still suppressed, so its REMOVE is too */
+	KUNIT_EXPECT_EQ(test, ctx.suppressed_at_delete, 1u);
+
+	/* the failed top is fully unwound, and its last reference frees it */
+	KUNIT_EXPECT_NULL(test, top->kobj.sd);
+	kunit_release_action(test, staged_dev_cleanup, top);
+
+	/* the next window still defers and replays */
+	retry = staged_window_dev_add(test, &retry_ctx, root, "retry", 0);
+	KUNIT_EXPECT_EQ(test, dev_get_uevent_suppress(retry_ctx.child), 0u);
+	KUNIT_EXPECT_TRUE(test, child_visible(&retry->kobj, "in_window"));
+	kunit_release_action(test, staged_dev_cleanup, retry_ctx.child);
+}
+
+/*
+ * A member behind a glue directory.  An eager class device parented to the
+ * staged top does not land directly underneath it: get_device_parent()
+ * interposes a class glue directory, so the member's own directory sits a level
+ * further down.  It is detected all the same, because detection queries the
+ * member's own directory -- which kernfs marks staged for every node it links
+ * inside a staged subtree, at any depth -- rather than its parent kobject,
+ * which here is the glue directory and never opted in.
+ */
+static void staged_test_in_window_class_member(struct kunit *test)
+{
+	struct staged_window_ctx ctx = {};
+	struct device *root, *top;
+	struct class *class;
+
+	class = class_create("staged_kunit_in_window");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, class);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_class_destroy,
+							class), 0);
+
+	root = root_device_register("staged_kunit_class_member");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	ctx.child_class = class;
+	top = staged_window_dev_add(test, &ctx, root, "class_top", 0);
+
+	/* the glue dir interposed: the member is not the top's own child */
+	KUNIT_EXPECT_PTR_NE(test, ctx.child->kobj.parent, &top->kobj);
+
+	KUNIT_EXPECT_EQ(test, dev_get_uevent_suppress(ctx.child), 0u);
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&ctx.child->kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(ctx.child->kobj.parent,
+					      "in_window"));
+
+	kunit_release_action(test, staged_dev_cleanup, ctx.child);
+}
+
+/*
+ * A member a driver binds to inside the window.  bus_probe_device() runs from
+ * the member's own device_add(), so the binding happens while the member is
+ * still suppressed and its KOBJ_BIND is dropped along with everything else.
+ * Successful closure must reconstruct it after the ADD: exactly one ADD
+ * followed by exactly one BIND passed through the child device's bus uevent
+ * callback.  The callback runs upstream of netlink broadcast, so this pins
+ * kernel dispatch and ordering, not delivery to a consumer.
+ */
+static void staged_test_in_window_bind_replay(struct kunit *test)
+{
+	struct staged_window_ctx ctx = {};
+	struct device *root, *top;
+
+	KUNIT_ASSERT_EQ(test, bus_register(&staged_test_bus), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_bus_unregister,
+							(void *)&staged_test_bus), 0);
+
+	KUNIT_ASSERT_EQ(test, driver_register(&staged_test_driver), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_driver_unregister,
+							&staged_test_driver), 0);
+
+	root = root_device_register("staged_kunit_bind_replay");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	ctx.child_bus = &staged_test_bus;
+	top = staged_window_dev_add(test, &ctx, root, "bind_top", 0);
+
+	/* the driver bound inside the window, so the BIND was suppressed too */
+	KUNIT_EXPECT_TRUE(test, ctx.bound_in_window);
+
+	/* the drain replayed exactly one ADD, then exactly one BIND */
+	KUNIT_EXPECT_EQ(test, ctx.add_uevents, 1u);
+	KUNIT_EXPECT_EQ(test, ctx.bind_uevents, 1u);
+	KUNIT_EXPECT_LT(test, ctx.add_seq, ctx.bind_seq);
+
+	KUNIT_EXPECT_EQ(test, dev_get_uevent_suppress(ctx.child), 0u);
+	KUNIT_EXPECT_PTR_EQ(test, ctx.child->driver, &staged_test_driver);
+	KUNIT_EXPECT_TRUE(test, child_visible(&top->kobj, "in_window"));
+
+	kunit_release_action(test, staged_dev_cleanup, ctx.child);
+}
+
+/*
+ * A member that owns its own suppression (the genhd shape; see
+ * device_defer_uevents()) is not taken into the window at all, and has to
+ * come out of it exactly as it went in: neither unsuppressed nor announced;
+ * the suppression the case observes in-window is the owner's.
+ */
+static void staged_test_in_window_foreign_suppress(struct kunit *test)
+{
+	struct staged_window_ctx ctx = { .suppress_child = true };
+	struct device *root, *top;
+
+	root = root_device_register("staged_kunit_foreign_suppress");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, root);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							staged_root_unregister,
+							root), 0);
+
+	top = staged_window_dev_add(test, &ctx, root, "foreign_top", 0);
+
+	/* the drain left the owner's state alone: not cleared, not replayed */
+	KUNIT_EXPECT_EQ(test, dev_get_uevent_suppress(ctx.child), 1u);
+
+	/* and the member was published with the window all the same */
+	KUNIT_EXPECT_FALSE(test, sd_is_staged(&ctx.child->kobj));
+	KUNIT_EXPECT_TRUE(test, child_visible(&top->kobj, "in_window"));
+
+	kunit_release_action(test, staged_dev_cleanup, ctx.child);
+}
+
 static struct kunit_case staged_device_tests[] = {
 	KUNIT_CASE(staged_test_publish_end_to_end),
 	KUNIT_CASE(staged_test_duplicate_name),
@@ -1026,6 +1385,11 @@ static struct kunit_case staged_device_tests[] = {
 	KUNIT_CASE(staged_test_device_add_unwind),
 	KUNIT_CASE(staged_test_bus_klist),
 	KUNIT_CASE(staged_test_hashed_slot_collision),
+	KUNIT_CASE(staged_test_in_window_uevent_replay),
+	KUNIT_CASE(staged_test_in_window_uevent_unwind),
+	KUNIT_CASE(staged_test_in_window_class_member),
+	KUNIT_CASE(staged_test_in_window_bind_replay),
+	KUNIT_CASE(staged_test_in_window_foreign_suppress),
 	{}
 };
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 1694c01e8b84..33ee798d421c 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -114,6 +114,32 @@ int sysfs_publish_dir(struct kobject *kobj)
 }
 EXPORT_SYMBOL_IF_KUNIT(sysfs_publish_dir);
 
+/**
+ * sysfs_dir_staged - whether a kobject's directory is still unpublished
+ * @kobj: object to query
+ *
+ * True while @kobj's directory belongs to a staged subtree, either because it
+ * was created staged or because it was created underneath one -- kernfs marks
+ * every node it adds inside a staged subtree, so the answer holds at any depth.
+ *
+ * The read is advisory, in the shape kernfs_staged_lock() uses while it climbs:
+ * publication clears the flag under the staged subtree mutex, which this query
+ * does not take.  A %true answer therefore means "staged a moment ago", and a
+ * caller acting on it must re-establish authority under whatever lock
+ * serializes it against publication.  A %false answer cannot be stale for the
+ * caller that created the directory itself: the flag is set in that caller's
+ * own thread and publication only ever clears it.
+ *
+ * Return: %true if the directory is still staged.
+ */
+bool sysfs_dir_staged(const struct kobject *kobj)
+{
+	struct kernfs_node *kn = READ_ONCE(kobj->sd);
+
+	/* advisory read; the caller re-establishes authority (see above) */
+	return kn && (data_race(kn->flags) & KERNFS_STAGED);
+}
+
 /**
  *	sysfs_remove_dir - remove an object's directory.
  *	@kobj:	object.
diff --git a/include/linux/device.h b/include/linux/device.h
index 74701a8aa9d2..89dc57ab3c94 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -607,6 +607,21 @@ struct device_physical_location {
  *		sysfs-root lock cost stops scaling with the number of nodes in
  *		the directory, which matters when many devices (for example
  *		SR-IOV virtual functions) are registered in parallel.
+ *		Devices registered from inside such a window -- synchronously,
+ *		from the opted-in device_add() itself, as one of the hooks it
+ *		calls may do; a foreign thread registering members is outside
+ *		this contract -- have their uevents suppressed until
+ *		publication.  Every uevent emitted in the window is dropped;
+ *		what is replayed afterwards is the addition, as KOBJ_ADD
+ *		followed by KOBJ_BIND if a driver is bound by then.
+ *		Publication has to succeed before queued members are
+ *		announced.  If top-level registration fails, queued members
+ *		are not replayed and remain suppressed; registrations made by
+ *		an add notification must be removed by its matching remove
+ *		notification.  A device that is already suppressed when it is
+ *		detected is left untouched, that state belonging to whoever set
+ *		it, and a device that has itself opted in cannot nest inside
+ *		another window -- its publication is rejected.
  *		Must be set before device_add().
  * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b537a5b52e1a..5538858f31f7 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -398,6 +398,7 @@ struct sysfs_ops {
 
 int __must_check sysfs_create_dir_ns(struct kobject *kobj, const struct ns_common *ns);
 int __must_check sysfs_publish_dir(struct kobject *kobj);
+bool sysfs_dir_staged(const struct kobject *kobj);
 void sysfs_remove_dir(struct kobject *kobj);
 int __must_check sysfs_rename_dir_ns(struct kobject *kobj, const char *new_name,
 				     const struct ns_common *new_ns);
@@ -513,6 +514,11 @@ static inline int sysfs_publish_dir(struct kobject *kobj)
 	return 0;
 }
 
+static inline bool sysfs_dir_staged(const struct kobject *kobj)
+{
+	return false;
+}
+
 static inline void sysfs_remove_dir(struct kobject *kobj)
 {
 }
-- 
2.47.3

