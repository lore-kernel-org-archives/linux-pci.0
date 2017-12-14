Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from libmpq.org ([85.25.94.4]:37042 "EHLO mail.libmpq.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753742AbdLNSy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 13:54:28 -0500
Received: from libmpq.org (bart.theraso.int [172.16.50.100])
        by mail.libmpq.org (Postfix) with ESMTPSA id 6F27C38CC18
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2017 19:47:01 +0100 (CET)
Date: Thu, 14 Dec 2017 19:47:01 +0100
From: Maik Broemme <mbroemme@libmpq.org>
To: linux-pci <linux-pci@vger.kernel.org>
Subject: ASPM powersupersave change NVMe SSD Samsung 960 PRO capacity to 0
 and read-only
Message-ID: <20171214184701.GA6322@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a Samsung 960 PRO NVMe SSD (Non-Volatile memory controller:
Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961). It
works fine until I enable powersupersave via
/sys/module/pcie_aspm/parameters/policy

ASPM is enabled in BIOS and works fine for all devices and in
powersave mode. I'm able to reproduce this always at any time while
the system is up and running via:

$> echo powersupersave > /sys/module/pcie_aspm/parameters/policy

The Linux kernel is 4.14.4 and APST for my device is working with
powersave. As soon as I enable powersupersave I get:

[11535.142755] dpc 0000:00:10.0:pcie010: DPC containment event, status:0x1f09 source:0x0000
[11535.142760] dpc 0000:00:10.0:pcie010: DPC unmasked uncorrectable error detected, remove downstream devices
[11535.159999] nvme0n1: detected capacity change from 1024209543168 to 0
[11535.163502] print_req_error: I/O error, dev nvme0n1, sector 23072824
[11535.163545] EXT4-fs warning (device dm-1): ext4_end_bio:323: I/O error 10 writing to inode 404202 (offset 0 size 0 starting block 1703943)
[11535.163547] Buffer I/O error on device dm-1, logical block 1703943
[11535.163739] print_req_error: I/O error, dev nvme0n1, sector 94970176
[11535.163768] print_req_error: I/O error, dev nvme0n1, sector 1683511568
[11535.190820] blk_partition_remap: fail for partition 2
[11535.216636] blk_partition_remap: fail for partition 2
[11535.216673] blk_partition_remap: fail for partition 2
[11535.217870] blk_partition_remap: fail for partition 2
[11535.219894] nvme nvme0: failed to set APST feature (-19)
[11535.234716] blk_partition_remap: fail for partition 2
[11535.246037] blk_partition_remap: fail for partition 2
...
[11535.882960] blk_partition_remap: fail for partition 2
[11535.882962] blk_partition_remap: fail for partition 2
[11535.882966] Aborting journal on device dm-1-8.
[11535.883008] blk_partition_remap: fail for partition 2
[11535.883012] Buffer I/O error on dev dm-1, logical block 1081344, lost sync page write
[11535.883017] JBD2: Error -5 detected when updating journal superblock for dm-1-8.
[11535.883139] blk_partition_remap: fail for partition 2
[11535.883142] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
[11535.883151] EXT4-fs error (device dm-1): ext4_journal_check_start:61: Detected aborted journal
[11535.883157] EXT4-fs (dm-1): Remounting filesystem read-only
[11535.883161] EXT4-fs (dm-1): previous I/O error to superblock detected
[11535.883167] blk_partition_remap: fail for partition 2
[11535.883168] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
[11535.883219] blk_partition_remap: fail for partition 2
[11535.883226] blk_partition_remap: fail for partition 2
[11535.883263] systemd-journald[459]: Failed to create new system journal: Read-only file system

It looks like APST feature cannot be set anymore after enabling
powersupersave. Also the PCIe device disappears completely
from lspci output. Here is my nvme output before switching to
powersupersave:

root@server:~# nvme get-feature -f 0x0c -H /dev/nvme0
get-feature:0xc (Autonomous Power State Transition), Current value:0x000001
	Autonomous Power State Transition Enable (APSTE): Enabled
	Auto PST Entries	.................
	Entry[ 0]   
	.................
	Idle Time Prior to Transition (ITPT): 71 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 1]   
	.................
	Idle Time Prior to Transition (ITPT): 71 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 2]   
	.................
	Idle Time Prior to Transition (ITPT): 71 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 3]   
	.................
	Idle Time Prior to Transition (ITPT): 400 ms
	Idle Transition Power State   (ITPS): 4
	.................
	Entry[ 4]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 5]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 6]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 7]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 8]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[ 9]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[10]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[11]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[12]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[13]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[14]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[15]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[16]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[17]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[18]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[19]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[20]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[21]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[22]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[23]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[24]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[25]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[26]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[27]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[28]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[29]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[30]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
	Entry[31]   
	.................
	Idle Time Prior to Transition (ITPT): 0 ms
	Idle Transition Power State   (ITPS): 0
	.................
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0000: 18 47 00 00 00 00 00 00 18 47 00 00 00 00 00 00 ".G.......G......"
0010: 18 47 00 00 00 00 00 00 20 90 01 00 00 00 00 00 ".G.............."
0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"

Any idea why the device is failing with powersupersave and how to avoid
it? Especially how to enable it but skip certain broken devices as this
is my boot device.

--Maik
