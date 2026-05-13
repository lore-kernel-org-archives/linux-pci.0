Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA143EAC7D;
	Wed, 13 May 2026 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662573; cv=none; b=f9JW74Jl4RpqLJcHDYzRZv5cKkMJNrBdtNFIEs15KhlW15kgq8p9JzlxlWEOSzRyJZuHL8YmCoEekKtLbfbimHnQxplsPHR4Q6QGohIgIXIIEoncEOyqjLnZBDHRTNAwTTn2HoHWprHWdwBSB371/UHy9YK2trX9AcRodhAn2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662573; c=relaxed/simple;
	bh=wuUUBQQRuG1VYstcHp6MSrz3V15BY+9+Ao+GmTZWAkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4YLBZgjhXRvQJXS+FcNeTu8s3qnwwtDFTs+1cRpyr5i4YH3IIuHrqKND+cJiTmtPrylfKng5CJbfKhOuAXpJjbHz2ATqiDExsRfSe1tQkLSOJqlfzVecdd21O/DpZliqRvy5LCObo9mRTQri8pa856l+DVhHSzq28b/CQNv+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kf4yr/gn; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kf4yr/gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UN3Z5L7nRQfH/ogvS8T1PV/ft+JZKvMmgkqHqbwEuD8=;
	b=kf4yr/gnSYut4WdjsFAJMfEIQCuqBoUZidRq+f9NU67OvH2+N8YOx/In2rTnJ2
	+Ym6a9IU2I7lNlu/TqvGG+gtpsmS04G82g/qzTfIUUjPjtjLyn7Y5Sr2Mrk4hOuS
	x81LiDJNLsiRr0C+Z9ZN6jRlFcQ7xJ/3jav+JaAhGNfMs=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHNDmJPARqVa2DBA--.18649S2;
	Wed, 13 May 2026 16:55:38 +0800 (CST)
Message-ID: <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
Date: Wed, 13 May 2026 16:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Aksh Garg <a-garg7@ti.com>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>,
 "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
 <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHNDmJPARqVa2DBA--.18649S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1kKr4xXw47Cw4rWryUKFg_yoW8Zw48pa
	y5GF1FkF15ZrWjv3ZFyF15XryYyrn8Aay3C3ykK34rWa42qr90qrs2kryFqFsxGFWqyw4a
	ka1Fyry3Aa4Yy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ArMcGoEPIoDDQAA3M



On 5/13/26 16:34, Aksh Garg wrote:

>>>
>>
>> The above LTSSM states are internal LTSSM encoding states and may not 
>> be available for software to use.
>> The LTSSM states in the document pointed by Aksh (TI Soc) are the 
>> states  available in all cadence controllers.
> 
> Is this true for HPA IPs as well? The test performed by Hans:
> root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
> L0_STATE (0x29)
> L0_STATE (0x29)
> L0_STATE (0x29)
> 
> This implies that the L0_STATE LTSSM state is mapped to 0x29 (41) there,
> which according to your response is internal LTSSM encoding, and hence
> the register read should have resulted in 0x10 instead of 0x29.
> 

Hi Aksh,


For HPA, my view is similar to that of DWC - it requires a common 
internal LTSSM state. For each of its own Root Port drivers, a callback 
can be used to implement the reading of LTSSM. This part can be referred 
to as the implementation of the function in DWC.


static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
{
	u32 val;

	if (pci->ops && pci->ops->get_ltssm)
		return pci->ops->get_ltssm(pci);

	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);

	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
}


static int ltssm_status_show(struct seq_file *s, void *v)
{
	struct dw_pcie *pci = s->private;
	enum dw_pcie_ltssm val;

	val = dw_pcie_get_ltssm(pci);
	seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);

	return 0;
}



For example, it can be modified as follows. Of course, the function name 
will start with "cdns".

For LGA IP, currently we will allow each Root Port driver to implement 
the corresponding ops::get_ltssm() by itself.

static int ltssm_status_show(struct seq_file *s, void *v)
{
	struct dw_pcie *pci = s->private;
	enum dw_pcie_ltssm val;

	if (pci->ops && pci->ops->get_ltssm)
		val = pci->ops->get_ltssm(pci);
	else
		val = dw_pcie_get_ltssm(pci);
	seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);

	return 0;
}


Best regards,
Hans

