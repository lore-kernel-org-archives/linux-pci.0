Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:49369 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab3B0Kjz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 05:39:55 -0500
Received: by mail-ve0-f175.google.com with SMTP id cy12so384128veb.34
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2013 02:39:54 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 27 Feb 2013 16:09:54 +0530
Message-ID: <CAGZFCEFFPqVZ29e7_Bm_Xehw50W-D8K2B=CaXs6VkyDKQmCTvw@mail.gmail.com>
Subject: pcie error
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: e1000-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am getting  an error when i send traffic thru 8086:10e6 device

+------ PCI-Express Device Error ------+
Error Severity          : Uncorrected (Non-Fatal)
PCIE Bus Error type     : Transaction Layer
Completion Timeout      : Multiple
Requester ID            : 0028
VendorID=8086h, DeviceID=d13ah, Bus=00h, Device=05h, Function=00h
igb: ge1_0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
igb: ge1_1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX

I have added output of lspci -m and  lspci -vvt .

1. How can we confirm this is s/w or hw problem ?
2. Any clue or hint on how to debug is really appreciated  ?


bash-3.2# lspci -m
00:00.0 "Class 0600" "Vendor 8086" "Device d130" -r11 "Unknown vendor
105b" "Device 0d61"
00:03.0 "Class 0604" "Vendor 8086" "Device d138" -r11 "" ""
00:05.0 "Class 0604" "Vendor 8086" "Device d13a" -r11 "" ""
00:08.0 "Class 0880" "Vendor 8086" "Device d155" -r11 "Unknown vendor
005b" "Device 0061"
00:08.1 "Class 0880" "Vendor 8086" "Device d156" -r11 "Unknown vendor
005b" "Device 0061"
00:08.2 "Class 0880" "Vendor 8086" "Device d157" -r11 "Unknown vendor
005b" "Device 0061"
00:08.3 "Class 0880" "Vendor 8086" "Device d158" -r11 "Unknown vendor
005b" "Device 0061"
00:10.0 "Class 0880" "Vendor 8086" "Device d150" -r11 "Unknown vendor
005b" "Device 0061"
00:10.1 "Class 0880" "Vendor 8086" "Device d151" -r11 "Unknown vendor
005b" "Device 0061"
00:1a.0 "Class 0c03" "Vendor 8086" "Device 3b3c" -r06 -p20 "Unknown
vendor 105b" "Device 0d61"
00:1c.0 "Class 0604" "Vendor 8086" "Device 3b42" -r06 "" ""
00:1c.4 "Class 0604" "Vendor 8086" "Device 3b4a" -r06 "" ""
00:1c.5 "Class 0604" "Vendor 8086" "Device 3b4c" -r06 "" ""
00:1d.0 "Class 0c03" "Vendor 8086" "Device 3b34" -r06 -p20 "Unknown
vendor 105b" "Device 0d61"
00:1e.0 "Class 0604" "Vendor 8086" "Device 244e" -ra6 -p01 "" ""
00:1f.0 "Class 0601" "Vendor 8086" "Device 3b16" -r06 "Unknown vendor
105b" "Device 0d61"
00:1f.2 "Class 0104" "Vendor 8086" "Device 2822" -r06 "Unknown vendor
105b" "Device 0d61"
00:1f.3 "Class 0c05" "Vendor 8086" "Device 3b30" -r06 "Unknown vendor
105b" "Device 0d61"
01:00.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:01.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:03.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:05.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:07.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:09.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:0b.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:0d.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
02:0f.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
03:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
04:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
05:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
06:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
07:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
08:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
09:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
0a:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
0b:00.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
0c:04.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
0c:05.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
0c:08.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
0c:09.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
0e:00.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
0f:01.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
0f:02.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
10:00.0 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown vendor
1374" "Device 0b60"
10:00.1 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown vendor
1374" "Device 0b60"
11:00.0 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown vendor
1374" "Device 0b60"
11:00.1 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown vendor
1374" "Device 0b60"
12:00.0 "Class 0b40" "Vendor 1000" "Device 0a05" -r01 "Unknown vendor
1000" "Device 0a09"
14:00.0 "Class 1000" "Vendor 177d" "Device 0010" -r01 "Unknown vendor
177d" "Device 0001"
15:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor 8086"
"Device 0000"
16:00.0 "Class 0604" "Vendor 1a03" "Device 1150" -r02 "" ""
17:00.0 "Class 0300" "Vendor 1a03" "Device 2000" -r10 "Unknown vendor
1a03" "Device 2000"


bash-3.2# lspci -tvv
-[0000:00]-+-00.0  Device 8086:d130
           +-03.0-[0000:01-0a]----00.0-[0000:02-0a]--+-01.0-[0000:03]----00.0
 Device 8086:10d3
           |
+-03.0-[0000:04]----00.0  Device 8086:10d3
           |
+-05.0-[0000:05]----00.0  Device 8086:10d3
           |
+-07.0-[0000:06]----00.0  Device 8086:10d3
           |
+-09.0-[0000:07]----00.0  Device 8086:10d3
           |
+-0b.0-[0000:08]----00.0  Device 8086:10d3
           |
+-0d.0-[0000:09]----00.0  Device 8086:10d3
           |
\-0f.0-[0000:0a]----00.0  Device 8086:10d3
           +-05.0-[0000:0b-13]----00.0-[0000:0c-13]--+-04.0-[0000:0d]--
           |
+-05.0-[0000:0e-11]----00.0-[0000:0f-11]--+-01.0-[0000:10]--+-00.0
Device 8086:10e6
           |                                         |
                        |                 \-00.1  Device 8086:10e6
           |                                         |
                        \-02.0-[0000:11]--+-00.0  Device 8086:10e6
           |                                         |
                                          \-00.1  Device 8086:10e6
           |
+-08.0-[0000:12]----00.0  Device 1000:0a05
           |                                         \-09.0-[0000:13]--
           +-08.0  Device 8086:d155
           +-08.1  Device 8086:d156
           +-08.2  Device 8086:d157
           +-08.3  Device 8086:d158
           +-10.0  Device 8086:d150
           +-10.1  Device 8086:d151
           +-1a.0  Device 8086:3b3c
           +-1c.0-[0000:14]----00.0  Device 177d:0010
           +-1c.4-[0000:15]----00.0  Device 8086:10d3
           +-1c.5-[0000:16-17]----00.0-[0000:17]----00.0  Device 1a03:2000
           +-1d.0  Device 8086:3b34
           +-1e.0-[0000:18]--
           +-1f.0  Device 8086:3b16
           +-1f.2  Device 8086:2822
           \-1f.3  Device 8086:3b30


Thanks,
Ratheesh
