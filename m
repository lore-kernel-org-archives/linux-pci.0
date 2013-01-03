Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1357171594.25181.19.camel@joe-AO722>
Subject: [PATCH] checkpatch: prefer dev_<level>( to dev_printk(KERN_<LEVEL>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com,
	lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com,
	bp@alien8.de, rostedt@goodmis.org, mchehab@redhat.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Wed, 02 Jan 2013 16:06:34 -0800
In-Reply-To: <20130102232743.5706.63153.stgit@grignak.americas.hpqcorp.net>
References: <20130102232730.5706.82243.stgit@grignak.americas.hpqcorp.net>
	 <20130102232743.5706.63153.stgit@grignak.americas.hpqcorp.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add YA check to printk style.

dev_<level> uses are functions and generate smaller
object code than dev_printk(KERN_<LEVEL>.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4d2c7df..f50b32d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2430,6 +2430,16 @@ sub process {
 			     "Prefer pr_warn(... to pr_warning(...\n" . $herecurr);
 		}
 
+		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
+			my $orig = $1;
+			my $level = lc($orig);
+			$level = "warn" if ($level eq "warning");
+			my $level2 = $level;
+			$level2 = "dbg" if ($level eq "debug");
+			WARN("PREFER_DEV_LEVEL",
+			     "Prefer dev_$level2(... to dev_printk(KERN_$orig, ...\n" . $herecurr);
+		}
+
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
 		if (($line=~/$Type\s*$Ident\(.*\).*\s{/) and


