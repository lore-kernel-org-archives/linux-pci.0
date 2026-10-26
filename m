Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054723;
	b=qlyrx831YGTZrf6kvOzFwO1w/MzeDlg/d1jaU8Ac0ta1tw8FsKW7+Q00OJMNMgsux+Nx
	 kopGypgsJxPMs3rMwx33cYVZE1ZjGRf0EV/beEwmutGanIS54SMQbqmtMEACT4LVGFGXQ
	 orFOlDwYeMBFbNv2aGMP2RgvwipbSC7EXFoVPO2SzalbjD12GweYfiy6Y0nIpInyjEvR2
	 JZ+UeEmE4ibsI/VvBvNmcl3BPNheNL7wzkjZ08DA+6ZoMXLsKubRRd5gRAHwWqC2KFnlx
	 xRC6i4p4SfSmbPrQ9t8yfgrvmIYZXfn9ljE5JJNEey3NE3yHRTOkz3wYZTrzhARRL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054723;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=BY/SftwD8F8r8SqVpls6r5bnae+NUIq0aG4VMj423oo=;
	b=LBMMFwqkUFZj5FaEOC3tSdVsCeuxUW8p1Ndn2weFUJULLwSM1ifQJiNo+dBfwgTem9Ho
	 QGUvv3O2i22laxrk9f4uDueThOHXJzp+hfhInpIJMU4YXU+6x2IKsNiEfnvJrJ0gejMup
	 xzSGS51YGEahrSHcqW57BRLtxYT6fj7iV2hbafJ9+vqdhfyLahcx+GhH2T6Ipk9k19wyy
	 LaZ5iBPdQVWEAjAh8BXRm8ILBxnZbNzT28nLLY/DMTu5Vj6cszxT7n8Ij5ZShGdFAfAvc
	 Q/4LiUFm4Ve+jsYBZ+dmsPyFDTIurPv8dDgn8L3iePjhTaodPfc2xQvfn1emFZH468A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=fLcRhtPM;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB5606A321;
	Mon, 26 Oct 2026 22:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EB5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=fLcRhtPM
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jD7xW1Fy9zMlRG;
	Mon, 26 Oct 2026 23:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793054719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BY/SftwD8F8r8SqVpls6r5bnae+NUIq0aG4VMj423oo=;
	b=fLcRhtPMw3ehyQSJ5ZnPRrN2RN8KDpYR9dsK4RIfrHbVzgpneqFPKSPZFNAt6cZSqM9tTe
	ksqnx+9Hy0QQvLvRjaGHfHb4SK3yalhga2IF7kPaSgda9MPC2bM3Mc492wBmohVvUIWuGL
	U+gammvm83CX77HFzgzXboG2ClVFDwOTaVlmksjeG93TRxfcmrxa7HhRnmGcyIETvAVM8Z
	7OQzD6pKKVnkUCeqiQ3odBssH2fTuZSngnNMy2+qj3z+zGe/aBV5ZYHOcntBqAjiw+w413
	Nl2GUWtaKPW5+lthFl6ge4zaxM93MJRLxNzvkMteuNjr5vIlGOyi4fBOggp3jg==
Message-ID: <aad8d5cf-fc95-408f-b751-ef60c11fb263@mailbox.org>
Date: Mon, 26 Oct 2026 23:45:17 +0100
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
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ
 with AER IRQ on R-Car Gen5
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
 <20261026222639.GA4182867-robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261026222639.GA4182867-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yi55dgncqht5af54s9ht6x88qffx8xj6
X-MBO-RS-ID: 8cfcf687f93422cde01

On 10/26/26 11:26 PM, Rob Herring wrote:
> On Sat, Oct 03, 2026 at 11:57:04PM +0200, Marek Vasut wrote:
>> The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
>> Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
>> controller.
>>
>> The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
>> include it from the beginning. R-Car Gen4 SoC PCIe controller also has
>> an AER interrupt, but to retain binding backward compatibility, this
>> interrupt is kept optional and added in a separate patchset.
>>
>> Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Koichiro Den <den@valinux.co.jp>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> NOTE: Gen4 AER is added in https://lore.kernel.org/all/20260928165230.3397664-1-den@valinux.co.jp/
>> ---
>>   .../bindings/pci/rcar-gen4-pci-host.yaml      | 21 ++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> index 362c43a1a15d0..083b77d4de8f7 100644
>> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>> @@ -28,13 +28,6 @@ properties:
>>     interrupts:
>>       maxItems: 4
>>   
>> -  interrupt-names:
> 
> Keep with just 'maxItems: 4'.
Fixed in V2, thanks!
