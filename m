Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE47367F2F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425496; cv=none; b=RI6Ptjz7vswfn0wdnf0P9RolwiszFEPn/bbh0mN7SHvVAcYTpuH4LCMAAA5rZYeQ+gz1jLO3TBUX1CURCwZMRGNnolkHcU2vkgILjVYY2gTw+9vNCbznNc+da3dG38gClqBjjP7lzq+0A4o+WFR2OP0CRxfxv0l4feV01GQtuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425496; c=relaxed/simple;
	bh=WPxvTPtnjQ1gVHmk9I0GnfL/eof97N1Yy4PJ01jbKOE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=P6v1b1rVVSQVdBtF80arDHcBzpIxds9sbS/8QxoSCYjpHC2x5wWLNp9nOjqXS6e7kdr3sPAQ/YuRLHcJdpH+tRvqnqfp4HaZ1wnTonfyyQp9qPXkqqKdaJFi1S46RG3DKwnBCp1R7J8ZRiu3dg3cr7kuW5KHbTuOWWSvXF0/hW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3hdUvwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3hdUvwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4611F00A3A;
	Thu, 30 Jul 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785425495;
	bh=q7kiDdbhhTh89Wpf0Vuocq8j/eYR7NjVcGECjM29+uE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=K3hdUvwVOsW1Nlnkq8/e+xtHLq/UgLW1XLSFQdb4tfWeDd8AYhrGLBZRIb5zqJxee
	 3EWtW3dDz9hyJrksWaGC4zV8Rjhyn0EffYLVBcGVTATK2Q06A9WuNo95SwAsQwdRHP
	 KIqG0eTBN7AAN9TuubWBGUMUYaBJIgl1LgpJfqEUdfvaVa5b+FcmfbZQaoig8GrT0+
	 pamB0048gts4nRXpPET9GwWJdOvFDHXmA4v3LDgb7sQ3h+qaG8tSOn4qsDYi0YhjF3
	 LZBXZbedgJp5nnkDHT0t2VzUIvDcMcv7Gn52FkFU9cy83TQAAiPaYr+kfIMyYxATYf
	 ArDdJGY/UxCow==
Date: Thu, 30 Jul 2026 17:31:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
CC: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
User-Agent: Thunderbird for Android
In-Reply-To: <egskztabtg4ldeb7nklxbgwhvzjbly7t2553kvh4hs7j7x3mhc@b6uefnxati6s>
References: <20260729202821.1153443-2-cassel@kernel.org> <ampndLtU32ODmncX@ryzen> <egai6rd3umstjhkuelrnemr2ywjlfccfk4tipaxodav426wxex@kuu76gvznusa> <amsqyOvAHU8uD2Wa@ryzen> <egskztabtg4ldeb7nklxbgwhvzjbly7t2553kvh4hs7j7x3mhc@b6uefnxati6s>
Message-ID: <17A22C6A-91C0-4522-8305-71BC2C5A2B4B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30 July 2026 17:17:48 CEST, Koichiro Den <den@valinux=2Eco=2Ejp> wrote:
>On Thu, Jul 30, 2026 at 12:43:20PM +0200, Niklas Cassel wrote:
>> On Thu, Jul 30, 2026 at 05:39:46PM +0900, Koichiro Den wrote:
>> >=20
>> > I was struggling to reproduce this, but I think I figured out what tr=
iggers it=2E
>> > It happens when the 'dma' variant runs before DOORBELL_TEST, e=2Eg=2E=
 when running
>> > the full test suite with no arguments, or by running '-v dma' first=
=2E
>> >=20
>> > I think the following patch fixes it:
>> >=20
>> > diff --git a/drivers/dma/dw-edma/dw-edma-core=2Ec b/drivers/dma/dw-ed=
ma/dw-edma-core=2Ec
>> > index 89a4c498a17b=2E=2Eec097c68cf5f 100644
>> > --- a/drivers/dma/dw-edma/dw-edma-core=2Ec
>> > +++ b/drivers/dma/dw-edma/dw-edma-core=2Ec
>> > @@ -755,6 +755,7 @@ static int dw_edma_emul_irq_alloc(struct dw_edma =
*dw)
>> >                 return virq;
>> >=20
>> >         irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_=
level_irq);
>> > +       irq_set_status_flags(virq, IRQ_LEVEL);
>> >         irq_set_chip_data(virq, dw);
>> >         irq_set_noprobe(virq);
>> >=20
>> > Could you test this?
>>=20
>> That appears to fix my problem=2E
>
>Thanks for confirming=2E I'll send a fix for this=2E Sorry for the troubl=
e=2E
>

Hello Koichiro,


I am just happy that we found this :)

Bad things can happen when IRQs are incorrectly marked as egde instead of =
level, and vice versa=2E

Hopefully your existing work on improving the eDMA driver will be more sta=
ble as a result=2E


Kind regards,
Niklas
