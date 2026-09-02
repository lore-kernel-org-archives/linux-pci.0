Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877E40D57B;
	Wed,  2 Sep 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341510; cv=none; b=qPabofMjRLVpAmx+WIlTdE6+o/CjSBsndbEWiF/KzghrRiPrxkY2blCXYol05U3T9/SzDOU7K83VDedU/7DefXHkGqyoOvFec9JffAVkszoV8hhI29vlxTr9d923B7rH8h7m0n2euOyJPLgesRgvwzAUO/ObxquONHxr1ClhymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341510; c=relaxed/simple;
	bh=ugtBDYJdD5DyhAmButZjBxElaCXhKrXv84O+kv0etJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHRgGbtvZGdWoRKzMOoQ7rqPnI1JIsPgg0akSAYs8bWQ9vePo720/nrhzZ/QYJ/88GPYuY5GphibNXzX/pnWB5RMRTJrqP1a4EaU7iRTkzZArIHmpbN6RubPrHYyAAGjpzlDzPIsIUJz/LzYgJDOp5/XKKgvrO4GVaMQqxLEZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1788341474t02b33272
X-QQ-Originating-IP: DfJlt4hMjpdtOyPap8HbaAi8yVDkdztk3fLVqYXeqbQ=
Received: from [127.0.0.1] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 02 Sep 2026 17:31:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11555312155926092198
EX-QQ-RecipientCnt: 29
Message-ID: <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Date: Wed, 2 Sep 2026 17:31:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sophon@radxa.com
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ON6lkwODXNJZW8psWSDPXQQvx5jtYx8Gq0DsYERqJ7K2qVNcXc/5FGh0
	1SonjTmBqxPqIKFWO8q+q6zg7CfAL5syOAY+2UpcOcD7Q5Ghi/chsop4D3V5UoJ3xtMgjCL
	UMdzpdBJFBPLfTY/wd0XpD0xrs4rTeCHhic/iYDaz5qI74asY9E1pMahsm9AKqJyB8WxWK9
	L4Fu5uF1Zlp7/4/sTcoqMUew2gZHncapn7wdMaczC2lAlQyLVpn57WDo41caT0YJgxb1vIQ
	Qz2d6Bow6TxDvrg/My0ZhPpWkYRWPXL/zae7m3UqlMG+ua+OKm78paZcBz3KncrNGq5FW1K
	6vOQ6ZdI8weYtjVuYpDKSS0Xvt3zQcw5E4sVee8bIBYOPORei6wckxL6weHEzYpG5PyaUor
	FTfM/zmq/d5OKA1Dn9oABExufdrIb0KPWygPZPRk/IqyiDWgmzq0gDwWwDZe2tw1nyfA7WZ
	qQOIyVXpJvZdGDZYHFEBtc7b7Mn2x5KeNg6/vPaT8sDIoZmtS9aaGY8KmOSx8g9iQKihBvJ
	9ZC7WJTvSgto7rr8ajpQ6jKUqd10L3WBacXbfviL6ON0oy/ho/qE7C3XPKZiDghDaeVgHF3
	CvXYR8aobnImonTN1KMh/zyc106y5jcpjcKyLSd9KDbpjSGGP8q65cN2nCywjA1vRxXCF/z
	aIA4/B6TTaxELCeIV6tX3bmjwPp/czLM0pWFsuc47hT+amL5PwFKeSmd2qQI4aCW9pPcKJj
	in8cAL+fPYsrFUdazfmZSMoDGKB3UTsCZF8YzjE74iXf95Mz6TBE57KMXMwkrRpPBX+CHWm
	cerAYhGhFCH1vlKUOud0uWRQuMycyG7hz2AvE+Wn7Df+sRfEkfp72VbBsO8GrVAMA6iNu+d
	+mtKhpRzKzEEoxhfGov78gd3fGGr+d4MKR1O7edDM0ICYyJMsE1hkHfUukngXisq8pcU3Lu
	2Xd0+OM1nbt+6kP5beELz/3cRo+4tYTs1Pa06IQ6Ao1PKIo/OZah5QwtHFXwFJPUArFTKkC
	xfO85JdtspMn9u07Tf8hndx4k6Y6Wgwy/aj75nxnLeO+uKy5vzGg3WE8Tb55Q0/p9wT3p7r
	cioUnUhgudG
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
> On 9/1/26 10:47 AM, Xilin Wu wrote:
>> The TC9563 PCI power-control driver powers off external downstream ports
>> whose device tree nodes have status = "disabled".
>>
>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>> powered-off port functions during PCI enumeration raises an Arm SError
>> instead of returning an all-ones PCI error response. This prevents the
>> board from completing boot.
> 
> I agree with the premise of the patch, but I'd like to understand why
> that happens - do you have any details?

Unfortunately, I don't have further details. The downstream kernel also 
includes a similar workaround, so I suspect it's related to how the 
TC9563 chip is designed.

> 
> Konrad
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
