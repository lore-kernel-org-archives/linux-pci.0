Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61739EF20
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439378; cv=none; b=WjT+96R5GhzmBVxoCXYHJhftY8hrDmzORCFf30mT9Z+PV+wMK7XP3VYoDFlBinr/+36zYeCmHjsTOMDXYX/KrJ6BndSDHZH2tOtttNiykhT1idWuUq7NZ3vKqVlKYsKPj3yvwXbe0IWL1zm6Y89QUMeaBbrIy5A7iP90ct5xIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439378; c=relaxed/simple;
	bh=h5+6/hTEiiROo/+KYwNBSRYtleRKGIqIJfdcSxQXWBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZv3RUT2Stq6V7w0DVepFUIverlL0/1kpzaA97ghNdy3//M7j0xN8d/ffH7LHFbY3FD76/oCzzvAMiWNTj0dOnAfmJAhwWlD5V3ZqjSZAbZj+CHu4m+ySOp2DRMkGZpi6eeNJtGmlFho9il/8TU4w0cThtHzzU7LX9iyF5iKRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: ogMsE0/UT+akg39KRVgBWg==
X-CSE-MsgGUID: MyshvjDAShmZJTqKVHhHJw==
X-IronPort-AV: E=Sophos;i="6.24,162,1774281600"; 
   d="scan'208";a="150371211"
From: weipengliang <weipengliang@xiaomi.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Frederic Weisbecker" <frederic@kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, Uwe
 Kleine-Konig <u.kleine-koenig@baylibre.com>, Samiullah Khawaja
	<skhawaja@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <weipengliang@xiaomi.com>
Subject: Re: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 16:42:44 +0800
Message-ID: <20260522084244.1844-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <ahANoSZXPFUX3HaR@wunner.de>
References: <ahANoSZXPFUX3HaR@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX17.mioffice.cn (10.237.8.137) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

Hi Lukas,

I just received AI review feedback from sashiko.dev on this patch:
https://sashiko.dev/#/patchset/20260522075453.473-1-weipengliang@xiaomi.com?part=1

The reviewer raised a concern about enabling CPU hotplug before
flush_work():

  Does enabling CPU hotplug before flush_work() defeat the
  protection for the actual probe execution?

  If the targeted CPU goes offline while flush_work() is waiting,
  the workqueue core might unbind the worker pool and migrate the
  pending probe work. Because unbound workers fall back to
  cpu_possible_mask, the probe might execute on an incorrect NUMA
  node or an isolated CPU, violating the housekeeping_cpumask
  constraints evaluated earlier.

Given this, I think it's better to place cpu_hotplug_enable() after
destroy_work_on_stack() at the end of the else block. This keeps
hotplug disabled during both flush_work() and local_pci_probe(),
while the extra time during destroy_work_on_stack() is negligible.
I'll update v3 accordingly.

Thanks,
weipengliang
