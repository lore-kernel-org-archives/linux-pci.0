Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793387424;
	b=sIwxT+th/X3u3AWT7QZ3JUxggZW7wdNkhYW/anJK5XB8iAuRMjN0OSp+MgPunwVWWRD/
	 P0tRl0iveadNrlsTIdiDVUEo2r1eWsegZqL0DaXwp6URUzBT9hegKWrEiLI13xiANuhxI
	 SMJsf2Iaz/DxWrF0kCzzHrzhyxj6F3DQph105UMpEW7kxLxG5p1jy5hBwNW4t8PZgTMov
	 sjSpXDRxOCd23odxZPfd5H5CAy948q4ukw33p6XaJXoCm9MSemOp83GbTcEtYC+nP4LeK
	 ZyxNGP6IcbjRwOG36RnDzs/hZD0GzaIcctk+01exla4u9RA8xi13RJK2xtzy4DFOTLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387424;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=xEvyPemN7A3JhLcQtF4gMWOt0Hrab2ZRSSkUphZVqUU=;
	b=J4We9Sq42Sqa/MREKFaWJA4vdBvhR/z6usOiHcP8qSfEykBQYrxVdazosnYPxScQsNsR
	 hoFRUj+BOgVzUDBFmJUBJqGi/rqSsvpeoH+iXGQKLV8Acjt2O6tTI+BzeDXcb3cl41jUJ
	 mjvY9nJsRKE5E3ygoAGQJRNBK9c+ufy73RNDzW/BpFCPFUamrOsrKrEjaYFrKYiIf+hed
	 NU+yxlOCTT1nPTwl5xyNJpE0yEVONxSlDyo2CYbQeN7+iDyn5nfy0CHj0tpMDROyO1Dtj
	 HkZyy+0WMLyfncO+jChO1x+mnBOMoa/Lt8O7+rC1YpWYJas9G/8V3AB6xsBQbJnjWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bIGYkJCB;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D4606A31A;
	Fri, 30 Oct 2026 19:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E86D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bIGYkJCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793387420; x=1793992220; i=markus.elfring@web.de;
	bh=xEvyPemN7A3JhLcQtF4gMWOt0Hrab2ZRSSkUphZVqUU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bIGYkJCB5PQlehZhRkKS37Xsj7Iwc4ymU28SIvTSYhFYbH8EBnjzi717k4t1p90G
	 6fZWEiddJWGRxtvTNBcjhj4PeYm4LOLIwjNQCJNM4QFC0m5sbWxDw0mfQSIu1lyfd
	 adfhkCFnpuOVisjRMK6AUNxg09ObiRC+QUHRt//O74Jwf/fgNbExUQz779aTMo6GU
	 o95tybHWZZjEZe5QDcdC4/e0C0vqMLHZMJzN94v8VCV8esGG86qNWnwzDG7S2p81d
	 tVqFWUj3EQsCMPIADfLbeeQagmLDxnOAxD89Y9K32HJyQcm6cGj59jr7YGMXJEWrC
	 2TWYHir1ehhCjyNnRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1xJH5z37kB-00DL5H; Fri, 30
 Oct 2026 20:10:20 +0100
Message-ID: <3d9071c7-d98e-4697-b57a-2a955a704117@web.de>
Date: Fri, 30 Oct 2026 20:10:16 +0100
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
To: Felix Gu <ustc.gu@gmail.com>, linux-pci@vger.kernel.org,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leak on clock error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r2Zn9M4LAeqsFJ/5Ewn9rk64fxQGccTc2ba+EALlmlEG2qkrXNh
 aLqCugA5R79gA1FIPLuVQZB/ZK8EnRQqLqA+MNlkHvj2SITl1aYtoyRCn5dFClkVGhVSU14
 zcX3ko/+kLkAKsogjio9UW8aFt0QbAOKCqi2QrhvdfkkYw13CFBqDUzYbqiQPQTSC1cePZ7
 BMznW2ChxjHHkBE0agn3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GxoVNHZytI8=;LoAaMeQCt8yJnqtG2WQRc9b2VXL
 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
 z4wuCRSgqsNSy73LFZIm8RxxBws/xLu643PWw==

> The devm release action for the slot supplies is registered after
> devm_clk_get_optional().  If clock acquisition fails, probe returns
> immediately, so the resources eallocated by of_regulator_bulk_get_all()

                                allocated?


> is never freed.
=E2=80=A6
  are?


Regards,
Markus
