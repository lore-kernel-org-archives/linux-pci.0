Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847244;
	b=lvDOPxphmRdcN631gR3C4EFBeoKe2xWd8UkEAxFumm3Fg3tMOMREOJeRRPkmtCfSrx3T
	 BqDpJt1h+J9fOcszE2cb15zsmL0Ztgpdg7oUB41RM14CHTUblrcrY4vyEN0tsx5mDvsF6
	 2zM9vgxy0HKSsxb3IuvbtuaJ6556j4Uhe3YWNGHV9twVoij5UovZumo9uPkoTjmKa7VBp
	 UsAgrjsEYvirYeAQ5BLdp9lpPAcfDCZJLjiMyBLpmHApdMLVVzhj/7LAJW/YXizzaRSK7
	 oUFexNE1xSyaWf8ntIZxeWrhkOZxwP/Ocv3l+jUsDftQGuPuCkkwm8GyxZXQyvGkXHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847244;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=makHNIiYLvU4q0uL7GjudiJJsJnjWba7FoFQaU2CjTA=;
	b=GT3qU8WH7Xco+56yZOoIeKw1lU8hgbaqVmcqGz5Dg4cnzY2xqxu54/FTa+yCSHs5U5G0
	 FS/b4EZb3HJkg0wjpgskxD/6BWs3YpXh1vbnJAkOkte/E3XtPyMe8jco3ybdCvYHKj8iw
	 WV3MnZYguLVEmLuC+PBPbx8LUL0cRD8hUONHewfcsZkt9U742jrJKWqp8sI86CyHFV3uK
	 hWnwgnrnUv1G+8Cnx7IaV0qYQqZbxXcUIX+g9PbcentYjvj3/0rMJTn5qEhFVCRexkJsD
	 U3zv8Pt4heMgmh+1IGusc400JVLyJS+ZKx+3AnWgkXqAOlYmRU3fuGtL0RMAxVNXgnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=dG7Zq9oZ;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B2606A31B;
	Thu,  5 Nov 2026 02:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 507B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=dG7Zq9oZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793847195;
	bh=makHNIiYLvU4q0uL7GjudiJJsJnjWba7FoFQaU2CjTA=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=dG7Zq9oZA0ud7MBYBH+jyazqhIvywclr/H2PHUIWbLqQtgC8ZftuNbA5f/kRf8fQG
	 viEqytWRUhYALIER5ShHmLYL8H71SakkLFi++21zm+bo4NWPdIfr30Bt163GFGsr0V
	 paN26fNUWLJLvDZByfK8p/ZLddlEsMip5GoCE0JI=
X-QQ-mid: esmtpsz18t1793847187t057bf204
X-QQ-Originating-IP: izYglXd86ZAHYwcrBOKCmCQvXih/anefE6LCbO6xayY=
Received: from localhost ( [8.218.183.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 10:53:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13090883998075243027
EX-QQ-RecipientCnt: 12
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 10:53:05 +0800
Message-Id: <DMMXR8IGD585.1QXMWPOMI19UL@linux.spacemit.com>
From: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Encrow Thorne"
 <encrow.thorne@linux.spacemit.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Yixun
 Lan" <dlan@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: spacemit: Ignore link partner PERST on K1
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com> <DLN6TV32A766.2BWYLKQW9ZYG5@linux.spacemit.com>
In-Reply-To: <DLN6TV32A766.2BWYLKQW9ZYG5@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OVxgrqsLORmRqorTkuJKvGn06tCDXz/QWhYmxmB9XDSmlKYv+Ro0IKB6
	HZpp3NjZy7ys73+jQrpPyCL/vA4h/LuBy7/fvZlNqNGquqG76Sjicf5JwMMyaedwuD/wHG2
	/F7blEh6v+bBoZpqmvJlaSbFsz5qUOxherz10lPaYNfyW4wUuhR5jqyy7vhUl96CtjCTzYt
	tS8vAYAF8QS2B0iR7D4isZAZp7G3o8vLgxe8VutItplbcGjySNj910CkSUcL1j8nvdRJCRG
	D7x125ElwMe9QegU0++f9QXZ1M3YZMSaJ4FoJHTrYCcMy7/3uClUt9ao0wp/0Y0qMsKLsKM
	CvEIuq5fVi0jbFVI53sN+Cl3g1Un3urFE9X+/cqmB6dgjwEyKGpuSaGIpUW950ic+VZE3kA
	VcKXt9tb6XrCdad7q/KlMWIPJ+V+263StKLiFJerXmQ5fqZlqSfDOz119lrPpHvNtRl9hus
	mSY1rrKmHv3030SGBvFt5LE1QSbOXdITCRx2diC2NHde7Cqjh3UWqy80e3JaqjYLUbM0Iyk
	Gsf1uIOOUZmzMah2P8S7JJaMqy7v6VqFlR0RH5VyrbZgoIF8Sl7gEqtorEC9oLi0lksI0x8
	sHqCV4nnC/jgI6GAym6TATUGWojJp6dj3rN4nXISfsb41ERYhOTigV4xaR6KV6qqDiXp699
	OEUnty3DS4H30X22KOhjxMeTsiTQzPhi0ZZ562Kcqvr2ZX8KKIQMnfP7d6fX2VTW9lBqX1x
	yw4JTz4vaCy/FpUznLTsxwx/od1ClDNv2dzEdUaJt6E+QKbHK4xF+CAdzUwP+FshddH+x/8
	icjJesqvjvMxwG3xVl1DpPBYYM3Ss2OuX+IG0+bEoGe9vXzkL7WubK5VKCWj6+0P1VYgbib
	uhesW+qBN7VI7D7sCo+H/Bjwyp1oUNGaKc75lJpRs2w1k5YYC3BxIteGfJz877UyJEJh1uc
	kJ0ZbYU0adrs9OGbvqdGSxBdFdSXn/BJPpheKDKWzfRrb7X2xaHnMJx26O9aKgXvLX6xE9G
	IWa8dcs/MTzh4fkCxhDSS4V0ano8n7wLN2IZJfJg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Thu Sep 24, 2026 at 10:23 AM CST, Troy Mitchell wrote:
> On Thu Sep 24, 2026 at 10:04 AM +08, Encrow Thorne wrote:
>> The K1 PCIe controller and PHY are affected by the PERST signal from
>> the link partner during initialization. With some devices connected,
>> this can prevent host initialization from progressing and cause the
>> system to hang while probing the PCIe controller.
>>
>> Set PCIE_IGNORE_PERSTN before accessing the DBI registers. When set,
>> this bit makes both the PCIe controller and PHY ignore the PERST
>> signal from the link partner.
>>
>> This allows host initialization to complete without being affected by
>> the link partner's PERST state.
>>
>> Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>
> Fix tag and reported-by tag [1]?
>
> Link: https://lore.kernel.org/all/20260825052249.66921-1-bbanelli@gmail.c=
om/ [1]

Thanks, I will add it in the next version.

