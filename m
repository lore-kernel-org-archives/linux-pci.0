Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878D3D412F
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599539; cv=none; b=tUBwFYdqck694u1AiS3VuVNRCAaMqn6hzfCi26RSAU5xyP1KP/Eter5vWi2qE1GnGdiICNDCTKfZBNJ8kwr8N6hqwn5xo5hoEUf2vdRtgsprmPRD37xLmtbr1iNxzRyrKrSugib9SIvlTHSA3bkLO0ptjXnyvZ8AAUpCn8HWOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599539; c=relaxed/simple;
	bh=eJSKjKWyEjmZxEGniHi1bSDl6xtS4hrUMvGqDs3JRqg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=dHEqCX6VrP+yjCAWGqdFYoBqSyll9FFgMSZpmEuoS8+FNm++I3meDu3TvYf1YR7STngwRIwY/8inUUCssJtOc5PqEnyA0CmWZNHGtWnfYkjbaLOEXZmzsnljBQ9/jXPXCIR5eSV2YCR3aQboMA+tssxO48I6hO3STyzJJmeNvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=r7fQKk9Q; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="r7fQKk9Q"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6560217375=fe@dev.tdt.de>)
	id 1w62P4-00EevT-Ps
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 09:18:50 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w62P4-002pBd-Cp
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 09:18:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774599530;
	bh=zrXleFLq4Xl5zu1d9fBXJdi1W05baQSk+AxyDiWH7+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7fQKk9QWg2zHrhqa5NsMdBYTmcXcJ8+KlCQUL6NXCyknyDdUF2YYxS+C8tU3O6wz
	 GMXX62YnjeFpx2bJZUF6/lJKmTsoySUxwpDIMpuLBspcVC7UFWOxqQQGg34q1MZo01
	 h8nWudaiX0/9wFsEViTXmY13WjRiPZkKpiM2mXjgtl2paqqkxA4lmkSixjpeCAahyE
	 MAeqrbCxDs2Z61MyC7vSuUltIbs+HarwAFCrT7NbyxRIGzatdZ98ELLHmAO7qj1eqI
	 Z3hqMqIdakBIjZRLQkNhL3Uq5sJ225ludujMLZMBFskLFzhyov5jerK7KmyVDHKAM0
	 8hzWX4xuiNTJQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0AE41240041
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 09:18:50 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E6915240036;
	Fri, 27 Mar 2026 09:18:49 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 830ED23A9F;
	Fri, 27 Mar 2026 09:18:49 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Mar 2026 09:18:49 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: intel-gw: Move interrupt enable to own function
In-Reply-To: <wbzulv5xewnqntx4kdgeldebiumshqmk6kdqsrtbgfzzvkiz46@jr6nd6jwzy2k>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-1-7fe13726ad4f@dev.tdt.de>
 <wbzulv5xewnqntx4kdgeldebiumshqmk6kdqsrtbgfzzvkiz46@jr6nd6jwzy2k>
Message-ID: <9c5177895f402c0f8ee83e3e7add0688@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1774599530-5CFFFF63-D34EF506/0/0
X-purgate-type: clean
X-purgate: clean

Hello Mani,

On 2026-03-26 15:00, Manivannan Sadhasivam wrote:
> On Tue, Mar 17, 2026 at 11:12:49AM +0100, Florian Eckert wrote:
>> To improve the readability of the code, move the interrupt enable
>> instructions to a separate function. That is already done for the
>> disable interrupt instruction.
>>=20
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c=20
>> b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> index=20
>> c21906eced61896c8a8307dbd6b72d229f9a5c5f..3a85bd0ef1b7f9414ce19fe56d82=
a78e34e9b648=20
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
>> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> @@ -196,6 +196,13 @@ static void intel_pcie_device_rst_deassert(struct=
=20
>> intel_pcie *pcie)
>>  	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>>  }
>>=20
>> +static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
>> +{
>> +	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
>> +	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
>> +	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);
>=20
> I'm confused. Previous code changed PCIE_APP_IRNEN register by writing=20
> to
> PCIE_APP_IRN_INT field. But this function is now changing=20
> PCIE_APP_IRNEN and
> PCIE_APP_IRNCR registers.

First, all pending interrupts are cleared and disabled, just as this is=20
done
in the disable function 'intel_pcie_core_irq_disable()' [1].

After that, all relevant interrupts are enabled. The `PCIE_APP_IRNEN`
definition contains all the relevant interrupts that are of interest=20
[2].

As I unfortunately don=E2=80=99t have any documentation for this IP core,=
 I=20
suspect
that the intention is to set the IP core for interrupt handling to a=20
specific
state.

Perhaps the problem was that the IP core did not reinitialize the=20
interrupt
register properly after a power cycle. In my view, it can=E2=80=99t do an=
y harm=20
to
switch the interrupt register off and then on again to set the=20
Interrupts to
a specific state. They do the same in their SDK [4]. Maxlinear is the=20
only
company that uses this IP core.

- Florian

[1]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/dwc/pcie-intel-gw.c?h=3Dmaster#n199
[2]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/dwc/pcie-intel-gw.c?h=3Dmaster#n52
[3]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/dwc/pcie-intel-gw.c?h=3Dmaster#n321
[4]=20
https://github.com/maxlinear/linux/blob/updk_9.1.90/drivers/pci/controlle=
r/dwc/pcie-intel-gw.c#L431
