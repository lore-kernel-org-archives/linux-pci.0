Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28788 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232AbbCDIBb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 03:01:31 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
	Borislav Petkov <bp@suse.de>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 05/15] x86, kaslr: consolidate the mem_avoid filling
Date: Wed,  4 Mar 2015 00:00:38 -0800
Message-Id: <1425456048-16236-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now ZO sit end of the buffer, we can find out where is ZO text
and data/bss etc.

[input, input+input_size) is copied compressed kernel, not the whole ZO.
[output, output+init_size) is the buffer for VO.

[input+input_size, output+init_size) is [_text, _end) for ZO.
that will be first range in mem_avoid. we don't need to guess that anymore.

That area aleady include heap and stack. So we don't need to put
them into mem_avoid array.

Also we need to put boot_params into the mem_avoid too.
as with 64bit boot loader will put them above 4G.

Also change output_size to init_size, as we pass that instead already.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/boot/compressed/aslr.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/aslr.c b/arch/x86/boot/compressed/aslr.c
index 7083c16..e8486a5 100644
--- a/arch/x86/boot/compressed/aslr.c
+++ b/arch/x86/boot/compressed/aslr.c
@@ -116,7 +116,7 @@ struct mem_vector {
 	unsigned long size;
 };
 
-#define MEM_AVOID_MAX 5
+#define MEM_AVOID_MAX 4
 static struct mem_vector mem_avoid[MEM_AVOID_MAX];
 
 static bool mem_contains(struct mem_vector *region, struct mem_vector *item)
@@ -142,7 +142,7 @@ static bool mem_overlaps(struct mem_vector *one, struct mem_vector *two)
 }
 
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
-			   unsigned long output, unsigned long output_size)
+			   unsigned long output, unsigned long init_size)
 {
 	u64 initrd_start, initrd_size;
 	u64 cmd_line, cmd_line_size;
@@ -151,10 +151,13 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/*
 	 * Avoid the region that is unsafe to overlap during
-	 * decompression (see calculations at top of misc.c).
+	 * decompression.
+	 * As we already move compressed to the end of buffer,
+	 * [input+input_size, output+init_size) has [_text, _end)
+	 * for arch/x86/boot/compressed/vmlinux.
 	 */
-	unsafe_len = (output_size >> 12) + 32768 + 18;
-	unsafe = (unsigned long)input + input_size - unsafe_len;
+	unsafe_len = output + init_size - (input + input_size);
+	unsafe = (unsigned long)input + input_size;
 	mem_avoid[0].start = unsafe;
 	mem_avoid[0].size = unsafe_len;
 
@@ -176,13 +179,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	mem_avoid[2].start = cmd_line;
 	mem_avoid[2].size = cmd_line_size;
 
-	/* Avoid heap memory. */
-	mem_avoid[3].start = (unsigned long)free_mem_ptr;
-	mem_avoid[3].size = BOOT_HEAP_SIZE;
-
-	/* Avoid stack memory. */
-	mem_avoid[4].start = (unsigned long)free_mem_end_ptr;
-	mem_avoid[4].size = BOOT_STACK_SIZE;
+	/* Avoid params */
+	mem_avoid[3].start = (unsigned long)real_mode;
+	mem_avoid[3].size = sizeof(*real_mode);
 }
 
 /* Does this memory vector overlap a known avoided area? */
@@ -327,7 +326,7 @@ unsigned char *choose_kernel_location(struct boot_params *params,
 				      unsigned char *input,
 				      unsigned long input_size,
 				      unsigned char *output,
-				      unsigned long output_size)
+				      unsigned long init_size)
 {
 	unsigned long choice = (unsigned long)output;
 	unsigned long random;
@@ -349,10 +348,10 @@ unsigned char *choose_kernel_location(struct boot_params *params,
 
 	/* Record the various known unsafe memory ranges. */
 	mem_avoid_init((unsigned long)input, input_size,
-		       (unsigned long)output, output_size);
+		       (unsigned long)output, init_size);
 
 	/* Walk e820 and find a random address. */
-	random = find_random_addr(choice, output_size);
+	random = find_random_addr(choice, init_size);
 	if (!random) {
 		debug_putstr("KASLR could not find suitable E820 region...\n");
 		goto out;
-- 
1.8.4.5

