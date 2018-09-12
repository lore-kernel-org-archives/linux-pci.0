Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:15218 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILN6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 09:58:55 -0400
From: <Wesley.Sheng@microchip.com>
To: <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <corbet@lwn.net>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Wesley.Sheng@microchip.com>
Subject: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver and
 misc updates
Date: Wed, 12 Sep 2018 08:55:18 +0000
Message-ID: <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
References: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
In-Reply-To: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wesley Sheng <Wesley.Sheng@microchip.com>

1.add pre-requisites for NTB driver
2.misc updates
  change ntb hardware driver name to ntb_hw_switchtec
  update the description of 2 partitions limit
  add reference to Linux Documentation/ntb.txt
  add use of term 'Command ID'
  add use of term 'Command Return Value'
  add a missing ')'

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>
---
 Documentation/switchtec.txt | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt inde=
x f788264..40e839d 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec man=
agement firmware is  through the Memory-mapped Remote Procedure Call (MRPC)=
 interface.
 Commands are submitted to the interface with a 4-byte command  identifier =
and up to 1KB of command specific data. The firmware will -respond with a 4=
 bytes return code and up to 1KB of command specific
+respond with a 4-byte return code and up to 1KB of command specific
 data. The interface only processes a single command at a time.
=20
=20
@@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint=
 in the system.
 The char device has the following semantics:
=20
 * A write must consist of at least 4 bytes and no more than 1028 bytes.
-  The first four bytes will be interpreted as the command to run and
-  the remainder will be used as the input data. A write will send the
+  The first 4 bytes will be interpreted as the Command ID and the =20
+ remainder will be used as the input data. A write will send the
   command to the firmware to begin processing.
=20
 * Each write must be followed by exactly one read. Any double write will @=
@ -45,9 +45,9 @@ The char device has the following semantics:
   produce an error.
=20
 * A read will block until the firmware completes the command and return
-  the four bytes of status plus up to 1024 bytes of output data. (The
-  length will be specified by the size parameter of the read call --
-  reading less than 4 bytes will produce an error.
+  the 4-byte Command Return Value plus up to 1024 bytes of output =20
+ data. (The length will be specified by the size parameter of the read =20
+ call -- reading less than 4 bytes will produce an error.)
=20
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
@@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
 Non-Transparent Bridge (NTB) Driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-An NTB driver is provided for the switchtec hardware in switchtec_ntb.
-Currently, it only supports switches configured with exactly 2 -partitions=
. It also requires the following configuration settings:
+An NTB hardware driver is provided for the switchtec hardware in=20
+ntb_hw_switchtec. Currently, it only supports switches configured with=20
+exactly 2 NT partitions and zero or more non-NT partitions. It also=20
+requires the following configuration settings:
=20
-* Both partitions must be able to access each other's GAS spaces.
+* Both NT partitions must be able to access each other's GAS spaces.
   Thus, the bits in the GAS Access Vector under Management Settings
   must be set to support this.
+* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
+  to be set)
+
+NT EP BAR 2 will be dynamically configured as a Direct Window, and the=20
+configuration file does not need to configure it explicitly.
+
+Please refer to Documentation/ntb.txt in Linux source tree for an=20
+overall understanding of the Linux NTB stack. ntb_hw_switchtec works as=20
+an NTB Hardware Driver in this stack.
