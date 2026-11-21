Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300039;
	b=PxjG5ifcx9gzo8Wot/vp4mCbFHkvBOnq4q/omiBTCW1P6EeeULeoCPwHhXddG/Br0m7k
	 khKfKHX2rYy/TFToGMaAQfRsVBW+3P4zBWyIFn3+2P5kdmDIiSXm8pPRSbPWBrqHXln5A
	 fWUozNY1zgsQNLIFzCSLgFuxcOgUTmMN9SOEijPFhuBs6toxD27W7lmLqegrLhG0SFSQR
	 E/YzE7ZXQ62ojrqtLOr8UiSexmTgckfEN2ube18zWj3zwJ8xAtzQGx0HzHUyLTuIYg3XA
	 YkZEH1iknDIWW3cQcFihTQLdqEkVK6d+L4VNHXc3WV5w1pWuoa8ITxLG1RQ0LhO3J3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300039;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=2yRCyARRo07clhwH9ssegv0W7bTTK/H6NvyccaJfHAU=;
	b=kxYaUUi0u9qPyZoHInc0JtXyJgbRhwOcFJZ01Idprp3K+n3WcloBliDP75E3apttaqfu
	 DlYoGMS+qkDz6a59WY09N5wo2bmruc0oxSS/JWNRLM5064AryfGqSDQTFnmvHItOOqtXh
	 IlvJkdeqA7XcsjnyYMo7akcSsYqhUhu41+hD3CO71tIrGf5QZLmYbF94Y9LkEDpXJhBKZ
	 5Vr7lyrxX05wWebg2z7x2Jfr2Cf1UYtHcKfB1tay2nYiTarfOmQHdOwcknaNVgUY5Mw0T
	 i+yHPZWoBNN/5wkshh34Ss4LWXPWTaQVgkp+lcxyKTub5HV46aF37NzmO4DejxFWH3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Sj6j9v98;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7639606A338
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 22:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7639606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Sj6j9v98
DKIM2-Signature:  i=1; m=1; t=1795300036;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:te5his5sC7ErpkSYflbvNoY1IFmt
   PfjWa3Z37Xn3OS3E8IHTOEg7RJQgXCKdWnNoHJdwnbd/lpJZ2Sgo2H0zshJ/ERHQDBmoxJb36yW
   22+YmbiH3C5rIiR8+tUpjUcR0uTlJyzCCF4nVWe2GQjYogOL/TADRrWpCUmrvMOeyuFNTB6ar4+
   3TdxaTWwsCc7lJeEWZUtRJSIagfxZ79UOX6Dw1FoVn6+SPusHQh2Q1HrEdKVH3EE747jcwiDZBW
   UUBSHV979MDSL+JN3QV6/q8jtB9UhTmPEEC444vfGbzFQU1W8BILZt05TpdWfurhqbUZRvTAgNe
   GQZJf+FdHa2fRA==;
Message-Instance:  m=1;
 h=sha256:
   eybDLOLQARzoNShg/fBd/gr7YMMQYoqxdpmbjBwdVa4=:
   rF1KnxIV5mfDzJq6gDWjEPLpYS7fhbMrVPAfJMFSFq0=,
  sha512:
   +/3b+flYt4qh8nlwml5SyOk1kQi2M/xDBG7nprI7mOyjh9m0yLQZXiZXa26+/nFVOSBNmsxdOkwIsJT2cilWdA==:
   2nFQq4hu1sZhrs5hNjWA3kOy9YChcluyufNqqz8ab0i7hhQ+xvYwTTNgrApcPC0RDw5oTYDV6oEYkq7TnedTFA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795300028; x=1795904828; i=deller@gmx.de;
	bh=2yRCyARRo07clhwH9ssegv0W7bTTK/H6NvyccaJfHAU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sj6j9v98CX6HgkNi7NcUOSl5udJOIVzvf2GOYynAKVjaU9Pp94YxZ0Un+JeZtj25
	 VUABtjc6lg3lhYbuyYKa31WAOisJVpMdcIJ13103MtyCz0Vym2VBn5+rpJfCjiTE8
	 Sw5og7IFbLiUzhu9KIN8Gm/vdw9j3Yqq162Ry83eHmn1UOMHYAusuuJExaK15eZLH
	 vvLWCOpimVtnxiaeQ7vlgZA/aROyXtF2O9zaPypbRbnrS4/mVpyIWHbVnfnqm4aWC
	 jrGBxVSlnwlh0XyncM9MQbto+BUASb7PfvJtANZELyZyrzNqs7Wfg1vZPM5xWAI6+
	 PClpkI6phe0am+DoYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1xW00e0Ulg-008bu0; Sat, 21
 Nov 2026 23:27:08 +0100
Message-ID: <7e5c6e45-415b-4c8f-ad9a-bc01e6fe0fa8@gmx.de>
Date: Sat, 21 Nov 2026 23:27:05 +0100
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
Subject: Re: [PATCH v2 12/16] parisc/PCI: Convert to
 pci_assign_unassigned_bus_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-13-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261120134716.3027-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5rJFqp5KvoPiatkWxzIWgSJRtkg79j2Xs5PbIoN45CaHPGb3+Y
 VzbudGo5mSfALlo7EcMddH9UMk9ENrk84R7kSnt6Ws2656dL9wGla6SGGmjChVc5YIEXbTF
 UrK7yscd8Qc7rlrpGWod7B0Z2FXzgOtEE969S15gF4w1BHyflGnqCgp8LN69i5cOE6KT/IG
 I+F1JrQXVnR62MO7iGVGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:09bsTXNsUF8=;9up9S9NVgKUk+NZqm68Mc+7pahr
 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

On 11/20/26 14:47, Ilpo J=C3=A4rvinen wrote:
> The Dino PCI bus driver assigns resources using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be a no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/parisc/dino.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge
