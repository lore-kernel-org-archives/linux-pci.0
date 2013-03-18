Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Garrett <matthew.garrett@nebula.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, linux-pci@vger.kernel.org,
	Josh Boyer <jwboyer@redhat.com>
Subject: [PATCH 02/12] SELinux: define mapping for CAP_COMPROMISE_KERNEL
Date: Mon, 18 Mar 2013 17:32:23 -0400
Message-Id: <1363642353-30749-2-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Josh Boyer <jwboyer@redhat.com>

Add the name of the new CAP_COMPROMISE_KERNEL capability. This allows SELinux
policies to properly map CAP_COMPROMISE_KERNEL to the appropriate
capability class.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
---
 security/selinux/include/classmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 14d04e6..ed99a2d 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -146,8 +146,8 @@ struct security_class_mapping secclass_map[] = {
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
 	{ "capability2",
-	  { "mac_override", "mac_admin", "syslog", "wake_alarm", "block_suspend",
-	    NULL } },
+	  { "mac_override", "mac_admin", "syslog", "wake_alarm",
+	    "block_suspend", "compromise_kernel", NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
-- 
1.8.1.2

