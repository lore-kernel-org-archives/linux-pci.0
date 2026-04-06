Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA2231832;
	Mon,  6 Apr 2026 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442531; cv=none; b=A/atf6QNBxWGX66ZdwsSxaBZeIR8Cdu40w4ERobmkxnR/BYwIbsoHBpe6DuVbk0WAJluopstDXiDUHoU6vIWt/YgO0cSXJYMjAvWk1YbHIJbbepqp4cQ+0yv5SK6DoE+sf6x/271WFqhbgU1lFyNcpRcdub7xdytJaa3oB75gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442531; c=relaxed/simple;
	bh=5ueL3SgwQdKPecM9Fovyz1KGIG7vUsoVcWjEYPy5lw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeO+MTp4/jSGcfvCG8CCcn05cOqjCcXZqsBFYYSQiWMuvQZ9B9qherFiYY06hVDDYZM2HkW2Kbjz0VDux4mGmQn8boL/+pe7ALkInoqg2uFOHjAl6PL8cv519G7yly/buKzKqdYiRUqkZQqM6jbKrdi9i6CZE175AV8KfFS/b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VW9dqPmd; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VW9dqPmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=NsPfresLcode65R651DUk7KfdMYdFOyfLhDlOWF+fH8=;
	b=VW9dqPmd1IxLDVXMLK1OiZ6ON2DSAZcpg+3eZ7k7DfH8luXvrCpl0/czN74aPe
	lZJxe7QjAY6E/7QeXDjo2xUkTacUztW9qH+MuTzA7YkVwibN0XHT0sEKWa25hGRx
	xfHEt66OiHdXnVZ346Xm4WNRW3HxquN+hDmlxiMINZ5Ec=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXYnhIGtNpoemhCA--.202S2;
	Mon, 06 Apr 2026 10:28:27 +0800 (CST)
Message-ID: <9e86336d-21be-4301-92ca-b79069ea99a5@163.com>
Date: Mon, 6 Apr 2026 10:28:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] PCI: Remove extern declaration of pcie_link_speed
 array
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260315160057.127639-1-18255117159@163.com>
 <20260315160057.127639-4-18255117159@163.com>
 <jobpwbins7tdv44kkbxnjsrobcqfdgxh7dxbngqwffzu4dutsi@p672ub6575hg>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <jobpwbins7tdv44kkbxnjsrobcqfdgxh7dxbngqwffzu4dutsi@p672ub6575hg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgCXYnhIGtNpoemhCA--.202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurW3CF1kZr4kur1xCrWDCFg_yoW5Gw1kpa
	y7AF40yF18JF45Zr4Yq3W8ZFyYqFnxCrWDG398W3Z7ZFy29rZxWa4IvrWfXF9IyrsF9r13
	tF17J3W7CF13tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zidMarUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w3ojGnTGk1W4wAA3a



On 4/5/26 00:41, Manivannan Sadhasivam wrote:
> On Mon, Mar 16, 2026 at 12:00:57AM +0800, Hans Zhang wrote:
>> With all users of pcie_link_speed converted to use to_pcie_link_speed(),
>> the external declaration in pci.h is no longer needed. Remove it to
>> prevent new code from directly accessing the array and to reduce the
>> global symbol footprint.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.h   | 1 -
>>   drivers/pci/probe.c | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 053fc245a1e3..b2f91409b439 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -107,7 +107,6 @@ struct pcie_tlp_log;
>>   #define PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>>   				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>>   
>> -extern const unsigned char pcie_link_speed[];
> 
> What about controller drivers using this array?

Hi Mani,

The following call has been accepted by the following branch.

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/max-link-speed

The main purpose of this series is to prevent the pcie_link_speed array 
from being exposed.

Best regards,
Hans

> 
> git grep -r "pcie_link_speed\[" drivers/pci/controller/
> drivers/pci/controller/dwc/pcie-designware-host.c:      enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
> drivers/pci/controller/dwc/pcie-designware.c:   switch (pcie_link_speed[pci->max_link_speed]) {
> drivers/pci/controller/dwc/pcie-qcom-common.c:  for (speed = PCIE_SPEED_8_0GT; speed <= pcie_link_speed[pci->max_link_speed]; speed++) {
> drivers/pci/controller/dwc/pcie-qcom-ep.c:              Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> drivers/pci/controller/dwc/pcie-qcom-ep.c:      if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
> drivers/pci/controller/dwc/pcie-qcom.c:         Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> drivers/pci/controller/dwc/pcie-qcom.c: if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
> drivers/pci/controller/dwc/pcie-qcom.c:         freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
> drivers/pci/controller/dwc/pcie-tegra194.c:     val = width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]);
> drivers/pci/controller/pcie-brcmstb.c:           pci_speed_string(pcie_link_speed[cls]), nlw,
> drivers/pci/controller/pcie-rzg3s-host.c:       switch (pcie_link_speed[host->max_link_speed]) {
> 
> - Mani
> 

