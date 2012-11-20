Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] AER-QEMU: Bring down the guest when KVM detects a PCI
 device error
Date: Tue, 20 Nov 2012 06:32:38 +0000
Message-ID: <F9E001219150CB45BEDC82A650F360C90146FD06@G4W3208.americas.hpqcorp.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- When KVM_RUN ioctl returns with an exit reason requesting a shutdown
of the guest due to a PCI device error detected by AER, shutdown the
guest immediately.

Signed-off-by: Vijay Mohan Pandarathil <vijaymohan.pandarathil@hp.com>
---
 kvm-all.c                 | 6 ++++++
 linux-headers/linux/kvm.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/kvm-all.c b/kvm-all.c
index b6d0483..aaff44c 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1592,6 +1592,12 @@ int kvm_cpu_exec(CPUArchState *env)
             qemu_system_reset_request();
             ret = EXCP_INTERRUPT;
             break;
+        case KVM_EXIT_AER_SHUTDOWN:
+            fprintf(stderr, "KVM: PCI device assigned to guest encountered "
+                               "an uncorrectable error. Stopping guest\n");
+            qemu_system_shutdown_request();
+            ret = EXCP_INTERRUPT;
+            break;
         case KVM_EXIT_UNKNOWN:
             fprintf(stderr, "KVM: unknown exit, hardware reason %" PRIx64 "\n",
                     (uint64_t)run->hw.hardware_exit_reason);
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 81d2feb..64906ef 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -167,6 +167,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_OSI              18
 #define KVM_EXIT_PAPR_HCALL	  19
 #define KVM_EXIT_S390_UCONTROL	  20
+#define KVM_EXIT_AER_SHUTDOWN     21
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 #define KVM_INTERNAL_ERROR_EMULATION 1
-- 
1.7.11.3

