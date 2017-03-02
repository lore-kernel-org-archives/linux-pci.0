Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  2 Mar 2017 16:24:32 -0700
Message-Id: <1488497074-14186-3-git-send-email-logang@deltatee.com>
In-Reply-To: <1488497074-14186-1-git-send-email-logang@deltatee.com>
References: <1488497074-14186-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v7 2/4] switchtec: Add user interface documentation
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds standard documentation for the sysfs switchtec attributes and
a RST formatted text file which documents the char device interface.
Jonathan Corbet has indicated he will move this to a new user-space
developer documentation book once it's created.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
Tested-by: Krishna Dhulipala <krishnad@fb.com>
Reviewed-by: Wei Zhang <wzhang@fb.com>
Reviewed-by: Jens Axboe <axboe@fb.com>
---
 Documentation/switchtec.txt | 53 +++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/switchtec.txt

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
new file mode 100644
index 0000000..4bced4c
--- /dev/null
+++ b/Documentation/switchtec.txt
@@ -0,0 +1,53 @@
+========================
+Linux Switchtec Support
+========================
+
+Microsemi's "Switchtec" line of PCI switch devices is already
+supported by the kernel with standard PCI switch drivers. However, the
+Switchtec device advertises a special management endpoint which
+enables some additional functionality. This includes:
+
+* Packet and Byte Counters
+* Firmware Upgrades
+* Event and Error logs
+* Querying port link status
+* Custom user firmware commands
+
+The switchtec kernel module implements this functionality.
+
+
+Interface
+=========
+
+The primary means of communicating with the Switchtec management firmware is
+through the Memory-mapped Remote Procedure Call (MRPC) interface.
+Commands are submitted to the interface with a 4-byte command
+identifier and up to 1KB of command specific data. The firmware will
+respond with a 4 bytes return code and up to 1KB of command specific
+data. The interface only processes a single command at a time.
+
+
+Userspace Interface
+===================
+
+The MRPC interface will be exposed to userspace through a simple char
+device: /dev/switchtec#, one for each management endpoint in the system.
+
+The char device has the following semantics:
+
+* A write must consist of at least 4 bytes and no more than 1028 bytes.
+  The first four bytes will be interpreted as the command to run and
+  the remainder will be used as the input data. A write will send the
+  command to the firmware to begin processing.
+
+* Each write must be followed by exactly one read. Any double write will
+  produce an error and any read that doesn't follow a write will
+  produce an error.
+
+* A read will block until the firmware completes the command and return
+  the four bytes of status plus up to 1024 bytes of output data. (The
+  length will be specified by the size parameter of the read call --
+  reading less than 4 bytes will produce an error.
+
+* The poll call will also be supported for userspace applications that
+  need to do other things while waiting for the command to complete.
diff --git a/MAINTAINERS b/MAINTAINERS
index a57686f..aa702b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9512,6 +9512,7 @@ M:	Stephen Bates <stephen.bates@microsemi.com>
 M:	Logan Gunthorpe <logang@deltatee.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/switchtec.txt
 F:	drivers/pci/switch/switchtec*
 
 PCI DRIVER FOR NVIDIA TEGRA
-- 
2.1.4
