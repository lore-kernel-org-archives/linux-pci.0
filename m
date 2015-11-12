Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:3390 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbKLSVG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 13:21:06 -0500
From: jharg93@gmail.com
To: systemd-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Network/Block device PCI Slot map utility
Date: Thu, 12 Nov 2015 12:04:31 -0600
Message-Id: <1447351472-25999-1-git-send-email-jharg93@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've developed a script that will display useful information for all block
and network devices.  It displays the PCI slot number, SR-IOV physical device,
model/vendor, driver, and NIC port number. The script will also display the 
bay and slot number for installed Dell PCIe-SSDs.

The script requires ipmitool and biosdecode utilities.

Examples:
===== sda
  Device: /sys/devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0
  Vendor: ATA    
  Model: ST3500630NS    
  Driver: ata_piix
===== sdb
  Device: /sys/devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4:1.0/host14/target14:0:0/14:0:0:0
  Vendor: Verbatim
  Model: STORE N GO     
  Driver: usb_storage
===== sr0
  Device: /sys/devices/pci0000:00/0000:00:1f.2/host1/target1:0:0/1:0:0:0
  Vendor: Optiarc
  Model: DVD+-RW AD-5560A
  Driver: ata_piix
===== eth0
  Device: /sys/devices/pci0000:00/0000:00:19.0
  Driver: e1000e
===== eth1
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0
  Driver: e1000e
  Slot Entry 9: ID 01:00, slot number 10
  PORT: 1
===== eth2
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.1
  Driver: e1000e
  Slot Entry 9: ID 01:00, slot number 10
  PORT: 2


another system:
===== sda
  Device: /sys/devices/pci0000:00/0000:00:02.2/0000:02:00.0/host0/target0:2:0/0:2:0:0
  Vendor: DELL   
  Model: PERC H710P     
  Driver: megaraid_sas
  0000:02:00.0 Label: Integrated RAID                        
  0000:02:00.0 SMBIOS Index: 4
===== eno1
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p1_1
  0000:01:00.0 Label: NIC1
  0000:01:00.0 ACPI Index: 1
===== eno2
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.1
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p2_1
  0000:01:00.1 Label: NIC2
  0000:01:00.1 ACPI Index: 2
===== eno3
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.2
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p3_1
  0000:01:00.2 Label: NIC3
  0000:01:00.2 ACPI Index: 3
===== eno4
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.3
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p4_1
  0000:01:00.3 Label: NIC4
  0000:01:00.3 ACPI Index: 4
===== eno5
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.4
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p1_2
  0000:01:00.4 Label: NIC5
  0000:01:00.4 ACPI Index: 5
===== eno6
  Device: /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.5
  DevPort: 0
  Driver: bnx2x
  DCM: 1001009d7F1402009d7F2101009d7F2502009d7F32010089154301008915
    p2_2
  0000:01:00.5 Label: NIC6
  0000:01:00.5 ACPI Index: 6
===== enp4s0
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.1
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f1d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.1
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f2
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.2
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f2d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.2
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f3
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.3
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f3d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.3
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f4
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.4
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f4d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.4
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f5
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.5
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f5d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.5
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f6
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.6
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f6d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.6
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f7
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.7
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s0f7d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.7
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:01.0
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 0
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 1
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp4s1d1
  Device: /sys/devices/pci0000:00/0000:00:03.0/0000:04:01.0
  PhysFn: /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
  DevPort: 1
  Driver: mlx4_core
  Level: 1   Slot Entry 15: ID 04:00, slot number 3
  PORT: 2
  DCM: 10010000C520010000C5
    p1_1
    p2_1
  0000:00:03.0 Label: SLOT 3
  0000:00:03.0 ACPI Index: 17
===== enp68s0f0
  Device: /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:02.0/0000:44:00.0
  DevPort: 0
  Driver: igb
  Level: 3   Slot Entry 17: ID 42:00, slot number 2
  PORT: 1
  0000:40:03.0 Label: SLOT 2
  0000:40:03.0 ACPI Index: 21
===== enp68s0f1
  Device: /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:02.0/0000:44:00.1
  DevPort: 0
  Driver: igb
  Level: 3   Slot Entry 17: ID 42:00, slot number 2
  PORT: 2
  0000:40:03.0 Label: SLOT 2
  0000:40:03.0 ACPI Index: 21
===== enp69s0f0
  Device: /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:04.0/0000:45:00.0
  DevPort: 0
  Driver: igb
  Level: 3   Slot Entry 17: ID 42:00, slot number 2
  PORT: 3
  0000:40:03.0 Label: SLOT 2
  0000:40:03.0 ACPI Index: 21
===== enp69s0f1
  Device: /sys/devices/pci0000:40/0000:40:03.0/0000:42:00.0/0000:43:04.0/0000:45:00.1
  DevPort: 0
  Driver: igb
  Level: 3   Slot Entry 17: ID 42:00, slot number 2
  PORT: 4
  0000:40:03.0 Label: SLOT 2
  0000:40:03.0 ACPI Index: 21

