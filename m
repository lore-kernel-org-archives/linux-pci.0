Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487737;
	b=WAdK0XQgniKyBHPpGTPaOTKyLTLmNVq2S7yQtj4BgQeZuxNZcwcOgxbZVNdFnXgQt632
	 G2qlWLein+n6WV+xWuS8H43QofjY2RfLNluA+UjyXtA4DaxG1ul8r4PMMuWt2ERqozMc1
	 FmAnwIvoQn0d5YowjvhR3+m11jlYbgzWqaeXqKpuXKK3Rez823uuUed4/QU6JJUy6c8y7
	 lT7gVuZLb2iUGJ/RgXbws7jRWn74RDfUT9NZcsx16zmomCwyuv7cuTbvleGz4cY2wFAIf
	 T8/OQf4rE4jhZbOMd5TcaZmv0+CV7aKEadhjzfjrXlf9eX8fjA2lmXlAti6cuW2vF6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487737;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ZEFVy1u9EWTVS6BWzaopGDjwHgjCn1UoOlmq+iCgcxk=;
	b=tuG0teT3wbA6gBwUP7/DLYNtwK3uc2+LKYFfXOPgFW97MFVx4eEoBG3md9PrKLo4PrNz
	 P+1EObzSXFnSWKJ3DUlfkN8hVjqOLtN2B+BM9KWycauuieoA/Zy8LtzQvncbktrZDW0ap
	 WIazkGtsFej+kYMeDkLmVLKrydmpU1a6RIa2SXc9sGCK9biWixCHN+zy7XdEn+ZQqHOeY
	 gYjR7Bpep+cXOMP/LLfgeL56X1biqWSIz1dxHyz87jJunfZVt/NNzVp3YSpVpxuAcx9+w
	 vcO5f0VWHJrn9muguti5iq0VoFvjPW3lGjLEdYkPEZRcOkdtCRZIyN7KqM/oxSO1D4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AE606A33F;
	Tue, 20 Oct 2026 09:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84AE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1792487651td50b66ae
X-QQ-Originating-IP: PBOfxz++v/LvFipXH7mVzfeUBqvezzb47+j5WyN5cAw=
Received: from [127.0.0.1] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 17:14:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13061347834158941364
EX-QQ-RecipientCnt: 31
Message-ID: <3935A48BAE8900B9+821b9e6f-e494-4af5-a79c-f418cfe2157e@radxa.com>
Date: Tue, 20 Oct 2026 17:14:05 +0800
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
Reply-To: sophon@radxa.com
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
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
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
 <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwJw8fteqSn52q4HjouaqosrBLVSfynBKA4C9rhG0Yws+9hjiaKv8UMB
	028S655OZJheuiprUJaipx8OsXbG/KaM71kA2cM7vtBjY5pltsWUffwL20Ph5D0UqDih5ys
	LgKjR9sfwn591ZgpOCri3W1QIPPleVIYHG6pAS80hu4cgpRWh8cwqiICwtqq/UwAP23NBNy
	szt0uKhWAkLmaMffRNPxXbKZ9DZnJgvsRfrdsePYeK1z4xgbHC8dBVlyQ6lIklcFLF/tCcI
	TR/Qg6xNfruJmVWGPTTp2+NlY4Rdj4ju21vPEL2RiI+KfK4BLuhamPfVUycDExtxZrYZqMX
	jeXg/oDMUbkSqxZz/vpkts1+aMVBih+pqyjs+GcHPXCwkL1/OHSNI1icAztHzfUfLJC41fL
	6OYorrt4onA21VG+MNrYHdcFp/p0IEt/nvyJayAjPwTx/qyXb0Gs/f4FMIZr8Mqv7cKseo3
	lDWRcG9zxM+eJ3DF7NfA+jBBcpvXCXvnVHlx85RKluoKEwUsYN2hmKad8q6Mvhld8lKkGvY
	YyxP8qtCr39RM2ycjK0tMUVdOmbmZm84wGiVRqiKITElC0ZdYUfoTK9edG4s34r4yULhyrz
	LfRjYAS4ZClh3K/Z9uL4SkcLLohBzsnwC+TR2WI3l5/iDRwZFBOi+W4+9ZBidX9F/ndigtz
	zJ0eMoD2kKPDAH85cua3JRYOcYgF8Zi2jJcRPVXOBXtR4LsXV6LtNV/TZ0ykTBvBLde/PER
	tmw8sTxqrHR6f1Nsqg8xwcx5mCI8uctAkBT9fFp0FBE25FtnL6x2xP8nOVIJT9mMwPdpZFo
	/9xLaizCkwDVA5FE+twzc89Xx3kDp2v9OIiyhMqT8VG1ZIycoUBMcKyaSooHbK/Qia/fV/k
	o/nqtX2iOgyr/WS2lQ8j7YiIBTbs7DT3qg4V9Yu6ogCLhIwi0fxjjxzUBt34T4CSJ12NolY
	y6rYBMPppdzxrdVdDCA/X83CLk6mV1mKcfDycxnKsEueQxbEo+NIlRkLoIkBahLrcdHL3ns
	WP7ueHFlQLyvy1v8pWRUeClRpDrlTByqjoqPD5uwdmnm3UzixtzWP7KiTSc8zkOGxFK5X3A
	YEwzDduPRq8edumYpaQUSfQ1G2Q6VvDSflEhAmuz//yzZmUSkimY2SXJ5+DLU5KhKJzdyrO
	iFy7NiOr9J53g14=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On 10/20/2026 4:28 PM, Konrad Dybcio wrote:
> On 10/9/26 9:55 AM, Xilin Wu wrote:
>> Add initial device tree support for the Radxa Dragon Q8B,
>> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
>> SC8280XP platform.
> 
> [...]
> 
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
> 
> No i2c bus and hpd?
> 
> Konrad

The i2c bus is directly connected to the CH7218A bridge. HPD is 
configured using the TLMM edp_hot function on GPIO_2.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
