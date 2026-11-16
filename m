Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852234;
	b=fZgqMYt0iJ36xUc3M8Wts6rXFx8ewuaYNKKG9+PIHKe7ndA1v7vBHueLIigvwB0E3fq5
	 lnvTsjS4KnD4s5HvrOQXQFztBY63/3i4KfJaGOtWxl7eG46tNqrepbKPoMkSzBm62GjEW
	 6PRv6qk6f1jWesdGOENNPkILtd9hz8Qm+kb4w1eL2Y6dcrCqa4bVHxnWGyvfuYzeGgEUx
	 AkdgXNz23/hQCQ0UowXsrGFuF0+WH8DhiEyxx+wA9mwMWqDRD9fCzYjDnJrrXJoJtCEw8
	 0WghcBMAfvM2HRGzrC0sryfOflCjm3O88M8Bd8U/IBo8yGDXefUXZgriyyCaCbcOHpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
	b=p+X9rvHmj6ERrsHmoFozCZDJMFk9dvrnWXQiNA27jY/IhOifu2/EUXDbydo8/P8ZdPPu
	 Z8XW5fhjW+dgd6hsZ1xzLwQdW10/SpkXR8PUJXH35H+Q7NaGySRc8hU/Rq5lc4Ux3afJe
	 /WHJQTbISX5PsYQvCAtr7ehD+HUTmeOHsdgvuYqTqOo9Y2ioN4gN0SO5mmdeyItmo2HVl
	 cCflJcLxXwpVKMhzk98vB25ubtFVhihT6Z/iw7Q8gDgCDUQ5e6zl/DYPWt0bXJw7HB6pD
	 16ymX++DunBRkWR9zdhWVoeO6i0Wv55GFQnCQ76S44Wf9pS5gJqHlfFWnnxeIK3Moiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTeFiAMZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=brGP6Ba7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E8606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767E8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTeFiAMZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=brGP6Ba7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794852232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
	b=ZTeFiAMZLMsWdEcYBJ9gxR6Ohjcdi3TKdY2jQS0kMjGh+uJUxW1ZAZR+hBQmPvOvuYZCAY
	nGfZKABSsfrLN+FLytgSaiI8r/+qQrhlICvU8EvFwR8BvqHUwacph10A7ecSEvgzDvkE9d
	+KMXKXOxLa+8HJP4SttYvCO8T5BzdZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-H3lZmzH1M1GMSpd4KPxyXw-1; Mon, 16 Nov 2026 13:03:26 -0500
X-MC-Unique: H3lZmzH1M1GMSpd4KPxyXw-1
X-Mimecast-MFC-AGG-ID: H3lZmzH1M1GMSpd4KPxyXw_1794852206
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso18025485e9.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794852205; x=1795457005; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
        b=brGP6Ba7PSOK+rJmlZw4V7dx2J/TaHAtgZ43pfjitPEKar5AdDJXCPHn3t7Vqpjcl9
         okXjyzVE+P/RcveEr6oDahHraSA+k9VvDKt8eC1jIhqbq+mCSXsyH8at8DnsuwB2RsiA
         3sXAmAYmwfD8T41ZJEqDCHjb5lUdHTpXnrERaP8iKuSXOS/rIa1VgLsGrL5iyN/JjHts
         c/J6UnNcl708YDawZ+caL+J3P6K6Ksbwbo7lL3W3KKg43PA95RYMHIY46Y1Xb+NHL8UK
         ezacZY7boIcgWRIpbEPCAj7KK8Zdb5LdB7xmNQrn4VnVGKC6AobBytdM5Lx5P+KgENJ7
         4L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852205; x=1795457005;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
        b=BINqTgBdwBC56tpJdYzIc8wnqNWize7Lm8MzoxHQCgToRCBOVfaV6K/ewd4nio5/1u
         mffpdcsWuDM6jZSFCCTwWLefYLE/RjDfVnK9ICVOdaM3ADAMlHNVeZosysZetpeKoMvi
         aPVv+TZeCLmGLHu8fM777gu6ymZMDgHIIWaIBKWzc3QAPZUWXeO/aruhxbiS1FoQUi3o
         d1kJ2WIIFbwpZsxfu+clxtdHJgqZ1uDLJq/HaA/fJiwakc38Im90uT0w3K7NFJIhgsD1
         TRZSxrP4piiJAl7ifEo9o1bDu5WXtGld+6gArr0i02JLB03jMSLHeNEoE0MejhZ76m3F
         B36A==