diff --git a/pslots.sh b/pslots.sh
new file mode 100755
index 0000000..2b383c7
--- /dev/null
+++ b/pslots.sh
@@ -0,0 +1,140 @@
+#!/bin/bash
+# Copyright (c) 2015 Dell Inc.  All Rights Reserved
+#
+# This code is released under LGPL license
+#
+# Display PCI slots for block and network devices
+# Display bay/ID for SSD devices
+declare -A dcmap
+
+function dcm()
+{
+    p=$1
+    dcm=$2
+    odcm=$2
+    dev=0x${p:8:2}
+    fun=0x${p:11:2}
+    sbd=${p:0:11}
+    pfunc=$((dev * 8 + fun))
+    
+    while [ ! -z $dcm ] ;do
+	port=${dcm:0:1}
+	func=0x${dcm:1:1}
+	pfi=0x${dcm:2:2}
+	flag=0x${dcm:4:6}
+	dcmap[$sbd${dcm:1:1}]=$odcm
+	if [ $((func)) = $((pfunc)) ] ; then
+	    echo "    p${port}_$((pfi))"
+	fi
+	dcm=${dcm:10}
+    done
+}
+for Y in /sys/block/* /sys/class/net/* ; do
+    RN=$(basename $Y)
+    if [ ! -e $Y/device ] ; then
+	continue
+    fi
+    RY=$(readlink -f $Y/device)
+    echo ===== $RN
+    echo "  Device: $RY"
+    if [ -e $RY/physfn ] ; then
+	RY=$(readlink -f $RY/physfn)
+	echo "  PhysFn: $RY"
+    fi
+    if [ -e $Y/dev_port ] ; then
+	DEVPORT=$(cat $Y/dev_port)
+	echo "  DevPort: $DEVPORT"
+    fi
+    FLAG=""
+    if [ -e $RY/vendor -a -e $RY/model ]; then
+	echo -n "  Vendor: "
+	cat $RY/vendor
+	echo -n "  Model: "
+	cat $RY/model
+    fi
+    BP=""
+    while [ "x$RY" != "x/" ]; do
+	P=$(basename $RY)
+	if [ -e $RY/driver/module -a $((FLAG & 0x100)) == $((0x00)) ] ; then
+	    RM=$(readlink -f $RY/driver/module)
+	    MOD=$(basename $RM)
+	    echo "  Driver: $MOD"
+	    FLAG=$((FLAG | 0x100))
+	fi
+	# Only handle PCI devices
+	if [ ! -e $RY/config ] ; then
+	    RY=$(dirname $RY)
+	    continue
+	fi
+	SEG=${P:0:4}
+	BUS=0x${P:5:2}
+	DEV=0x${P:8:2}
+	FUN=0x${P:11:1}
+	if [ -z "$BP" ] ; then
+	    BP="$((SEG)):$((BUS)):$((DEV)).$((FUN))"
+	fi
+	BUSDEV=${P:5:5}
+	if [ -e /usr/sbin/biosdecode ] ; then
+	    BDSLOT=$(biosdecode | grep "$BUSDEV.*slot" | sed -n "s/^\s*/  /p")
+	    if [ ! -z "$BDSLOT"  ] ; then
+		echo "$BDSLOT"
+		PORT=""
+		case "$BP" in
+		    "$((SEG)):$((BUS+2)):0.0"|"$((SEG)):$((BUS)):0.0")
+			PORT=$((1+DEVPORT))
+			;;
+		    "$((SEG)):$((BUS+2)):0.1"|"$((SEG)):$((BUS)):0.1")
+			PORT=2
+			;;
+		    "$((SEG)):$((BUS+3)):0.0"|"$((SEG)):$((BUS)):0.2")
+			PORT=3
+			;;
+		    "$((SEG)):$((BUS+3)):0.1"|"$((SEG)):$((BUS)):0.3")
+			PORT=4
+			;;
+		esac
+		echo "  PORT: $PORT"
+	    fi
+	fi
+	CLS=$(cat $RY/class)
+	if [ $((CLS & 0xF0000)) == $((0x20000)) -a -e $RY/vpd ] ; then
+	    DCM=${dcmap[$P]}
+	    if [ -z $DCM ] ; then
+		DCM=$(lspci -vvvv -s $P | sed -n "s/.*DCM//p")
+		dcmap[$P]=$DCM;
+	    fi
+	    echo "  DCM: $DCM"
+	    dcm $P $DCM
+	fi
+	if [ $((CLS & 0xF0000)) == $((0x10000)) ] ; then
+	    # Storage device, get bay mapping
+	    if [ -e /dev/ipmi -o -e /dev/ipmi0 ] ; then
+                MAP=$(ipmitool raw 0x30 0xd5 0x01 0x07 0x06 0x00 0x00 0x00 $BUS 0x00 2> /dev/null)
+                if [ "$MAP" != "" ] ; then
+                    BAY=$(echo $MAP | cut -f8 -d' ')
+                    SLOT=$(echo $MAP | cut -f9 -d' ')
+                    if [ $BAY != "fe" ] ; then  
+                        echo "  $P SSD bay:$BAY slot:$SLOT"
+                    fi
+                fi
+	    fi
+	fi
+	if [ -e $RY/label -a $((FLAG & 0x1)) == $((0x00)) ] ; then
+	    echo -n "  $P Label: "
+	    cat $RY/label
+	    FLAG=$((FLAG | 0x1))
+	fi
+	if [ -e $RY/acpi_index -a $((FLAG & 0x2)) == $((0x00)) ] ; then
+	    echo -n "  $P ACPI Index: "
+	    cat $RY/acpi_index
+	    FLAG=$((FLAG | 0x2))
+	fi
+	if [ -e $RY/index -a $((FLAG & 0x4)) == $((0x00)) ] ; then
+	    echo -n "  $P SMBIOS Index: "
+	    cat $RY/index
+	    FLAG=$((FLAG | 0x4))
+	fi
+	RY=$(dirname $RY)
+    done
+done
+
