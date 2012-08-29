Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:33083 "EHLO tjworld.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752284Ab2H2M5F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Aug 2012 08:57:05 -0400
Received: from [10.254.251.51] (unknown [10.254.251.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tjworld.net (Postfix) with ESMTPSA id E8C251ADD5
	for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2012 13:50:47 +0100 (BST)
Message-ID: <503E1027.6050104@iam.tj>
Date: Wed, 29 Aug 2012 13:50:47 +0100
From: TJ <tj@iam.tj>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Limiting BAR resource  region size allocation (device claims 2x what
 it needs) ?
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is there a way to over-ride a device's BAR region-size allocation? I've been looking but the only way I can identify is via a quirk.

I'm dealing with a Nvidia GeForce Go 7600 (NV8B) in a Sony Vaio VGN-FE41Z laptop. The device requests and is assigned a VRAM window of 256MB. However, there is only 128MB of physical VRAM.

>From my research it seems that some versions of the Go 7600 did have 256MB VRAM and the device is programmed
to request that regardless of the physically installed VRAM.

Combined with other PCI devices in the system the assignment of a 256MB window means that maximum RAM in the laptop is severely limited.

The CPU is 64-bit but the i945PM northbridge is 32-bit (so no physical > 4GB addressing). With PCI allocations as they are the system is limited to 2GB of RAM under Linux (3GB on Windows Vista).


$ sudo lspci -vnn -s 01:00.0
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G73 [GeForce Go 7600] [10de:0398] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Sony Corporation Device [104d:81ef]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
	Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Memory at d4000000 (64-bit, non-prefetchable) [size=16M]
	I/O ports at 2000 [disabled] [size=128]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [78] Express Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting <?>
	Kernel driver in use: nvidia
	Kernel modules: nvidia_current_updates, nouveau, nvidiafb
