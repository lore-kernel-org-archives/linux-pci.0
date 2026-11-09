Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.129.254.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190031;
	b=MiiK+N5D8dss91/kq05L2SUrUTFtsgyI/7M0aw/OZ2c5esY6Ks7tv+GtH0CKNRHiFpfP
	 vcKgH6K7a3cShir2JksEMffUreYTpEG95ilPiRvlvO3NfscLxCuUw0PXG4Eblhv2js5Gu
	 k9N5C1XXgNFPBzRD3EQG1A2LWS+rpnJo8mNhmXZQBqfGC8HqRzWT+idKsSEj/S3sCq6W8
	 dtilLY707ctesXtFbgq1F5zdpfteooS7/h3Dt8UZw5cShlNwdYVTkL1zVNbgTSO620tLY
	 zKjh9rqOPjhsC5HptcPmKxEhPq7B2/IE64mI6Mjp2tOmnGlc4x45vxfv4znRSryxtxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190031;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=We4ESE2til4bSkM1vEMn0soL7vZrg8WY8DZ2Y26nFnk=;
	b=rPQkEgdtjFKsKzxFpkv+7WgoJlAJsEdMZKoZc41b9H/X7d9NI+Rx4YoTYSJlpBKNRi1E
	 XZP6ndJwii86agpuM+aVgZ7rKXPrXHM0dEpUb9svD2QhF2hmOcxlTI3Mxk288oh4qTKAO
	 dCXIYELelYs4pt1IysKcX0hAh0ehjBBcQB60OCeyYhAGdrHzcHO15GWm/ql0ieru4OOOc
	 bCp6EXQrgnwqkDR2n2mqgHudpnVxtheWmmfTVKc0gX/KCk7znvUuN1RL3UE3W9tlH98/9
	 DYXySzZoFod6JmuPIDORku/m6OdtoB8b27Ql0lfgHMig8XPH2HMN3Mzg/aXeiXrT0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=RSzMaBpz;
	arc=none smtp.remote-ip=103.129.254.83
Received: from mail-m25483.xmail.ntesmail.com (mail-m25483.xmail.ntesmail.com [103.129.254.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C230606A322;
	Mon,  9 Nov 2026 02:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C230606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=RSzMaBpz
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53eeadfd9;
	Mon, 9 Nov 2026 10:06:57 +0800 (GMT+08:00)
Message-ID: <60fbb95c-63cc-4d22-9e2b-51332a50054d@rock-chips.com>
Date: Mon, 9 Nov 2026 10:06:55 +0800
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
Cc: shawn.lin@rock-chips.com, =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?=
 <ehbello@gmail.com>, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset
 a JMB585 on RK3399
To: Igor Velkov <iav@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
 <20261106-rockchip-pcie-ltssm-trace-1@iav.lv>
 <6c9adabe-d632-471e-8fc1-aafe62115167@rock-chips.com>
 <20261109-rockchip-pcie-deskew-result-1@iav.lv>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261109-rockchip-pcie-deskew-result-1@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1be0f01f703a4kunm84dec09857da6c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0hKGlZIH01CGUNDTk
	5MQk9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUJCSU5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=RSzMaBpzKBX5tqLpuWQ15ZQyFDH114v8q2IeBzHG+Vp+GQV3bxrhL7Kcukqj4D585i+sB7hqCNAmmV5+6/8cW1TRIEKMKs7Cvk18QPkUaOOQk3gusQTpcjDlblAIqw8/pktunXi45CRaK61wjrAV/kL9AvGg/8sY2nt5fnKVZUg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=We4ESE2til4bSkM1vEMn0soL7vZrg8WY8DZ2Y26nFnk=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/09 星期一 7:05, Igor Velkov 写道:
> Hi Shawn,
> 
> Thanks. Deskew makes no difference. Helios64, x2, bind/unbind, variants
> alternating every cycle, bad link bring-ups:
> 
>    defaults 6/104, auto deskew off + trim 0xf: 5/104
>    defaults 6/104, magnitude off: 6/104
> 
> Your mail has the magnitude at 0xb, but TRM V1.3 part 2, 17.6.10.1 has
> TX_TERMINATION_TRIM there and DESKEW_MAGNITUDE at 0xc, so I wrote 0xc.

Sorry, my typo.

> 
> DEBUG_DATA_OUT did show something. With Debug Mux Control (0x208) = 5,
> share of samples with in_dllp0_data_valid set, 100 ms window after hot reset:
> 
>    good bring-ups 0.16% (99), bad bring-ups 51% (3, range 45-53)
> 
> The first training looks the same: 0.15% (97) against 47% (5). mgmt_dllp_error,
> crc32_error and in_tlp_error stay 0 in all of them. With the mux at 4,
> start_replay, replay timeout and dl_protocol_error stay 0 too.
> 
> So in a bad bring-up the RC receives a constant error-free stream of DLLPs.
> I read that as the JMB585 repeating flow control init because it does not
> get what the RC sends, but this bus does not show the DLLP type. It would put
> the fault in the RC to JMB585 direction, on x2 only.
> 
> Is there an RC transmitter setting worth trying for that, such as swing or
> de-emphasis? If not, I will stop looking for the cause here.
> 

Reg 0xa is for swing, it says: "This value should be set to (64-56*0 .9/
VDD09) depending on actual voltage of VDD09"

But de-emphasis is fixed in each kind of bus speed.

> Igor
> 

