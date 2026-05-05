Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246D3FA5F2;
	Tue,  5 May 2026 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975929; cv=none; b=AaijeQfidZtD6ZvNt8OJP1aumVM8aXyi7lp/vEmq0cG6LKBvksEjuxKK14Ux7kO60wPmlVEABttOi5CyPRFi69xgrVe064yw3iQCrhBj9KEpAvPCs7gyAYUyGtXtecU3k9nJBmelZYLj8Mw3xDzw14hgaMDY99oTcphf2vwPOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975929; c=relaxed/simple;
	bh=tJGL8OXXCNJaF0p8ff6CaGRqxzJQ/K+Vjw+yESvAQrw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r1wyaMRw12WUPc6qDXrLDBF0mRgozZYsikUGhKWIkUW7PKYezco2HzI26RDaFRtjTpabHqVakqnFxeUEyrumurEvPDfBfDZChhzA+thrSyP2UiKwjzFHB8xGqREcI0wxyzIZNdrCy5XHENsSItWUB7JydypOxXQtcZ1Muu+0rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=ik4FNJdF; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="ik4FNJdF"
Message-ID: <9adeed85-9d4a-4ffa-a82a-2151ee417d4d@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1777975553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qc4EEqKO4B+4wnKeCFs5D1nvF4gN9Ydk/HUMcGlzces=;
	b=ik4FNJdFOOmhvcVWrazbWHMfIP7wQm8ALtPr+UUf98VbkQZVTtTg8MscQFvvR48qOjj8YZ
	k/VkW113BfM2etA3aVyDUYgoU5jJI1POINa8GvoRmouw8NZ1J4w6Lh5xw4aJglTqSswPHg
	gtAdwuuu2D69L9Z4mk0Awb3YMrkGFxGmfclu7PRNPMHBhdFOwN/Mrr2z5EHBQ6YIpAw8Ep
	1GRX1lxMwpnPaFNrZIs4v/FMr7AJRm4b0a/Pl4nOhZ7O6sWtVRSqiUjW7o7ELp3UEBsKDR
	8+Y9Nlnt3HDlCliYSl+atJr0QSMxHDcZjr1mfHFwJCc8OOoBNGJEgfk+2J++Vw==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
Date: Tue, 5 May 2026 13:05:52 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR causing
 host AER crash
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
 <20260420122444.GN2577880@ziepe.ca>
 <f732deb0-18e8-422a-923b-0e1c7e2c290b@app.fastmail.com>
 <e7ff4327-3d34-4b8f-9c60-8aa6ff1ef7c1@mokrynskyi.com>
Content-Language: en-US, uk, uk-UA
In-Reply-To: <e7ff4327-3d34-4b8f-9c60-8aa6ff1ef7c1@mokrynskyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ---

Wanted to follow-up here to see what the next steps might be.
I'm okay with testing custom patches, I can even try to come up with one using LLMs if it is not too difficult.

I'm very much intersted in interrupts working properly too, which should greatly help with performance (with my current setup it isn't all that great honesly).

Sincerely, Nazar Mokrynskyi
github.com/nazar-pc

20.04.26 15:49, Nazar Mokrynskyi:
> This is happening on Gigabyte MZ32-AR0 motherboard with AMD Epyc Zen 2 CPU.
>
> Non-vfio PCIe errors did not crash the system when I observed long time ago.
> This case with VFIO is the only one that crashes my system right now, but I have no idea how to debug this to provide more info, so let me know if there is something I can do.
> Maybe there are different kinds of errors and only some of them cause the machine to crash?
>
> I just get this after system resets shown by BIOS:
>
>> Warning: PCI-Express PERR/SERR error detected.
> No such issue with these devices on the host, at least from what I observed and read online.
>
> Running them under VM also requires the following hacks (libvirtd) that I have not found a way to get rid of (yet):
>
>> |<features> <ioapic driver="qemu"/> </features> <devices> <iommu model="intel"> <driver intremap="on" caching_mode="on"/> </iommu> </devices>|
> With all this the device does work, I'm using it right now.
> But I can't turn off or reboot the VM without crashing the host at the same time, which is suboptimal.
>
> Sincerely, Nazar Mokrynskyi
> github.com/nazar-pc
>
> 20.04.26 15:44, Alex Williamson:
>> On Mon, Apr 20, 2026, at 6:24 AM, Jason Gunthorpe wrote:
>>> On Sat, Apr 18, 2026 at 12:24:07AM +0300, Nazar Mokrynskyi wrote:
>>>> Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
>>>> internal reset sequence. Under bare metal this is transparent because the
>>>> host root complex performs link retraining automatically. Under VFIO
>>>> passthrough, the link-drop generates an uncorrectable AER error that
>>>> escalates through the parent bridge to the host, crashing it.
>>> If AER's crash the system then it is not compatible with VFIO, IMHO.
>>>
>>> For VFIO to work as designed the platform must be able to safely
>>> contain all the errors the PCI device can generate.
>> Aren't these also the WiFi devices that we tried to quirk because the driver writes the guest view of the MSI address/data elsewhere in the device which breaks interrupt virtualization?  The quirk was very fragile and never got merged, so I'm not sure how these devices are even useful with vfio.  Thanks,
>>
>> Alex
