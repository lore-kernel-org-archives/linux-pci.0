Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84B2BD11;
	Mon, 20 Apr 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689357; cv=none; b=ThPHdJuBErSqVKhXJT/sDmY3DTgOItzTKTodMjmgpCpXTqY51EK1+l52yETkPMMSmtTujVKQCVnETpE1b9K6g0BFPNuBhXGtIMSj+U5bMw7cZwFb4f1B7Elxv+j8HFZuKxABFSdId4JxcB14ovzC2SucyYZP/zBabfsfzTm4c3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689357; c=relaxed/simple;
	bh=o5MRvCMq9+Ah279lX3jtEJBzR1Uuz9D0PrSLa9khD7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRt89u3VbvgKOH+BWVYumNuEcF9SVZ8h5xafoE+gyRqEPIqmhryfU8RPm8ry+DWs15yJb54eux4pXKtgEKmtGBE+OdJAGDhftGc6TWHwa1iaJReh38BbA/3sIreCKIYB8lymuDGjMRXZRCKk1PwnP2WGw4Sv5/F3QdY4wmL+fKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=KcOTuG9V; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="KcOTuG9V"
Message-ID: <e7ff4327-3d34-4b8f-9c60-8aa6ff1ef7c1@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1776689342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BUXAXiNOpEKIJxRQsDw6JveUMIEsPUifEwts9civuA=;
	b=KcOTuG9VSVFf36sZsOmypGq2y+zdew9nmtfYMRenpXvSQ9YG6TE/GjEW4YX1yOpUWlmY7p
	lF1o6FrJe5twknxxusevKeiofPPli30Nven9D5McNiHztHZ313gpp4QIzFJ+MpYh6UMtAz
	S5jzqeHtEuKNJ4c2wHjESnT0MpEz58qov746VAlHmXshJGJjzXNWrJWARfEKOTF7ZFQ1Rf
	GhTKcwRAutbR3Irm6mcfeapRIpEdYw53Hi+KREhkhR+WxHzomen+jJQmOBfztmI/HIbzdF
	anmlNXs2cUI/jlpWExc1+ao4cAZLwNu0PgDPOorICWNhQEpn/OZzWZY+C/TM9w==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
Date: Mon, 20 Apr 2026 15:49:01 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: vfio/pci: Qualcomm PCIe WiFi devices drop link during FLR causing
 host AER crash
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <70de9b8f-b7c7-481b-8cb1-931e3b82eb0e@mokrynskyi.com>
 <20260420122444.GN2577880@ziepe.ca>
 <f732deb0-18e8-422a-923b-0e1c7e2c290b@app.fastmail.com>
Content-Language: en-US, uk, uk-UA
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
In-Reply-To: <f732deb0-18e8-422a-923b-0e1c7e2c290b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ---

This is happening on Gigabyte MZ32-AR0 motherboard with AMD Epyc Zen 2 CPU.

Non-vfio PCIe errors did not crash the system when I observed long time ago.
This case with VFIO is the only one that crashes my system right now, but I have no idea how to debug this to provide more info, so let me know if there is something I can do.
Maybe there are different kinds of errors and only some of them cause the machine to crash?

I just get this after system resets shown by BIOS:

> Warning: PCI-Express PERR/SERR error detected.
No such issue with these devices on the host, at least from what I observed and read online.

Running them under VM also requires the following hacks (libvirtd) that I have not found a way to get rid of (yet):

> |<features> <ioapic driver="qemu"/> </features> <devices> <iommu model="intel"> <driver intremap="on" caching_mode="on"/> </iommu> </devices>|
With all this the device does work, I'm using it right now.
But I can't turn off or reboot the VM without crashing the host at the same time, which is suboptimal.

Sincerely, Nazar Mokrynskyi
github.com/nazar-pc

20.04.26 15:44, Alex Williamson:
>
> On Mon, Apr 20, 2026, at 6:24 AM, Jason Gunthorpe wrote:
>> On Sat, Apr 18, 2026 at 12:24:07AM +0300, Nazar Mokrynskyi wrote:
>>> Several Qualcomm PCIe WiFi devices drop their PCIe link as part of their
>>> internal reset sequence. Under bare metal this is transparent because the
>>> host root complex performs link retraining automatically. Under VFIO
>>> passthrough, the link-drop generates an uncorrectable AER error that
>>> escalates through the parent bridge to the host, crashing it.
>> If AER's crash the system then it is not compatible with VFIO, IMHO.
>>
>> For VFIO to work as designed the platform must be able to safely
>> contain all the errors the PCI device can generate.
> Aren't these also the WiFi devices that we tried to quirk because the driver writes the guest view of the MSI address/data elsewhere in the device which breaks interrupt virtualization?  The quirk was very fragile and never got merged, so I'm not sure how these devices are even useful with vfio.  Thanks,
>
> Alex
