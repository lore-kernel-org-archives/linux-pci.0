Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852687;
	b=da6q9Oj82/vKPE8UhbSWC8Y8zpS1XmnjPSaI50JlJPSaVsgElEwzm0L9gfY9NCQG7SWz
	 FBdnFu8FbAPKnHLG/1kyuxRZYUE251chV2vsWpQXAu6pcoyxkLw94YlOl7sZFM1wp3wsc
	 gs+t/Q8knurRpFvago8Vs1VzM6TotJuWC9AlkOB5kn3YzRRCxarnWg5NqWioPA9h2oN9e
	 oWN3WMi8FTYRFdhz5Rsq+g5lYaReEfzMas1lUdFwtuk6A7nORGA5pBtLqr4J5swi2v+QM
	 y4A2590g9T3n6GYOt5oZ/PzeHuXMopbzNsU5EbOiKW9eZ6KilBj8PQm8pU1r+UmYvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852687;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
	b=R/cqwTcAQWpWHEhPKKKLqw2jrBVGCDVU7IjM9eJqlAS76nKaeAxqoohcD4y+ljlA1hDo
	 ju00BnM2Z8955n4/bRQhoIPN8Afj7lTaNBHNzZv2+6qjI3YbQKngvNiyelnNXI43T0tvf
	 SBG4T+wCcrgFXPdtNW9oJaRoJ/9Fvc38UKHNVh+brT7nB1BMYH+/UEQ8eVjQsaEuwUpqD
	 bPFGNUlVR1eUPOSBDUYySroHA34Bpm7qFSHk5HcCkhRG3V9kKAc9JQ7Gr5Grnnj1G148X
	 lYE2afPE69oWDB5fL4qncgCwd51ndpCiDWy7zlvd6FcD2LwEbsGZv5itr0INXQ//mIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ajwl/Ojj";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TVZ6sfEX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F422606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F422606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ajwl/Ojj;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TVZ6sfEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794852686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
	b=Ajwl/OjjU5CmBV2ebqc5nd8B3NwdIZUk3pBbEdH/nXSz5T5A/wvuJ73FJUEw5KBQK+x/+Z
	takwPZu9iQZDEOc6y8reYr7KIQErkFkIn5wT9ffdJ7tTd3r1VI1QZXsIfOoPWoOZigKxy/
	83BDxVPOOzZ8sabO3s7HI5EVT24Khp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-dxVEELmdObydShSSi5QobQ-1; Mon, 16 Nov 2026 13:11:24 -0500
X-MC-Unique: dxVEELmdObydShSSi5QobQ-1
X-Mimecast-MFC-AGG-ID: dxVEELmdObydShSSi5QobQ_1794852683
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so2465973f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794852683; x=1795457483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
        b=TVZ6sfEXCiZZMnkVHVsfBCoMNa24jRM6/8XKC7Etpi4QiTOZthuZrBAfCt1u7i9vqZ
         Xhis0lDO+/BLOLmamYdKkaj6qtG1L/fOtvgoLOhdbcU+CmrC8H69tHkyEl8t+qGaQmud
         PRhLL6W6jKdPI0PiAb1iJOJSVRCaSJZONJjdHk/y3RVagk8oWiFkvMsHoPXhfLLFWR2b
         Tlr+WIz8NkZtWP0jWnGsh6tOFhMqcRmrLj2AlOtVmZWfw0wTVw/9SnAjYbR1UiSppTwT
         yVB7JovPdhNrIHh0PujhIfBQmp/T6/DvyMiLNb5TleZOpO8qxDeEKffBqc2dOcYl7PZZ
         DteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852683; x=1795457483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
        b=lNnKoLuYfyWOmt2HeOCPGb49uvzeRDsEj+fx2ZZAfplmOpJW1SvRZx7K8Tl7jLAYW5
         0DhH0f9Csyw0cDxRU/H5/87TTgCNOaQYozlVt4hYClTo64Qx7xl7Fk+egKVtR3YOHEY3
         f9RMjok+7meC2tnFI8H+zWDdEHl1N3G2sBexOhXRxQJbR4+g1CdG+eUKcfmar97GEB5p
         ePJMtY1kib2h1zKnL7yf3bNioevbxlEK8yF+nVXREJxWniTLbnXji7xxDx+eORomLJVj
         NSMjmSCA/p4biYnn1IP1bslPJ3sZKxzkk0nXNXQAY4vwSmRRabrcT8GKMEA6PvopccVi
         JNNQ==
