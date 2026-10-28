Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153506;
	b=a7+uOLa6ZzKL7j0AI6o68dLnvcYeY191l30OxNqlj3kc1Wrh/EIdKyKn2LfD1X9GUUHI
	 gADYGozL0QCADwrgNZvKL8wUvIIQ3i/yEx5DhAjAioLcpPisuCcYZ3Xrvkj2x4+E+hrWq
	 UcUfnmr7EgMBPl2RkO+BPRm9eMns7ZUJb0ozX1JgAsMsJJb6KxiQgPbsLPst3LdNNZgYU
	 1LYjkfjrAQ5Koq3z64tavK+YW4AycgSkp3OAUVMjltdKYKfI802KhmNp+lKKUMDd2u7k/
	 xvC03jRFAt7BFSLHCWFZb2n+JYtnTGIaiwRW91C7tN7tp55u4YsAuL3JFUajgII5GNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153506;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=dRf6oI9OjFWY1cb4Veae1z+HSgCdbz4ogw7DjgHpwGM=;
	b=B09TjISVevEf+ZFWoDBxUpiiKD4DC1rPJJPHYbc+lnn8Zs/RuySCRWco4J/wkQSL+GZo
	 mJ8hJ/rcdyyU+2/C0UaaBCJ2oG+oeQEq/HbANMHkMafW9GyB1nDzlDixu0x9NpJSyE3b3
	 yrnazxT/6GtALSnhy8FA0pG+9xwtqlZU5TT0jRARWQfRsfoNaSiAU6aaLC8UzC0Zf1dzk
	 Q4UzHXD5NHpBkxodPL/SPozqPDvlCAk4nIe2p9k60QarouDD4SHNxo3/+8K6hNyI753hH
	 lVPKhVfXIq904xg+7vZnTlyqFhckOYG90liHYdPxwyr8F8J+B/C3FozAnw2SYQ8po4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYpt+RJw;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC69606A31D;
	Wed, 28 Oct 2026 02:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC69606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYpt+RJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=dRf6oI9OjFWY1cb4Veae1z+HSgCdbz4ogw7DjgHpwGM=;
	b=qYpt+RJwRCF0KX/+Je23SE2RJtdg8sWfRlTJBYkgQjazqIosKZrPy7BmiKqm9R
	lMeSBT6H/smy5N567aYskw3soxO2lZEjFu6+3moV22mJgNt2lfVoA1/U+RSmdIP+
	eNPBKt+kFxH/QXb7xPiQMm1mkDGc1IgvPyHBAIFAj2h4o=
Message-ID: <9a761c42-9edd-48f4-b3a4-c275b603cc3e@163.com>
Date: Wed, 28 Oct 2026 10:10:33 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] PCI: dwc: Cache PCIe capability offset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jingoohan1@gmail.com, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261027231534.GA520774@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20261027231534.GA520774@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD33x2jWeFqyfNqDQ--.48494S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DJr17Xr4kCw1xZw47urg_yoW8Xr4kpF
	Wjgrs2yF4kXrn2vanF93Wj93W7AF9Iy3y3CanxG34avr90vF4IgF40vrW3GF9Fyrs29r4a
	yFWjq3s8Gas8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4UDXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ASSNmrhWaRq6QAA35



On 10/28/26 07:15, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2026 at 08:28:11PM +0800, Hans Zhang wrote:
>> Hi,
>>
>> The DWC PCIe core and its platform drivers repeatedly call
>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>> PCI Express Capability structure, including in paths that run more than
>> once such as link polling, suspend/resume and interrupt handlers.
>>
>> Add a cached pcie_cap field to struct dw_pcie and a
>> dw_pcie_get_pcie_cap() helper that performs the lookup on first use and
>> caches the result, then convert the core and the 14 platform drivers
>> that use PCI_CAP_ID_EXP.
>>
>> After this series, dw_pcie_find_capability(..., PCI_CAP_ID_EXP) no
>> longer appears in drivers/pci/controller/dwc/ outside of the helper
>> itself.
>> ...
> 
>> base-commit: 4352b8aee98005853aa63f57d6377282de17a33f
> 
> This does indeed apply cleanly on 4352b8aee980 ("Merge tag
> 'i3c/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux"),
> but that's pretty old and not really useful any more.
> 
> PCI topic branches are typically based on -rc1, but of course v7.4-rc1
> hasn't been tagged.  Until it is, you can use pci/main as a good base.
> It's currently 17bb0e2f6c80 ("Merge tag 'pci-v7.4-changes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci"), so
> drivers/pci/ in v7.4-rc1 will be pretty close to that.

Hello Bjorn,

Will rebase on pci/main.

Best regards,
Hans


