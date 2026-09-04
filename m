Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C174EEC0;
	Fri,  4 Sep 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486759; cv=none; b=npkkg81rsx2tWkroMct8yn9xTGAE1U/087MlBkIijPJq4AVrM6hMmyOW5bV+0PgHKgNJPgankmTspf5OAmj6T66cqMiJr8HafZR/aswP8qRVmr9GZ0K0+0W8K0xe5MKToNgOFEYbFX7/L2nSBZR7dnAoMWC8sOt9GMsjtD3WFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486759; c=relaxed/simple;
	bh=qMalKVuw2639rIFfUlQr0XCtKmuI8muFcSe/U+MMVOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+DqKFBqaJxmmMzHOUuSeRWe4oyhmGhYx2ecPy8B7xy1AsZ7KXfQgJNN0YJwnZDSrBV++0iCFTwY8eZ+k2d/9V3fbtCiLZrYvnuOJ/9n37BS9QJRdYmek4FkKDzG5Qbfc5YuNkP2t/X3TeYsL+KvQPfAJ8khbh0l12DOjC2H10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=A2iZtDao; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="A2iZtDao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=wIeU/CAPcwgLsNLs2ubFoi1VzQXWi3sdNW
	oo9MSp7ro=; b=A2iZtDaoFDoGZD9fsv/9iiK1OnTQ1YFkyH886n357A+/2S2CKJ
	5Uac9e6E8hR49gH1CimnwnEB1x9Ck3kId8er0L9o7xbDuwTtDgPbJo3EOtejuVk3
	M03P+Nsz4UgHN3g0xGirrDexkU3ZkMOptN3Di8CrZHB/fT3Ox5W7OZIZw=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwD3vwZQJJpqujsAAA--.251S2;
	Fri, 04 Sep 2026 09:52:16 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	wangjia@ultrarisc.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
Date: Fri,  4 Sep 2026 09:51:34 +0800
Message-Id: <20260904015134.3740048-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <apmSiooxKzb9l-TB@ryzen>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com> <20260827055448.1818858-2-zhangxincheng@ultrarisc.com> <apmPeZEdanf80HVB@ryzen> <apmSiooxKzb9l-TB@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwD3vwZQJJpqujsAAA--.251S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF43tw17KFyrZF48XF4Dtwb_yoW8WFW3pa
	nrtFs5GFs7Jr1DAws7Aw1jva4Fka98Ja4kWr15GasYyrsI9F1xKFZ7Kw4j9a4UKrsYvrWj
	qayYqan7Xa1Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAADGqZGSQANwABs1

Hi Niklas,

On Thu, Sep 03, 2026 at 05:30:18PM +0200, Niklas Cassel wrote:
> Looking at dw_pcie_parent_bus_offset(), I can see that it already computes
> pci->parent_bus_offset correctly, regardless of pci->ops->cpu_addr_fixup and
> pci->use_parent_dt_ranges, so atu.parent_bus_addr will be set correctly.
>
> Thus, you can ignore 1).
>
> But 2) would still be very much needed.

Thanks for checking this.

Yes, I agree that the skipped MEM windows need an identity mapping check.
In v2 I will move the bypass decision until after calculating the same
outbound addresses used by the normal iATU programming path, and fail the
host init if a skipped MEM range is not identity-mapped:

	atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
	atu.pci_addr = entry->res->start - entry->offset;

	if (pp->bypass_ob_mem_iatu &&
	    atu.parent_bus_addr != atu.pci_addr)
		return -EINVAL;

This should prevent the driver from silently relying on no-match pass-through
when the DT "ranges" describe different parent-bus and PCI addresses.

For the databook reference, the relevant text I found is in the DWC PCIe RP
Controller Databook v6.00a, June 2022. Section 3.12.2 says the default
outbound no-match behavior is pass-through, and Section 3.12.5.6 "No Address
Match Result" says the address is not translated and programmable TLP header
information comes from the application transmit interface. I will cite those
RP Databook sections in the v2 commit message instead of referring to this
generically.

For DP1000, this remains MEM-only. CFG and I/O still use the normal DWC
outbound iATU programming path.

Thanks,
Xincheng

