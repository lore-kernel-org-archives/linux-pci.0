Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674647;
	b=B1r/AbEIdJzd2n6+yPWLFMeIYrVAzm0MARDtsPkpIB3s7odnJMsSmf5OXKQkYG3RnbW+
	 uRTe588OO3XepwNpgWDp4RPmIG1i0axqgG3d1JadgaRyg0NDruO3HPskw0kWGy1MQAayi
	 3rxuyN+m7k0Ph0S2Jm99eYPNXD5f+tSaDvvs8qft99YaMgt2o58GHNI/cvXDvmAJFuTa5
	 bbd+L41h/oOIdBGwMJxs2iV+t+WY5aXxEXLWdeS0NiIo2pVianXzBk6CN8X3pdY4JnJmo
	 msthdLK23ASHgFq/kp4Oy3dGN0Er/jaFYphaesjNJBndKtkn+YAmP+d2LbxVuBM9cKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674647;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=K/VKNZTnoHlYdA52mhm/Cd/cZKCsJadbDnR229CP3IM=;
	b=KZ5HJnky0zy/fTcM9DxdcaW6VTp+52gfxFH69ofqXvTluGfhj62BrPaPyTNsiqztvjTS
	 8V/XkrKOkXlCslEdIB+yZFCLjU5I5CNEb/YL8CXjgSOogGrGZ0Rk2Qh0y1ZCsZFDj/f9X
	 tL4f/cd8YUGYIYRnu5h5iwIciVa/T/0+Ix1/fHW0xLYMsyqSPtletKwZJqssw0KLtmrce
	 9C9xk5LdZGv3Yht19tEi2XShfc185jsP7qHamQYXyRlM9bYi4aXduk/ge2KdOVTT/yrii
	 0VEuYfG8GML7ug/GZ8tGBkvkn8s/SM/OHE4/0qQpES2bw6FZa8IY3A2L7t7QQB9bHbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4C606A33A;
	Tue,  3 Nov 2026 02:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B4C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHXt2NTelqAijbAQ--.33440S2;
	Tue, 03 Nov 2026 10:57:17 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAf8DwOXOFTelq9qL0AA--.19487S2;
	Tue, 03 Nov 2026 10:57:10 +0800 (CST)
Message-ID: <b49779cf-5132-4539-86c2-e4f806b1675d@phytium.com.cn>
Date: Tue, 3 Nov 2026 10:57:09 +0800
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
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add linux,pci-domain-reuse property
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
 <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
 <8112d8ca-2234-490c-a4a2-c3b01adfbc88@kernel.org>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <8112d8ca-2234-490c-a4a2-c3b01adfbc88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8DwOXOFTelq9qL0AA--.19487S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGrnk0kFEwABsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AF48CryrWr1UZw4DXF4xWFg_yoW8XrW8pF
	WaqryDtFZ8XF10yw4vyw10vFWYkF4kJFW5J3WUGws8A398XF1UXrs29FW5u34UAF18ZrW0
	vFWqq34kJFZ3ZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 11/2/2026 6:00 PM, Krzysztof Kozlowski wrote:
> On 02/11/2026 10:51, Cui Chao wrote:
>> Add a new optional boolean property 'linux,pci-domain-reuse' for PCI
>> host bridges.
>>
>> By default, the 'linux,pci-domain' property must be unique across all
>> host bridges. This property allows a host bridge to explicitly opt-out
>> of this uniqueness check, permitting multiple host bridges to reuse the
>> same software domain number.
> Why isn't this deducible from the compatibles?
Hi Krzysztof,

Thanks.

The compatible cannot express this. "pci-host-ecam-generic" only
describes how configuration space is accessed; it does not describe
whether two host bridge instances may share one Linux PCI domain.

The same compatible is used on systems where every host bridge must
have a unique domain and on this system where two RCs intentionally
share a domain with disjoint bus ranges and resource windows.
Comparing the compatible strings of the nodes therefore cannot
distinguish our case.

Adding a vendor-specific compatible only to trigger this Linux policy
would not describe a different hardware programming model either.
What actually makes reuse valid is the platform-level relationship:
the bus ranges and resource windows are disjoint.

If you prefer to avoid a new property, I can rework this to derive or
validate reuse from the non-overlapping bus-range and resource layout
instead. Would that be the preferred direction?

-- 
Best regards,
Cui Chao.

