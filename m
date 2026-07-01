Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903B3AE1A9;
	Wed,  1 Jul 2026 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887603; cv=none; b=AeWhDGfCBZfsdcvQtM9HkZPDDoveMIweguAV1KstdnHUNehtHsLYay5UiX6p7jM6Gpyiyjy2e+HVz+uv1CMxlE5KCu2OaktwCbUfkG/P8ckTzl6voXGId3rwf7DWhpcy7FQ3OucRUQJygJTT47Q8+oLXel43gALIQR/7PjBcclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887603; c=relaxed/simple;
	bh=bxy69Td89P9UQIplI2nzRlSpOL6qfr7p2SBMm6vVxg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuG6EQCa6zFn5RxpKCuRW9JIt5ADJfkueKgW+GODI+cv1wQdyJ0Uu/Gy7w4al1uHFEkIh4MR/IP2dxA/1H9YL9R3s6O7bXwgI64xmSgV45ZXqENWuE/7M35eqneQLBmbVjT0xCCGs06wrqObkNvKldsMiJkbYZhKz/W46cgZzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mlhRKkdb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mlhRKkdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=n5FKi/xe0cAK9IB47NvrSO8zJqNPUDDNFXUuBFDZTf8=;
	b=mlhRKkdbbvtqqZ05f5H82HZx76JSAM4KSYo7hlGMZNKe5C4ltC0ZuTG3Lrj/qD
	Da3s0rv9fQ6vzEbt9wKfUwi1be7z6JPUXAAV71MtSDY8YqVswHIOlH3HiKgUEi94
	TFKKDeG1b3kj0JaibOOMXNh9D0zIeRbFwPpsAc0D52mWI=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3CYmPtERqu4CcGg--.7685S2;
	Wed, 01 Jul 2026 14:32:47 +0800 (CST)
Message-ID: <7eff7d0e-3ba0-43e0-9ab6-1b3fef92a5c8@163.com>
Date: Wed, 1 Jul 2026 14:32:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, mpillai@cadence.com, a-garg7@ti.com, s-vadapalli@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611165933.20071-1-18255117159@163.com>
 <20260611165933.20071-3-18255117159@163.com>
 <ikehyf77rcngzebtphevbqmuw4kpyizspg3rbcwpnw5qx7nlpp@p22qqao6sary>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <ikehyf77rcngzebtphevbqmuw4kpyizspg3rbcwpnw5qx7nlpp@p22qqao6sary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3CYmPtERqu4CcGg--.7685S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrGrWkCFW7ZFW8tr1xAFb_yoW8Kw4Upa
	yDGF1fC3WxArW3ZaySvw1UGF1rtas7AayUGa9F9347GFyayryUJrnFqFW8XrZrCrs0grW7
	Zw15tasrKr4ay3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR53kNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxD8oGpEtJCLLQAA3j



On 7/1/26 13:19, Manivannan Sadhasivam wrote:
> On Fri, Jun 12, 2026 at 12:59:32AM +0800, Hans Zhang wrote:
>> Add debugfs support for HPA-based Cadence PCIe controllers. A new file
>> 'ltssm_status' is created under debugfs, allowing users to read the
>> current LTSSM state as a string and raw value.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> > This patch doesn't apply cleanly on top of v7.2-rc1. Please rebase 
and resend
> after incorporating below comments.
> 

Hi Mani,

Will rebase and resend it.


>> ---
>>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>   drivers/pci/controller/cadence/Kconfig        |   9 +
>>   drivers/pci/controller/cadence/Makefile       |   1 +
>>   drivers/pci/controller/cadence/pci-sky1.c     |   4 +
>>   .../controller/cadence/pcie-cadence-debugfs.c | 211 ++++++++++++++++++
>>   .../cadence/pcie-cadence-host-hpa.c           |  21 +-
>>   drivers/pci/controller/cadence/pcie-cadence.h | 153 +++++++++++++
>>   7 files changed, 403 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
>> new file mode 100644
>> index 000000000000..c1104e28e4ee
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>> @@ -0,0 +1,5 @@
>> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>> +Date:		March 2026
> 
> July 2026
> 
>> +Contact:	Hans Zhang <18255117159@163.com>
>> +Description:	(RO) Read will return the current PCIe LTSSM state in both
>> +		string and raw value.
>> \ No newline at end of file
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 9e651d545973..cb010bc97aad 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>   config PCIE_CADENCE
>>   	tristate
>>   
>> +config PCIE_CADENCE_DEBUGFS
>> +	tristate "Cadence PCIe debugfs entries"
> 
> As Sashiko pointed out, selecting PCIE_CADENCE_DEBUGFS as m and
> PCIE_CADENCE_HOST as y will cause build error. You can just make
> PCIE_CADENCE_DEBUGFS as 'bool' to avoid this issue.
> 

Thank you.


Best regards,
Hans


> - Mani
> 

