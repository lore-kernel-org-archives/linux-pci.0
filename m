Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756024;
	b=Mt8aiuYyGtdvf3XEg9GGcNWd91UuLxUOiso5Xh0LOoTiul/8GmOIcyX/NbaYHquLjSWg
	 NQapLJYhrS8G7Jlp6Zg0IhRJXI8FeB/Ng53Zl73EJ/PI7/DyuIipK6XiRGvX2kBBMmpTf
	 6XTl5ZindDFX5JeamRuEn9YOK2CwN0m+lkraOvjgLXXa4QiY+uh1/2qoAO/tYhniHIhR3
	 m+I60FDfUZPE/3fLJHBqHHE2j85fIDDRNWLMjKGbv36Ber/gFS72jUTJy5quSqS3efOOn
	 +BxHSRCxSEtLudjIhmpiz8/zsKOJFrWD1JydqX1tYTRAsaoOZIgpaOoVZh6xQ2Lafjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756024;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=0WWPaz90b/xU/ohykfvekLlcePMtmNROzXAvvrS29LY=;
	b=2DJjrOTldg5XRWbtjxC2fVFkRvQU6lbcbsYCSquT515tiS6SpV3HBgrNR134GnWGBArr
	 HosV9RJd78Z6VvODhvTMnLTLuhFXKXHIozMOiHPDSck/NW6qbOVpzknZ1N8qvuwbLDus5
	 u8kSl0vVJzWkv5JMAbtTC40gtUfkGK7eitWgQEkFJ8DVwwWkL+yV2oMvCG7H10xfqIWQC
	 a7HImWlQtsm/7zjje9jpNzVvJz7oTi+tgegqYpa3HA8+Aza/ev94S6tzyKQ34S3n+3nne
	 zB+h7eaqynl6Y4MbNnsGNmZ/6V4PVaiXxq7kwhUbPw6hiOvCtNo0liDD8f19co1sUVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kdaSQWEg;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676F606A31A;
	Fri, 23 Oct 2026 11:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A676F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=kdaSQWEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792755992; x=1793360792; i=deller@gmx.de;
	bh=0WWPaz90b/xU/ohykfvekLlcePMtmNROzXAvvrS29LY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kdaSQWEg3l1ioUh5OUiuZKbPqsot+qZ7909Xmion8AVsK0vz4TseNvsatpJx62ut
	 dDnFmqRWxgYLIXc8C7mrWJo+pTw0DCbVw/aL2iq6ic5lmFkRbrUUGArMp1mpCuqW1
	 x1YdF7ydaIqJWSazx7CIroCkBV3KL2JPkAdPgUpTL2gLlDZo1akCvNpS/CC9mqiDo
	 ud1G+/S+J2RSlyNNVBgZk4e/4U4pxco4nYWhzHomXdysIr9WrexooRQ6bhVsRLodM
	 tqM9s0aVm5bfEsLesRXh63oYDSN2ilDhB5KAQicHtPyC2yFtyRSqJgKp+I1UCn5VE
	 df+NaNYVlZkyu2GY8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1wZqJi3ws5-00xII6; Fri, 23
 Oct 2026 13:46:32 +0200
Message-ID: <db722ba9-d8a7-4a82-a3c9-3873a0d7b2e7@gmx.de>
Date: Fri, 23 Oct 2026 13:46:27 +0200
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
Subject: Re: [PATCH v4 2/7] PCI/parisc: Clean up resource debug print & use
 dynamic debug
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261021124956.4250-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f1Ove2r2lUPGGaiQOnnZiaWseIncTwdixjvL8bq3cUVab7VfTin
 ZAbdqEm59Wj8+qKF09/wSH+GpW1W1GaA4CWhUHoVceI/QpI8xt9njrWmXEeIiE9GmAMY+Lk
 kgCV+LWcBaUC5wDty7gfr3NGY2fnyJuY6eLoGeWkHX383X6KnqfzCo3+4bSQrICxq1QjVBU
 c+Ha1fDMBOoZVx83Za74A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jRbXvRb9/OI=;PxbnCfSRpP29v8tq/898nWppVNd
 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
 =

On 10/21/26 14:49, Ilpo J=C3=A4rvinen wrote:
> Remove adhoc RES_DBG() and use pci_dbg() instead.
>=20
> Remove printing parent resource as the passed is a temporary resource
> not within the resource tree so accessing ->parent does not make sense.
>=20
> Reformat the message to the typical format used by PCI core. Print the
> resource using %pR.
>=20
> Correct format specifiers and remove non-sensical res->flags int cast.
>=20
> Dynamic debug prints can be enabled by providing dyndbg command line
> parameter or through /sys/kernel/debug/dynamic_debug/control so this
> is more versatile way to debug things than the previous compile time
> decision which could only be enable by changing the source code.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Helge Deller <deller@gmx.de>

