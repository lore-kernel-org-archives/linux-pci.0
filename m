Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9C14EC73;
	Mon, 17 Aug 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947738; cv=none; b=svX3CTGFmTmnqTJWNyacQEAmi1UZ5Yc1KsTJkoDCtf9U2YsLx+E0YqjkdZLIZR+mT+GeabPSbwr8k7hNCmgukE9Qo/C//PHehBSwzBajqBXnyxqBbC7N+shmKBEx4QdRyKqvEmQAyzduOdNcd6Gqn7Ng52f0VTOqKJKay7krLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947738; c=relaxed/simple;
	bh=6Lgr8xRQ+6xzzv/cjQ69v/jvlkaLitBPKhUtSNzrrLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjrSTVG0U4Ot6PgMaIbbt8AWICgKPlWBU3Utvx+zp4HWtT9KieWr8M+XyB/ZJOS3/GVBCnJWOQPIQGYuuYpYQHW/tVocjZ3HZ8mBpfcerTLo8sgVqKJc7xxOs6K74AljbVLoFbBbdFAc4rkOsiP/qB0wlq1NMuSSIMbJeVNOEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YKM2IvxS; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YKM2IvxS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MuMGa3SyppeZShnnXxnfgoHm66+/yzbcXJodp0rzoHo=;
	b=YKM2IvxSR30I4BKWa/mBX9BuMN0bnzmco/vDlmFi7NVFrp4shJLlt166kJnplMx+4Hf4IyKQH
	I48V+DC98C8JHyNk+CNQNJlOvPP0wM5hxOehPrz7iG4UcD09W0edrQTob7FZ8nS9udAaeWrzmBc
	rqiSVBAAX8Yg1E/803TfERo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hNjCS5j2mz12LDl;
	Mon, 17 Aug 2026 14:11:48 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 223E22025F;
	Mon, 17 Aug 2026 14:22:11 +0800 (CST)
Received: from [100.103.108.70] (100.103.108.70) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 14:22:10 +0800
Message-ID: <14cd77b6-5541-4134-af52-62fb1d3664a0@huawei.com>
Date: Mon, 17 Aug 2026 14:22:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING] PCI: Fix procfs PCI config access issues
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260730032438.1643450-1-duziming2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/7/30 11:24, Ziming Du 写道:
> Hi,
>
> As suggested by Bjorn and Krzysztof, this series aligns the procfs PCI
> configuration access implementation with its sysfs counterpart and fixes
> issues found while reviewing the two paths.
>
> The first four patches fix the offset truncation, inode size update race,
> missing driver-exclusive resource warning, and unnecessary runtime PM
> operations at the end of sysfs configuration space. The final two
> patches align the procfs read and write implementations with their sysfs
> counterparts.
>
> Changes from v1:
>    - Merge the read and write offset fixes and move them before the
>      refactoring to avoid an intermediate signed/unsigned regression.
>    - Serialize i_size_write() with the inode lock.
>    - Add the driver-exclusive resource warning to procfs writes.
>    - Avoid unnecessary runtime PM get/put when sysfs config access starts at EOF.
>
> Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
> Link: https://lore.kernel.org/linux-pci/20260414024544.2975605-1-duziming2@huawei.com/
> Link: https://sashiko.dev/#/patchset/20260414024544.2975605-1-duziming2%40huawei.com
>
>
> Ziming Du (6):
>    PCI: Prevent overflow in proc_bus_pci_{read,write}()
>    PCI/proc: Serialize config inode size updates
>    PCI/proc: Warn on writes to driver-exclusive config regions
>    PCI/sysfs: Avoid runtime PM at config-space EOF
>    PCI: Align proc_bus_pci_write() with pci_write_config()
>    PCI: Align proc_bus_pci_read() with pci_read_config()
>
>   drivers/pci/pci-sysfs.c |   4 +-
>   drivers/pci/proc.c      | 124 +++++++++++++++++++++-------------------
>   2 files changed, 68 insertions(+), 60 deletions(-)

Hi,

Gentle ping on this patch.

Thanks

Ziming

