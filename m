Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F733D4132
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831459; cv=none; b=oSVPLXAZv4gJBnIm4i3A8EESmdsq9jztbTvD8dEkj+krh9MgZUD2b1zu5O8wrV/xkM1+zwxuwqBeqQMZ7HJ1JHfAmZfSC5GplVNkT/SQFj9sN+p4o5mOOnZ2FbFlNqUvIbQGuL1osJXirL5OLu3+8tmQJsMViMwGUKmIzLIrIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831459; c=relaxed/simple;
	bh=9ON1tk+oIo2bDmwe3KNKCSkhrWQ21roSC1Pvw79LCjE=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=J/4teYqDUEw4wHopkLDU7RnAprlBv8paf3oHO+0RigiOxY1iOuWRWpLZ7be5pBH1Dm1OOJld3P8oiDGILY2fgEwFqaz1x6+/5VFr1/wN0MFAVyZNbcZhzhcL0DYh+9NwWsIO9FVMEy1I8hkuDyFTZxBL+eTg53t6HyEzaLAjcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QkyDLUjk; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QkyDLUjk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FUiqCT6Bg8Gd4OpnBctxPSZOCgZT2WgltssxjeFeTkA=;
	b=QkyDLUjk3Bl+sMlJAn3MTQr4EYb94yjp2y3WuxeAiO1RVmAfUZvgWgBrb8AVewbb9NUpTtIxT
	imxLd/EKXdRr4zLs212nwvOxdB/4YWiKh1eZa850zCcI4UIAy3koNig+kIaPdQzPNvQHW4wMTAQ
	14dRES/rbRRJC0Db+1LJxNM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fsfFh3JJHz1K973
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 22:24:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9835740563
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 22:30:53 +0800 (CST)
Received: from [10.82.79.57] (10.82.79.57) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Apr
 2026 22:30:53 +0800
Message-ID: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
Date: Fri, 10 Apr 2026 22:30:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>
From: fengchengwen <fengchengwen@huawei.com>
Subject: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi all,

I'm writing to propose adding a sysfs interface to expose and configure 
the PCIe TPH
Steering Tag for PCIe devices, which is retrieved inside the kernel.


Background: The TPH Steering Tag is tightly coupled with both a PCIe 
device (identified
by its BDF) and a CPU core. It can only be obtained in kernel mode. To 
allow user-space
applications to fetch and set this value securely and conveniently, we 
need a standard
kernel-to-user interface.


Proposed Solution: Add several sysfs attributes under each PCIe device's 
sysfs directory:
1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt 
or device specific)
2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write 
operations, e.g.:
    Read operation:
      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
    Write operation:
      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st


The design strictly follows PCI subsystem sysfs standards and has the 
following key properties:

1. Dynamic Visibility: The sysfs attributes will only be present for 
PCIe devices that
    support TPH Steering Tag. Devices without TPH capability will not 
show these nodes,
    avoiding unnecessary user confusion.

2. Permission Control: The attributes will use 0600 file permissions, 
ensuring only
    privileged root users can read or write them, which satisfies 
security requirements
    for hardware configuration interfaces.

3. Standard Implementation Location: The interface will be implemented in
    drivers/pci/pci-sysfs.c, the canonical location for all PCI device 
sysfs attributes,
    ensuring consistency and maintainability within the PCI subsystem.


Why sysfs instead of alternatives like VFIO-PCI ioctl:

- Universality: sysfs does not require binding the device to a special 
driver such as
   vfio-pci. It is available to any privileged user-space component, 
including system
   utilities, daemons, and monitoring tools.

- Simplicity: Both user-space usage (cat/echo) and kernel implementation are
   straightforward, reducing code complexity and long-term maintenance cost.

- Design Alignment: TPH Steering Tag is a generic PCIe device feature, 
not specific to
   user-space drivers like DPDK or VFIO. Exposing it via sysfs matches 
the kernel's
   standard pattern for hardware capabilities.


I look forward to your comments about this design before submitting the 
final patch.

Best regards,
Chengwen Feng
