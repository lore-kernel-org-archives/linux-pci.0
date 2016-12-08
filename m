Return-Path: <SRS0=t3+i=XX=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=t3+i=XX=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	"Janusz.Dziedzic@tieto.com" <Janusz.Dziedzic@tieto.com>,
	"rmanohar@qti.qualcomm.com" <rmanohar@qti.qualcomm.com>
Subject: ATH9 driver issues on ARM64 
Date: Thu, 8 Dec 2016 13:49:42 +0000
Message-ID: <8520D5D51A55D047800579B094147198263A7222@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi,

Did anyone test Atheros ATH9 driver(drivers/net/wireless/ath/ath9k/) on ARM=
64.=20
The end point is TP link wifi card with which supports only legacy interrup=
ts.

We are trying to test it on ARM64 with (drivers/pci/host/pcie-xilinx-nwl.c)=
 as root port.

EP is getting enumerated and able to link up.=20

But when we start scan system gets hanged.

When we took trace we see that after we start scan assert message is sent b=
ut=20
there is no de assert from end point.

What might cause end point not sending de assert ?

We are not seeing any issues on 32-bit ARM platform and X86 platform.=20
=20
Regards,
Bharat
