Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE66239E75;
	Wed, 13 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656350; cv=none; b=jRp72i/ILXnyLYd/0CQKOaxLwWu4ep8iwINBJllg3qhWHzusMDNYf+rwgrgHmEi+DKc6WY9bUudZ0FbZWFXoAndG+AhHT3KNSoSpO9pOum9hIjo6kT0m4gsW8njug/LhgdbIBWhFmSCKOkGJNV9hFkbWj6HJ2vmnUEQvPEFbq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656350; c=relaxed/simple;
	bh=Q1gx0+RO9cZR9oA6QNpts6D6LZiJSpBbF4vMSuGeN2c=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=d9pb1cYHx5DMkOoZmHayLCpz7mt85OXSq1wiVuKnz8dQlF4JqFvGIEGvRJFuekvVTENWNHWCJfo22q1uUeivRNaYcVk+Q4paHBEIFIWCodCddNT1iqe758abQJUlNkd4dNsv+Ellg/59fjI6lQheaLRtEpj8A18LFvLHgJplxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=klURApOD; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="klURApOD"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8607e6b486=fe@dev.tdt.de>)
	id 1wN3Vu-007iZP-Es; Wed, 13 May 2026 08:56:14 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wN3Vt-00CxGv-Qi; Wed, 13 May 2026 08:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1778655373;
	bh=K7dloe9Oc6GXSk6TfICrEbt4JuZS7giJ41FpNkW0g7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klURApODyzCmH/IKROc4DfGirQCM4NBkTu2N7IkXYPrQW9Dt5XnWpxNMVUS3XysVh
	 ivJ9ebUGJf4jUkv0MN6EpAFndgYk//cPbVzfnbX5Iog4LK1O8SGiqIgtPfNR0R38th
	 H0dAE3hPaMNuQydZAgk5fwF0wrxyOHWwmAd3sZPZ5lFzdOrROSlENHe7WOjz/gIqJe
	 Iv4UJJ4V3AZd1xYN9N552wN7lmu2B1Q5J6RrxQuMJ9+2mnk4nnsT4cgKsX6H6UpYgu
	 5ub4B50UuAlo/FBQfF4Cy36VXI9uBjvdVg/JTxgVySycJdGa/JySlzg7XPQuyxpfWF
	 lAosZ85ICR+TA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5BD94240041;
	Wed, 13 May 2026 08:56:13 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 3D5BB240036;
	Wed, 13 May 2026 08:56:13 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id E8B3324FCC;
	Wed, 13 May 2026 08:56:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 13 May 2026 08:56:12 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Subject: Re: [PATCH v5 5/7] PCI: intel-gw: Add start_link callback function
In-Reply-To: <20260512204921.GA243550@bhelgaas>
References: <20260512204921.GA243550@bhelgaas>
Message-ID: <b5cca6b463b509cfd1b9cd41f5b89f05@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1778655374-1AF74B4D-6DE21F3F/0/0

Hello Bjorn

On 2026-05-12 22:49, Bjorn Helgaas wrote:
> On Fri, Apr 17, 2026 at 10:35:49AM +0200, Florian Eckert wrote:
>> The pcie-intel-gw driver has no start_link callback function. This=20
>> commit
>> adds the missing callback function so that the driver works again and=20
>> does
>> not abort with the following error messages during probing.
>>=20
>> [    2.512015] intel-gw-pcie d1000000.pcie: host bridge=20
>> /soc/pcie@d1000000 ranges:
>> [    2.517868] intel-gw-pcie d1000000.pcie:      MEM=20
>> 0x00dc000000..0x00ddffffff -> 0x00dc000000
>> [    2.528450] intel-combo-phy d0c00000.combo-phy: Set combo mode:=20
>> combophy[1]: mode: PCIe single lane mode
>> [    2.551619] intel-gw-pcie d1000000.pcie: No outbound iATU found
>> [    2.556060] intel-gw-pcie d1000000.pcie: Cannot initialize host
>> [    2.561901] intel-gw-pcie d1000000.pcie: probe with driver=20
>> intel-gw-pcie failed with error -22
>> [    2.571041] intel-gw-pcie c1100000.pcie: host bridge=20
>> /soc/pcie@c1100000 ranges:
>> [    2.577736] intel-gw-pcie c1100000.pcie:      MEM=20
>> 0x00ce000000..0x00cfffffff -> 0x00ce000000
>> [    2.588299] intel-combo-phy c0c00000.combo-phy: Set combo mode:=20
>> combophy[3]: mode: PCIe single lane mode
>> [    2.611471] intel-gw-pcie c1100000.pcie: No outbound iATU found
>> [    2.615934] intel-gw-pcie c1100000.pcie: Cannot initialize host
>> [    2.621759] intel-gw-pcie c1100000.pcie: probe with driver=20
>> intel-gw-pcie failed with error -22
>>=20
>> Fixes: c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link=20
>> is started"")
>> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is=20
>> started")
>=20
> This applied already; I just want to understand this better for
> writing the merge commit log.
>=20
> da56a1bfbab5 and c5097b9869a1 date from v6.5 in 2023.  I guess this
> driver has been completely broken since then and nobody noticed?

We are using the URX851 SoC from MaxLinear in one of our target designs.
The PCIe IP core is also integrated on this SoC. However, the problem is
that we are still working with the MaxLinear SDK, which uses kernel=20
5.15.

> Thanks for fixing this up.  I assume that means there is somebody
> actually using this driver, even though nobody cares quite enough to
> maintain it?

Due to the restructuring at Lantiq/Intel/MaxLinear, responsibility
for this component appears to be undefined. The previous maintainer
is no longer reachable.

Since we received no support from the manufacturer, my colleague
and I extracted the relevant components from their SDK and built
the target with the latest kernel using OpenWrt as the build
environment. So far, everything boots and works=E2=80=94except for the
network functionality.

But that's a whole other story, and hopefully it will be resolved soon.

I didn=E2=80=99t want to register me as a maintainer, because I don=E2=80=
=99t have=20
access
to the datasheets for this IP core. If you'd like, I'd be happy to do
that. As we use this SoC in our products.

---
Florian
