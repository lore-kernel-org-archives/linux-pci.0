Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236863;
	b=pZQcnD7P/7gF7z0LOD4Y6mp+dWpaUcJLuZSX787XMsiN7UE2lZP+nia/opBe+qZ+lXO+
	 fVNmAuzZADmXhfRd5swFmTUqQlyIfJwqgKUr7zUYLWJXBkatv4nWB1IfWVcJ+tQsWSwN3
	 IKLKYpa2WSY5Wy8iBaOsMzQi3s1FvjlYomoxaAldzWxPmvIT5n5m4R8kd1T208RDZJxrJ
	 lR11E3Io1CF2KPbGe/7rTaQwadGyBicEB26OaQAP5HLkqvPyfAiMpg1BK4M4WFtQeV6FC
	 9rKeEJC0G/FrFyy4Cep6+02m/+XDdFl5aJR5ORvPEXpSmXKj+uepjNgchVKf9NqFR6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236863;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=InNwYIMIJI8yrg6o/8hogQFe84wdeKa70SPggHPT1Ps=;
	b=TXPDnbj4jiB0iF5k/pGGONaf3WxEPtZNJ6TPOnQfd/XQL/JYzp2L3jQtQdXmSNjthWQX
	 Z1qBaL3al6u/5ZL8eT1kzSIJu2Pq7Qb99XVIKi2Bw7qIJyjyy09vUhwYF1QlNKegsiTO2
	 0Ate5+O60PkQvENp7ntLQO+6hIKysiGggS5pabJGcG+lVqGp0ErUiviwjpYGmenBZy7+a
	 mZ34VB2WsuTuZCdN46nACo3KofaNITguANRHyFkMWd6KAjsyIvOyy4B32ZUu8xACurQBf
	 PgsC1Z4CXPq7aLP++qhD0O8/haixuKOxpkPcDSG0GdnwyVCuVojHrcKlTodo9v4ce/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KrVbrHBa;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184A606A326;
	Mon,  9 Nov 2026 15:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B184A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KrVbrHBa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=InNwYIMIJI8yrg6o/8hogQFe84wdeKa70SPggHPT1Ps=;
	b=KrVbrHBatWN5A+oE+H9yy3Vf4NfkgY3u8Rj2HFxCrfy7EdplXfSt70HWWcZLwh
	/C6WnH1r7rLfVgoW1FY1zaLGFzyd7dn95MxfK1IloYJhY6mNWLvFrOOKJCksyygH
	nw9KRh5w9N9Ue+WQ5j+8iur5GXJoCi6j7QcxLNX0lZ4Vk=
Received: from [IPV6:240e:b8f:91b3:d000:f8a3:659e:94ea:8cfa] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD39xp74fFqmq84GA--.54682S2;
	Mon, 09 Nov 2026 23:06:36 +0800 (CST)
Message-ID: <ad7ad5ed-bf3f-40b2-97c4-fbd6f35acd3d@163.com>
Date: Mon, 9 Nov 2026 23:06:36 +0800
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
Subject: Re: [PATCH v2 1/5] PCI: Use pcie_get_link_speed() in pci.c
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, mani@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, thierry.reding@kernel.org, ryder.lee@mediatek.com,
 jonathanh@nvidia.com, robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-2-18255117159@163.com>
 <43198b7a-b0f7-49e4-731a-807e7d9e5959@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <43198b7a-b0f7-49e4-731a-807e7d9e5959@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD39xp74fFqmq84GA--.54682S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWfAw18uryfWF48GFWUCFg_yoWrWrykpa
	y7C3WYyF1UJr1fWF4Fqan8ur15X3ZxZrWxJrySka4kWr12yrZ3XFy0q3yayr1Syr4DAry5
	A3ZIyrs8uan7tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRepBDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ByuUmrx4XyrPAAA3d



On 11/9/26 20:03, Ilpo Järvinen wrote:
> On Sun, 8 Nov 2026, Hans Zhang wrote:
> 
>> Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
>> pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
>> the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
>> with bounds checking and is already exported.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 7c6f2aba8144..92ede1768caf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>>   }
>>   EXPORT_SYMBOL(pcie_set_mps);
>>   
>> -static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
>> -{
>> -	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
>> -}
>> -
>>   /**
>>    * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
>>    * @pdev: PCI device to query
>> @@ -6048,7 +6043,7 @@ int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
>>   	if (err)
>>   		return pcibios_err_to_errno(err);
>>   
>> -	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
>> +	speed = pcie_dev_speed_mbps(pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)));
> 
> Readability seems worse due to cramming everything into a single
> statement.

Hello Ilpo,

Agreed. I'll split the link speed class into a separate local variable
at both call sites, keeping lnksta intact for the link width extraction.

I'll send v3 of the series with this change.


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..594ee7aa4cad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
  }
  EXPORT_SYMBOL(pcie_set_mps);

-static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
-{
-	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
-}
-
  /**
   * pcie_link_bandwidth_mbps - get the current bandwidth of a single 
PCIe link
   * @pdev: PCI device to query
@@ -6041,14 +6036,15 @@ static enum pci_bus_speed to_pcie_link_speed(u16 
lnksta)
   */
  int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
  {
-	u16 lnksta;
+	u16 lnksta, lnksta_cls;
  	int speed, err;

  	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
  	if (err)
  		return pcibios_err_to_errno(err);

-	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+	lnksta_cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
+	speed = pcie_dev_speed_mbps(pcie_get_link_speed(lnksta_cls));
  	if (speed < 0)
  		return speed;

@@ -6074,7 +6070,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, 
struct pci_dev **limiting_dev,
  			     enum pci_bus_speed *speed,
  			     enum pcie_link_width *width)
  {
-	u16 lnksta;
+	u16 lnksta, lnksta_cls;
  	enum pci_bus_speed next_speed;
  	enum pcie_link_width next_width;
  	u32 bw, next_bw;
@@ -6089,7 +6085,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, 
struct pci_dev **limiting_dev,
  	while (dev) {
  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);

-		next_speed = to_pcie_link_speed(lnksta);
+		lnksta_cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
+		next_speed = pcie_get_link_speed(lnksta_cls);
  		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);

  		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);




Best regards,
Hans



> 
>>   	if (speed < 0)
>>   		return speed;
>>   
>> @@ -6089,7 +6084,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   	while (dev) {
>>   		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>   
>> -		next_speed = to_pcie_link_speed(lnksta);
>> +		next_speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta));
>>   		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
>>   
>>   		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
>>
> 

