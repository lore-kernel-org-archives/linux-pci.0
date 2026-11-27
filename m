Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795487;
	b=K5PPercTFX+j56Hx1wwr3oc3AOLONKfVyY/4HxykiiNFBd4cQD4vH9hO2PTwTGlMIjie
	 STg7dZMVlKTwWke1Y71U3CzeVJ0iV0NiPtbX7mLmxOlGWlk8/fjHMUmwT0fzN4+qTkxWX
	 I1qh++3d8mkyQNbsmh8w7hF/5vSRC1SkonA7I7JIXPzKX++9K2y5743gk459rkcyvvPZa
	 DpDnx0XlqOiJ8n2xzyWT/e/G5xKUWomCz2uFzPABR2IKBFdYaZ/17Ts6XSbcOjRb7cWP9
	 sFFRtoK9Mk/uAI/tZBACTSf5rQfJSCshnk/+Vcb7k3LaxII/c4e3fVQc2UQndAIHClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795487;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=du+kCgH6C65GuTE5Y2Keo+v1Xg9c1ajtG7VUQ+O4zgk=;
	b=IOzdNevOmW0aIuT9Pgi7SxPCETImNALbyERO0ZKEJp8Iz5RarTF3qNdi1v5xKOjXBxmE
	 RYDMsyIX9/6qyHSs4hw2EbyK0jVNfjflsozqtRuATFLBmta6OwVJe2RzCF4RcSjOAuBNN
	 T+ld+aXGeudVAcz2WCCCIL+7a5D4oTmiCMsKbCGzbpoQXXNvO0YvAozfczxgpicCJhwwS
	 3fGCgsKe1pVGbSEDZovhWEhHUXobdZr24ptbwA/03nVsrygbUQ7+Q5IbRCEoHhdURgDC/
	 Eq8GMplc5siD5GlxxdCDLXEWWse7sZz9mq+jJ0eFI8IInVhxYd5ZlUU5OKkc+D8n/lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cj2VUp5D;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE40606A31E;
	Fri, 27 Nov 2026 16:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cj2VUp5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=du+kCgH6C65GuTE5Y2Keo+v1Xg9c1ajtG7VUQ+O4zgk=;
	b=cj2VUp5DzPWpjFHy9cJTO+muzqstXl85uwmSMzGBMK5rvIPeOMYMdOFAjxrtfF
	VF5ft1Wahin3XrzV9lFXlgYAI9SpMiK9ZqfTg/MW0xQE7WsIg0CHWyHDHPxHqRQn
	vHhaNUtlfUmsLEshCNJW+x1I+SAziZ0W/NQlHUMY3QD/U=
Received: from [IPV6:240e:b8f:91b3:d000:4e56:5474:4160:163a] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXH0zfqQlr75mOLQ--.5291S2;
	Sat, 28 Nov 2026 00:03:44 +0800 (CST)
Message-ID: <c09512dc-b926-48b6-99eb-d7ba13cc276b@163.com>
Date: Sat, 28 Nov 2026 00:03:45 +0800
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
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com, mani@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127074329.747914-1-18255117159@163.com>
 <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
 <582bbeb8-13ec-4533-92d4-7216c20fb78f@lunn.ch>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <582bbeb8-13ec-4533-92d4-7216c20fb78f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH0zfqQlr75mOLQ--.5291S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4kuF1kAF15KFW5Gr4rKrg_yoW8Aw45pF
	W5JrWSkFnaqFW0k395u3yYkFyjq3Z3JrZxurWDuw13u3yavrW8GF1ftFWYg3s7Wrn2kr42
	qr1UJrZ7AFZxAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc4SwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AG-Y2sJqeFyygAA3j



On 11/27/26 22:59, Andrew Lunn wrote:
>> Andrew suggested：
>>
>> drivers/pci/controller/cadence/pci-sky1.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c
>> b/drivers/pci/controller/cadence/pci-sky1.c
>> index 82f4ae5c04a8..4448ee3d5e73 100644
>> --- a/drivers/pci/controller/cadence/pci-sky1.c
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -235,7 +235,7 @@ static struct platform_driver sky1_pcie_driver = {
>>   	.driver = {
>>   		.name = "sky1-pcie",
>>   		.of_match_table = of_sky1_pcie_match,
>> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> 
> Sorry, i was ambiguous. I meant the MAC driver should probe
> synchronous, not the PCIe bus driver.
> 
> I don't know the details, but i assume this is some sort of tree, and
> a list. The root node enumerates, and adds to the list of things to be
> probed. The device core then has a bunch of workers which take stuff
> off the list and does the probe. Those probes can add more things to
> the list, and it works its way down the tree. The first iteration will
> only pull jobs of the list which have PROBE_PREFER_ASYNCHRONOUS, so
> you can prevent branches of the tree from enumerating by setting
> PROBE_FORCE_SYNCHRONOUS on the driver at that level in the tree.
> 
> So i assume you can mark the MAC driver hanging of the PCIe bus probe
> to happen later, while other sorts of PCIe devices probe async?
> 


Hello Andrew,


Would you have time to review the previous discussion? Additionally, I 
will continue to conduct tests based on your previous reply.

https://lore.kernel.org/driver-core/DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org/

The modification will be made in the MAC driver.


Best regards,
Hans


