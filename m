Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C93859EC;
	Fri,  1 May 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645211; cv=none; b=NmflJ5VitPWXBQ6UY70pp5CLrR8wtfVRkTf3nmDAfOd0DAGbSm+TJBHi/7u2814QnJnpPb33+UdD3BuJKRKttfWr+f7+gT/IqEhwrFZRrPEbpmQvsMkKIWgX6fuk3LIJbKQ5PnvwaQId41foPwy5zMM8fElmcfAFgKlBMoDGhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645211; c=relaxed/simple;
	bh=JCnm/2GDLCDtjMwG41oP7viMaz2X9zq00J/+NIv0J5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0ATUPLOGO5iJ2PE65WTw2O2YlreN67zzW2eAmjrC6r9Q+poGc9q6eths584qsJQRRx007xTsXUChDwY88Zl+jGdmJbgLSxncy1dTYDPx01MDQWnC3/XgLjZqEWOWxp5WMKuoEEfx6zuvSKaS0Pill3Bg3K0SBS4PjcKPyO+5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D5JfCbmY; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D5JfCbmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0RPn/xHG/LjhRwStUHz+Jbvvg1rwsjKyUE8xWaBuizE=;
	b=D5JfCbmYj9MJZqTP/WAh6WDbjzgCdmEXTBV8uW1vxl9E2S6FvX17O93oKFs22+
	J9JXFNt4ZO6SaYkNfDu4QW6X82wdagOdFc1KmjWxMEIrpxBcg5zMe0+LngEIB45+
	2YIF4axnCzXvb6X7vGhR/eSoZMnHsudJUEjfJwsFXKlAc=
Received: from [IPV6:240e:b8f:927e:5900:a6da:de99:5aab:66f2] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD38QNztvRpLYmECg--.48965S2;
	Fri, 01 May 2026 22:19:32 +0800 (CST)
Message-ID: <92fa1579-9c00-4d60-a916-1d2af1fb63ef@163.com>
Date: Fri, 1 May 2026 22:19:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 00/16] PCI: Use FIELD_MODIFY() to simplify bitfield
 operations
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org, s32@nxp.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430180857.GA421892@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260430180857.GA421892@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD38QNztvRpLYmECg--.48965S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr13Jr47ur4fXw17uF1rZwb_yoW5ZFWrpa
	y5JF4xZFWxtr4Y9anxAan8Ca4YvFnIyryUtayqg3srW3ZIvry7WrWUtayrGr93Ar4UWF13
	Kw4Ut343GFs3J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BRiBmn0tnSceQAA3m



On 5/1/26 02:08, Bjorn Helgaas wrote:
> On Fri, May 01, 2026 at 12:24:04AM +0800, Hans Zhang wrote:
>> Replace open-coded bitmask clear + FIELD_PREP() sequences with the
>> dedicated FIELD_MODIFY() macro.  FIELD_MODIFY() performs the same
>> operation but is shorter, less error-prone, and includes compile-time
>> checks to prevent field overflow.
>>
>> This series touches the PCI core, PCIe extended capabilities (PTM, IDE,
>> TPH, MSI, REBAR, IOV, CardBus), and several DesignWare-based and
>> other PCI host controllers.  No functional change is intended.
>>
>> The patches are split per subsystem or per driver to ease review:
> 
> A "resend" implies that this is the same series as posted earlier but
> forgotten for some reason.  But the original was only twelve minutes
> earlier, and this adds more instances.  This should be a "v2" with a
> note about what changed from the original posting.  In any event, I'll
> ignore the original posting in favor of this one.


Hi Bjorn,

Sorry.

Due to the fact that my development environment uses the 163 email 
service provided by China, the command "git send-email 
--no-chain-reply-to --quiet --to xxx --cc xxx" will not send the patches 
if there are more than 10 of them. Therefore, the following command 
needs to be executed: git send-email --no-chain-reply-to --quiet 
--batch-size=5 --relogin-delay=10 --to xxx --cc xxx. This way, you can 
send more than 10 patches. Next time, I will be more careful when 
sending and will also increment the version number.

Best regards,
Hans

> 
> Looks like a good candidate for coccinelle.
> 
>> Hans Zhang (16):
>>    PCI: Use FIELD_MODIFY()
>>    PCI/PTM: Use FIELD_MODIFY()
>>    PCI/IDE: Use FIELD_MODIFY()
>>    PCI/IOV: Use FIELD_MODIFY()
>>    PCI/TPH: Use FIELD_MODIFY()
>>    PCI/MSI: Use FIELD_MODIFY()
>>    PCI/REBAR: Use FIELD_MODIFY()
>>    PCI/CARDBUS: Use FIELD_MODIFY()
>>    PCI: al: Use FIELD_MODIFY()
>>    PCI: eswin: Use FIELD_MODIFY()
>>    PCI: s32g: Use FIELD_MODIFY()
>>    PCI: tegra194: Use FIELD_MODIFY()
>>    PCI: qcom: Use FIELD_MODIFY()
>>    PCI: dwc: Use FIELD_MODIFY()
>>    PCI: mvebu: Use FIELD_MODIFY()
>>    PCI: mediatek-gen3: Use FIELD_MODIFY()
>>
>>   drivers/pci/controller/dwc/pcie-al.c          | 12 ++----
>>   .../controller/dwc/pcie-designware-debugfs.c  | 23 ++++-------
>>   .../pci/controller/dwc/pcie-designware-ep.c   |  3 +-
>>   drivers/pci/controller/dwc/pcie-designware.c  |  3 +-
>>   drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>>   drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  3 +-
>>   drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
>>   drivers/pci/controller/dwc/pcie-tegra194.c    |  8 ++--
>>   drivers/pci/controller/pci-mvebu.c            |  3 +-
>>   drivers/pci/controller/pcie-mediatek-gen3.c   |  3 +-
>>   drivers/pci/ide.c                             |  6 +--
>>   drivers/pci/iov.c                             |  3 +-
>>   drivers/pci/msi/msi.c                         | 11 ++---
>>   drivers/pci/pci.c                             |  3 +-
>>   drivers/pci/pcie/ptm.c                        |  3 +-
>>   drivers/pci/rebar.c                           |  6 +--
>>   drivers/pci/setup-cardbus.c                   |  3 +-
>>   drivers/pci/tph.c                             | 10 ++---
>>   19 files changed, 51 insertions(+), 101 deletions(-)
>>
>>
>> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
>> -- 
>> 2.34.1
>>