X-Forwarded-Encrypted: i=1; AL+hErEe/jGqLgDcl5NavN7pz7gayxbK37FFoHND9hFD06RMYuAxioKgNKyf6LCxTo4OuXmBJJDLnA5v5is=@vger.kernel.org
X-Gm-Message-State: APuU4Z/k1jhipaV8S4lYo6LOtkaz3FldhQeRiKhCguMxzmdv995E7cAG
	bW/Maho5wsnonJdm9YJh6Z2K5PYgec2jiVUE5MOhsfLW712m0eWHUFAcObZgTGuDLarDGp6rgUy
	OiIy17dBYj9dEyeqg4mQjateK9MUr8+WqSOiudJmrn1i0BH+QdJpDBQnm7ALsBQ==
X-Gm-Gg: AZFdTZcYEE6IIOCh7mQx1IEg23g3H47Mdu50RxxOClgI9jXw2rEPBgAhqPem69tDOkA
	mXWk+u6O8jmMsaaBMucMwPXY6Z4Bkx5g0etVn20ltKytn+tI70t4mAYRkmUFI/yYdvbo6gE1iW4
	hSNAmjc4eOinGBkqrEJOvqXRAiWaef5bTnAOSd8k9Vffw3N/hKr+zCYcSYHKC2WWWV/6WUtfdyq
	SGr89jdc+0xgxeqx39ixkfVtLDV+SVmhib5ezq7OVx0qx+4Lj55cw2hAOV3lRlFXzgnyYuW6IiU
	5oNH4CGp6UIeHaUwB14eY37nxf5m/kOG0ykaqemez07f88AgbPGivo7DNGBuhNbBNUhouBl8Lqx
	vl3C/9MJdAvlMsOGETPwz4yE+nf1Rpgp6GYt6a0aDCg==
X-Received: by 2002:a5d:59c9:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49c72ba7408mr23907909f8f.52.1794852683013;
        Mon, 16 Nov 2026 10:11:23 -0800 (PST)
X-Received: by 2002:a5d:59c9:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49c72ba7408mr23907826f8f.52.1794852682303;
        Mon, 16 Nov 2026 10:11:22 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c6451sm25043648f8f.45.2026.11.16.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:11:21 -0800 (PST)
Date: Mon, 16 Nov 2026 13:11:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Ott <seott@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20261116131025-mutt-send-email-mst@kernel.org>
References: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>
 <20261116121123-mutt-send-email-mst@kernel.org>
 <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>

On Mon, Nov 16, 2026 at 07:03:23PM +0100, Sebastian Ott wrote:
> On Mon, 16 Nov 2026, Michael S. Tsirkin wrote:
> > On Mon, Nov 16, 2026 at 05:52:23PM +0100, Sebastian Ott wrote:
> > > Hej Folks,
> > > 
> > > using ACPI PCI hotplug with qemu on ARM for a device with a
> > > BAR > 2M fails because of a resource allocation failure in the
> > > guest kernel.
> > > 
> > > Without ACPI hotplug the same usecase works because the native
> > > PCIe hotplug controller would increase the resource window of
> > > the parent PCI bus.
> > > 
> > > X86 shows the same behavior but default resource window sizes
> > > are different and qemu can use ACPI DSM #5 to hint the guest
> > > to keep larger (predefined) resource windows.
> > > 
> > > Efforts to adapt that behavior in qemu on ARM failed [1]
> > > because they've caused regressions elsewhere and maintainers
> > > thought that Linux hotplug controller should be changed.
> > > 
> > > But this also has been tried before:
> > > 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > > 
> > > Unfortunately that led to regressions as well [2] and the patch was
> > > reverted:
> > > 5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")
> > > 
> > > I've tried the reproducer mentioned in [2] using recent kernels for a
> > > couple 1000 times and didn't ran into issues.
> > > 
> > > Could we give this patch another shot? Or does someone have another idea
> > > on how to make ACPI PCI hotplug work with large BARs without breaking
> > > something else.
> > > 
> > > [1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/
> > > [2]
> > > https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/
> > > 
> > > Thanks,
> > > Sebastian
> > 
> > Why would trying the same thing again lead to a different outcome?
> > At a minimum, I'd expect an explanation what changed.
> 
> I couldn't reproduce the reported issue with scsi hotplug on recent
> kernels. I have not done a bisect though since I couldn't even build
> the kernel for which the issue was initially reported with recent
> toolchain. So I can't answer what exactly made the issue go away.
> 
> Sebastian

Try reposting and including info on what testing you did.

-- 
MST

