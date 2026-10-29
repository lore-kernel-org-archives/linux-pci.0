Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=47.251.158.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234417;
	b=yiUByfyF78RWUJd9SmLHbiwnrE+9IDW2kptgVbHh/t5aMO2rkPZNayc+GJrwAmXntBBS
	 qRLhCZAbH43tqqfAwPK54UxwqzxdmZeMHNOCAU2uj6tyd/S6OLP9N8lAQP5athNRpXfg7
	 9e5ss88ecL2uxb30jETt4+lEnGp/id9xlpv0JGoVAznDTmUgZGbjIAPCoCYsDXOFlAtbx
	 wJkxs+MjV1iirp6zggNDaJ5+Vx4En0wwjZ1UBgvJn6DeJTDkpfPx+A4i/pXr/DTB9Fgre
	 1Fq/LSFx7kQZeNSndfMeFZzBgn9YgcrRdfXaCaKfgGbT2ZMAANDl5rDLsutlgilYYvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234417;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=uBkoYVVkTY7EAIi/mmiI2JHj5K3iCMaezc8HVdReC/E=;
	b=fuLEYV/OPPKSuqrLGmo918sme+5YWEsn/3S2qOutDVVQO4sKso1ZUVFcybazJrm6VCtY
	 BQ5yuFtoqTUbTzgndWoF/UgtPfXQ9SikXJeEp694mi/9L5bS0/XBc1d3EyQQ7z70s7e4a
	 TrF67d1mGCJ68zfuPgdn7BOYgH9KDIA73M5cey5vFNXzVtbcratFN+3H1JwvPMxbT7D10
	 k0mH9gYI/Rq7p2exfGRHmnYsXczMxByIwc7vJFau7bHcsD7kCa9f4ERUw2KLCczM0PQWt
	 CUEvURl5pa69YxWYBISSVtei71baa0Q0U1d7U4OF3wb9UPx/iIesXK1rC3eW5F+eFoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=HCG9R6E+;
	arc=none smtp.remote-ip=47.251.158.133
Received: from mail-m158133.netease.com (mail-m158133.netease.com [47.251.158.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA002606A325;
	Thu, 29 Oct 2026 00:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA002606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=HCG9R6E+
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52b624e00;
	Thu, 29 Oct 2026 08:40:03 +0800 (GMT+08:00)
Message-ID: <9d52d66f-7eaf-4fcc-b445-751e555707d7@rock-chips.com>
Date: Thu, 29 Oct 2026 08:39:59 +0800
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
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, manivannan.sadhasivam@oss.qualcomm.com,
 bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, dlemoal@kernel.org,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is
 already valid
To: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
References: <20261028005603.2399220-1-ehbello@gmail.com>
 <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
 <20261028015923.2436122-1-ehbello@gmail.com>
 <95aeecc0-2794-4cc6-a635-5c042afc1405@rock-chips.com>
 <20261028171122.3422629-1-ehbello@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261028171122.3422629-1-ehbello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa18519806403a4kunm9f3b40bdfe8d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHR9OVhpNThodSx5CSxlJS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=HCG9R6E+IaJm1bNyBjRQaYBRGMVM3yRbMJQQx+50D1clXehcLwi6007xiUERJWtuPkNhcUBQsOv+CFjqhyrLLf8bsEKukzuUpiNFhtpZ+yu9vjatBpjX16bWUlkWx9pKR/m6EZHhybj/K61IhWICAPvfZM3vk4i3hKoH6DypNxA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uBkoYVVkTY7EAIi/mmiI2JHj5K3iCMaezc8HVdReC/E=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/29 星期四 1:11, Enrique Hernández Bello 写道:
> On Wed, 28 Oct 2026 02:21:14 +0000, Shawn Lin wrote:
> 
>> Was it possible to add a DT property for configurable delay? I came
>> across several EPs need quite a longer wait time, so add it in the
>> vendor tree for dwc-based IP[1]. That could be applied here to slove
>> your cases and others', and might avoid regression.
>>
>> [1]
>> https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L865
> 
> Thanks -- that is a better shape than mine, and I will do it.
> 
> I will mirror the vendor driver: rockchip,perst-inactive-ms for the pulse, and
> rockchip,s2r-perst-inactive-ms for the resume path, since the two paths want
> different values here as well.
> 
> One thing I would rather ask than guess: should the default stay at
> PCIE_T_PVPERL_MS, with affected boards setting the property, or should the
> default be the spec minimum, with the property there for endpoints that need
> longer?
> 

  I'd suggest the affected boards to set it via DT.

> What makes me ask is where T_PVPERL is measured from. It runs from power
> stable to PERST# inactive, so on a board whose slot rails are regulator-
> always-on it is already satisfied seconds before the driver touches the
> GPIO, and the 100 ms then only widens the pulse. The one pulse-width floor
> the spec gives is T_PERST, 100 us.
> 
> On my board that difference decides whether the JMB585 answers config reads at
> all: 0 of 5 boots with a 100 ms pulse, 5 of 5 with a short one, with the
> power-settling time held constant across both.
> 
> Keeping the current default is the safer change and I am happy to do that. I
> would just rather we did it knowingly, instead of carrying a number that was
> only ever right for boards which power the slot at the moment they assert
> PERST#.
> 
> Secondary question: do you want the vendor-prefixed names, or would the DT
> binding maintainers prefer something generic, given the timing comes from the
> CEM spec rather than from Rockchip?
> 

I think this kind of settings should keep vendor prefix, documented in
vendor driver's dt-binding, unless other drivers would like to share
this which I'm not sure now.

