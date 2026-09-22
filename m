Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5029DB8F;
	Tue, 22 Sep 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060688; cv=none; b=E+qgXzjvgEVmUwiQr0EgsgJSo0zAkkxWnc6dPdpbKbT6F3Ehkg8QYGONRvJW38pZsZ0SVYC3OBZX+OmoMLQLok6Bmv3tFJW6bszbFyVHpwWRCxN/895b2Pyo9iASLuyrUJWQPQOb/7KIZJWa5hPMg9djY6u79IqCk+C2OO6a67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060688; c=relaxed/simple;
	bh=Z3E5lc1PTQorPQUPtL6bvdZnJCqg4nY4rvs7dvyKDc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvMb44BTRgVbQsz3xtPt4kkcUv1XprtU6RMUNNmJsSBNixsDRjluRiV+UNTUHsaaVledchGxz2i1kzUjZdYNfzg9HkPboZmjrN9Xx2YHZDG6YaJejBmUBXfa+HCJ7a5aSQBj0opCyRwtXEYfJoO2wuhgaFr0TnJqm1ONwiEoIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MRTrO9WZ; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MRTrO9WZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZkAYMpRGGT5mfdQXD5v51hO8w1azifScBUGqLyRa5fY=;
	b=MRTrO9WZ0vI7NQorRpn5X1PUZtSYeR0LqcP4GqfKXB4Cs+rZABjA+aIBqRxkuhM1aUScmi596
	CdLY/AqBG8RwqpRxAAy81zY0oNpVxM+dVW1vym1FhkRXwzY70qiNqTIzaLrfOrWOQqJBUmzbiby
	t8N1YSFgVtvCVNkAIOQjTjA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hprR468qnzKm5t;
	Tue, 22 Sep 2026 14:53:36 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF364057A;
	Tue, 22 Sep 2026 15:04:42 +0800 (CST)
Received: from huawei.com (10.50.85.180) by dggpemr500010.china.huawei.com
 (7.185.36.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 15:04:42 +0800
From: Hongtao Zhang <zhanghongtao35@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Alex Williamson <alex.williamson@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Dan
 Williams <djbw@kernel.org>, Keith Busch <kbusch@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<zhangqiuhao@huawei.com>
Subject: Re: PCI: Prevent device lock leak during bus reset
Date: Tue, 22 Sep 2026 15:23:19 +0800
Message-ID: <20260922072319.366662-1-zhanghongtao35@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821021626.1874602-1-zhanghongtao35@huawei.com>
References: <20260821021626.1874602-1-zhanghongtao35@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500010.china.huawei.com (7.185.36.210)

Hi Bjorn,

Gentle ping on this RFC.

Sashiko's review points out that pci_try_reset_bus(), pci_slot_reset()
and pci_try_reset_slot() have the same problem, since
__pci_bus_trylock(), __pci_bus_lock() and __pci_bus_unlock() also walk
bus->devices independently for locking and unlocking. This matches the
limitation I noted in the commit message.

The review also mentions a possible use-after-free. In those unpatched
paths, bus->devices is walked without pci_bus_sem and without taking
device references, so a device removed and freed concurrently could be
accessed during the walk. With the snapshot approach this is avoided:
the snapshot is taken under pci_bus_sem, a reference is held on every
device in it, and both locking and unlocking use only the snapshot. A
removed device therefore cannot be freed until the reset completes.

Before extending this to the other paths, I would like to confirm the
direction. I see two options:

1. Extend the snapshot approach to the slot and try-reset paths. The
   change stays small and local, but a device added after the snapshot
   may still be reset without its device lock held.

2. Prevent topology changes for the whole reset. This would also cover
   devices added after the snapshot, but it needs a lock held across the
   reset and care to avoid deadlocks with hotplug and AER recovery.

I lean towards option 1 as a fix that is easier to backport, with
option 2 possibly done separately later. Does that sound reasonable, or
should I go with option 2 directly?

Thanks,
Hongtao
