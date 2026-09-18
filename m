Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6D4DEC22;
	Fri, 18 Sep 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729258; cv=none; b=FVQp2vWjw9DkBC6oN+GadxXIRPtUa/hL8wb1wRc9KY+OyK04i+sPx8iQr6rpPPHRbn/HLOeW+mCRrVs3Daq6cgEWTdRjawj04QGg8K2TapYqluaSaaQcNJ9YvlO3IRhm2MhKRUz2rEM8WNHhIm91azj4ElWEBqA9coThBgJjR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729258; c=relaxed/simple;
	bh=gVUYx2dOVJqTII3X9FjwQ7gUD2UY2GUKlymHS2FDOBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOF4FErjkgxSMDA1YOmXCYH8CK4R9JfASp+2VHAmFb7gEU61vvq3i0zzGf0nu3pVXGuCtvZWofJ+h5GE/ly2AdboM/tePyZuwx+Ef7gCrtdcPJz5gFa4L3vc8jg+UCzrT4v9VpekRvzFvjJdyAX17EeeiuPzKeuKCH4AAh/ibaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=j2JWkD3s; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="j2JWkD3s"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hmV5v6bQKz4BsF;
	Fri, 18 Sep 2026 13:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789729235;
	bh=gVUYx2dOVJqTII3X9FjwQ7gUD2UY2GUKlymHS2FDOBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j2JWkD3s8AZ0P+BX/AkjoXJI1VJva8Kk344VAXH/quFhbjMiJO4BAp3dgEfcObQ0w
	 dkNGzYZxsjxeMSUdzJZpYjCwIA7QSLVNpDaEmmlSyCANQO9VteZRmj9/Afo6zVNoNb
	 n3zDHkU7StRSgwVbF/aKnnMpTZTtm7dxGJZEt/yqsQuNAp+gXNQKrgH04XVll8jUBd
	 xrCGNcvpI8VPgQxjtjZJvlRttEaTETB2SaYiY3rfd9t734EHD0P63fk5Vx/OgUiBRL
	 ArTT91KEAXfnVe8YWg8TmtPmbreiZnCV40rsIJKMhOWkjCJpRJVvHL45nBAccCFawI
	 Qf1neuZUB2qvw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hmV5K628Cz4Cn7;
	Fri, 18 Sep 2026 13:00:05 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hmV5K1P80z8sch;
	Fri, 18 Sep 2026 13:00:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 685FC5F949;
	Fri, 18 Sep 2026 13:00:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6846f455-fc77-4cec-974f-6b9d72ae0654@leemhuis.info>
Date: Fri, 18 Sep 2026 13:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>,
 regressions@lists.linux.dev
References: <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178972920486.686618.11852165451493012845@mxe9fb.netcup.net>
X-NC-CID: MZlRa8Hguy5St8D9XDiCRIjyBNIzUNoCfoLkOHnXxDd7DmDRMZo=

On 9/18/26 12:39, Maciej W. Rozycki wrote:
> On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:
> 
>>> But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
>>> 2.5GT/s restriction in PCIe failed link retraining") even with this
>>> patch
>>> (https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)
>>>
>>> And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
>>> this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)
>>>
>>> So evidently there are still issues but maybe this patch fixes part of
>>> them?
>> Yeah, Maciej ten days expressed that we to look into this. Anyway, I
>> suggest someone that is affected by that problem starts a new thread
>> (please CC all those that are affected by it and the regression list)
>> with summarizing the current state + this patch, as this thread got a
>> bit confusing... (please drop a link to that thread here afterwards)
>
>  It remains on my radar, no worries.  Hectic time here, a lot is going on.  
> I'll do my best to look into it as soon as possible.  Also I'll be at LPC 
> in Prague in a couple of weeks' time, so this may be an opportunity to 
> discuss the issues in person.
Sorry, I didn't want to prod you; I mainly wrote what I wrote because
the reports about the two problems got mixed up, so things became
confusing -- which is why I think a new thread starting with a summary
might be best for all of us.

That being said and wrt to the "a lot going on": seems this causes some
devices to not work for iirc at least two reporters. Would it maybe be
better to revert the culprit and reapply it later once that is sorted
out? Or is this not an option or a bad one for some reason? Reminder,
normally Linus in a situation like this wants regressions ideally 'fixed
"within a week", preferably before the next rc':
https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2BLsMyJmcuMSA@mail.gmail.com/

Ciao, Thorsten