X-Forwarded-Encrypted: i=1; AL+hErFC6bkJKa7LJSxvofuBm9jEcxP00lU4xk4psZ2J8BELlXbLaYEGfRsYt6NZRsDIIICgpQO8Q5oDlDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yQ4mVdHpXLDELonOPIMMSrwsshQvXTWfCzOTn7vEX+A/lv3nM
	NxMUrVJVUGlD9kntN/+zYie3V+rqtVIoWWQfeR29WcQQPQY+7y0esy297v+EnOSODeB7o2vtlJ7
	+C0yAYLif58Bstb7ioOx5xjjnASbf9y4QJdU3/4br1CKncRH8lhejnDku99hLLQ==
X-Gm-Gg: AYBFou3nUpJcXKMqzvjnV1LEQZFTgHzZZGTPF/RXH/hTt1hNwvshz2PlLYNfkvuuZ6Z
	885v+xLrrXVV2nXFdEoI5KwgoxRuQeDvPzx4/ldh//QiYEekbvl2Nppg/TIuMg1ETjx6kPrZ8pT
	RbHPXhfW3b15jJsjtZj3tuRYmqb5crgGAhzSdA1ZDLquwVvtu9RdBr3SXzj/3P4bN4E81h1c2Ez
	IrorzEvSc5x/ej4hZqAyisVBpZu0kmFfYUCawbiDJ69V6gd6SNqvcjLA7sYkVdhjCewLQiHapEY
	my8TjsLuIDhbYWxhv8ygJ+oCHfYEa8lSAQtAJvVzHCt8Tp77WMzg8WZBErtJ9at4sOFcbGSAzt8
	pjQMwdD3uwqynO5QQGYCsQoOSX83nKmoLGmBZ5TAmZv5eOmn87MS3Mlyo3RUwuV3tBFkAHlD0gR
	asZMc1tlk1rWhSxIJ8rdBcDW6vwQDPxJmDqxhIIg==
X-Received: by 2002:a05:600c:8b65:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb6a5a795dmr108705615e9.18.1794852205589;
        Mon, 16 Nov 2026 10:03:25 -0800 (PST)
X-Received: by 2002:a05:600c:8b65:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb6a5a795dmr108705085e9.18.1794852205147;
        Mon, 16 Nov 2026 10:03:25 -0800 (PST)
Received: from seott-rh (p200300f6af3d8001f2fecaef96c12e29.dip0.t-ipconnect.de. [2003:f6:af3d:8001:f2fe:caef:96c1:2e29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm4126565e9.13.2026.11.16.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:03:24 -0800 (PST)
Date: Mon, 16 Nov 2026 19:03:23 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Igor Mammedov <imammedo@redhat.com>, 
    Fiona Ebner <f.ebner@proxmox.com>, linux-acpi@vger.kernel.org, 
    linux-pci@vger.kernel.org
Subject: Re: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
In-Reply-To: <20261116121123-mutt-send-email-mst@kernel.org>
Message-ID: <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>
References: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com> <20261116121123-mutt-send-email-mst@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 16 Nov 2026, Michael S. Tsirkin wrote:
> On Mon, Nov 16, 2026 at 05:52:23PM +0100, Sebastian Ott wrote:
>> Hej Folks,
>>
>> using ACPI PCI hotplug with qemu on ARM for a device with a
>> BAR > 2M fails because of a resource allocation failure in the
>> guest kernel.
>>
>> Without ACPI hotplug the same usecase works because the native
>> PCIe hotplug controller would increase the resource window of
>> the parent PCI bus.
>>
>> X86 shows the same behavior but default resource window sizes
>> are different and qemu can use ACPI DSM #5 to hint the guest
>> to keep larger (predefined) resource windows.
>>
>> Efforts to adapt that behavior in qemu on ARM failed [1]
>> because they've caused regressions elsewhere and maintainers
>> thought that Linux hotplug controller should be changed.
>>
>> But this also has been tried before:
>> 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
>>
>> Unfortunately that led to regressions as well [2] and the patch was
>> reverted:
>> 5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")
>>
>> I've tried the reproducer mentioned in [2] using recent kernels for a
>> couple 1000 times and didn't ran into issues.
>>
>> Could we give this patch another shot? Or does someone have another idea
>> on how to make ACPI PCI hotplug work with large BARs without breaking
>> something else.
>>
>> [1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/
>> [2]
>> https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/
>>
>> Thanks,
>> Sebastian
>
> Why would trying the same thing again lead to a different outcome?
> At a minimum, I'd expect an explanation what changed.

I couldn't reproduce the reported issue with scsi hotplug on recent
kernels. I have not done a bisect though since I couldn't even build
the kernel for which the issue was initially reported with recent
toolchain. So I can't answer what exactly made the issue go away.

Sebastian

